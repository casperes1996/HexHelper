//
//  ViewController.swift
//  HexHelper
//
//  Created by Casper Sørensen on 21/06/2020.
//  Copyright © 2020 TheParallelThread. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet weak var headerView: NSView!
    
    @IBOutlet weak var inputField: NSTextField!
    
    @IBOutlet weak var quitButton: NSButton!
    
    @IBOutlet weak var outputField: NSTextField!
    
    @IBOutlet weak var inputModeSelector: NSPopUpButton!
    
    @IBOutlet weak var outputModeSelector: NSPopUpButton!
    
    
    static var savedInput = String?(nil)
    static var savedInputMode = Mode.Auto
    static var savedOutputMode = Mode.Decimal
    
	    
    @IBAction func quitApplication(_ sender: NSButton) {
        exit(0)
    }
    @IBAction func inputModeSelected(_ sender: NSPopUpButton) {
		outputField.stringValue = computeResult(for: inputField.stringValue, as: inputModeSelector.mode(), to: outputModeSelector.mode())
    }
	
    
    @IBAction func copyButtonClick(_ sender: NSButton) {
		let clipboard = NSPasteboard.general
		clipboard.clearContents()
		clipboard.setString(outputField.stringValue, forType: .string)
    }
    
    @IBAction func outputModeSelected(_ sender: NSPopUpButton) {
		outputField.stringValue = computeResult(for: inputField.stringValue, as: inputModeSelector.mode(), to: outputModeSelector.mode())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quitButton.toolTip = "Quit HexHelper"
        inputModeSelector.addItems(withTitles: ["Auto Detect", "Decimal", "Binary", "Hex", "Octal"])
        outputModeSelector.addItems(withTitles: ["Decimal", "Binary", "Hex", "Octal", "Ascii", "UTF-8", "UTF-16", "UTF-32"])
        inputModeSelector.selectItem(at: 0)
        outputModeSelector.selectItem(at: 0)
		outputField.isSelectable = false
		outputField.isEditable = false
		outputField.isEnabled = true
        if let savedInput = Self.savedInput {
            inputField.stringValue = savedInput
        }
        inputModeSelector.selectItem(withTitle: Self.savedInputMode.rawValue)
        outputModeSelector.selectItem(withTitle: Self.savedOutputMode.rawValue)
        outputField.stringValue = computeResult(for: inputField.stringValue, as: inputModeSelector.mode(), to: outputModeSelector.mode())
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        inputField.becomeFirstResponder()
    }
    
    func controlTextDidChange(_ obj: Notification) {
		outputField.stringValue = computeResult(for: inputField.stringValue, as: inputModeSelector.mode(), to: outputModeSelector.mode())
    }
	
	func computeResult(for input: String, as inputMode: Mode, to outputMode: Mode) -> String {
        defer { Self.savedInput = input; Self.savedInputMode = inputMode; Self.savedOutputMode = outputMode }
        if input.isEmpty { return  "" }
		var decimalInput: Int64?
		switch inputMode {
			case .Auto:
				guard let actualMode = identifyMode(for: input) else {
					return "Error"
				}
				return computeResult(for: input, as: actualMode, to: outputMode)
			case .Binary:
				decimalInput = inputField.stringValue.convertBinaryToDecimal()
			case .Octal:
				decimalInput = inputField.stringValue.convertOctalToDecimal()
			case .Decimal:
				decimalInput = Int64(inputField.stringValue)
			case .Hex:
				decimalInput = inputField.stringValue.convertHexToDecimal()
			@unknown default:
				fatalError("Unknown input mode")
		}
		guard let dec = decimalInput else { return "Invalid input. May exceed 64-bits or contain invalid characters" }
		
		switch outputMode {
			case .Binary:
				guard let answer = dec.convertDecimalToBinary() else {return "Could not convert"}
				return answer
			case .Octal:
				guard let answer = dec.convertDecimalToOctal() else {return "Could not convert"}
				return answer
			case .Decimal:
				return String(dec)
			case .Hex:
				guard let answer = dec.convertDecimalToHex() else {return "Could not convert"}
				return answer
            case .Ascii:
                return dec.convertDecimalToChar(using: .ascii)
            case .utf8:
                return dec.convertDecimalToChar(using: .utf8)
            case .utf16:
                return dec.convertDecimalToChar(using: .utf16)
            case .utf32:
                return dec.convertDecimalToChar(using: .utf32)
			case .Auto:
				return "How did you set output to auto?"
			@unknown default:
				fatalError("Unknown output state")
		}
		
	}
	
	func identifyMode(for input: String) -> Mode? {
		if input.starts(with: "0x") {
			return .Hex
		} else if input.starts(with: "00") {
			return .Binary
		} else if input.starts(with: "0o") {
			return .Octal
		} else {
			return .Decimal
		}
	}

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

