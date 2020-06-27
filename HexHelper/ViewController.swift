//
//  ViewController.swift
//  HexHelper
//
//  Created by Casper Sørensen on 21/06/2020.
//  Copyright © 2020 TheParallelThread. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var inputField: NSTextField!
    
    @IBOutlet weak var outputField: NSTextField!
    
    @IBOutlet weak var inputModeSelector: NSPopUpButton!
    
    @IBOutlet weak var outputModeSelector: NSPopUpButton!
	    
    @IBAction func inputModeSelected(_ sender: NSPopUpButton) {
		outputField.stringValue = computeResult(for: inputField.stringValue, as: inputModeSelector.mode(), to: outputModeSelector.mode())
    }
	
    
    @IBAction func copyButtonClick(_ sender: NSButton) {
		let clipboard = NSPasteboard.init()
		clipboard.clearContents()
		clipboard.setString(outputField.stringValue, forType: .string)
    }
    
    @IBAction func outputModeSelected(_ sender: NSPopUpButton) {
		outputField.stringValue = computeResult(for: inputField.stringValue, as: inputModeSelector.mode(), to: outputModeSelector.mode())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputModeSelector.addItems(withTitles: ["Auto Detect", "Decimal", "Binary", "Hex", "Octal"])
        outputModeSelector.addItems(withTitles: ["Decimal", "Binary", "Hex", "Octal"])
        inputModeSelector.selectItem(at: 0)
        outputModeSelector.selectItem(at: 0)
		outputField.isSelectable = false
		outputField.isEditable = false
		outputField.isEnabled = true
    }
    
    func controlTextDidChange(_ obj: Notification) {
		outputField.stringValue = computeResult(for: inputField.stringValue, as: inputModeSelector.mode(), to: outputModeSelector.mode())
    }
	
	func computeResult(for input: String, as inputMode: Mode, to outputMode: Mode) -> String {
		var decimalInput: Int?
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
				decimalInput = Int(inputField.stringValue)
			case .Hex:
				decimalInput = inputField.stringValue.convertHexToDecimal()
			@unknown default:
				fatalError("Unknown input mode")
		}
		print(input)
		print(inputMode)
		print(outputMode)
		print(decimalInput)
		guard let dec = decimalInput else {return "Error input could not be validated"}
		
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

