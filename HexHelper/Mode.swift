//
//  Mode.swift
//  HexHelper
//
//  Created by Casper Sørensen on 26/06/2020.
//  Copyright © 2020 TheParallelThread. All rights reserved.
//

import Cocoa

enum Mode {
	case Auto
	case Binary
	case Hex
	case Octal
	case Decimal
}

extension NSPopUpButton {
	func mode() -> Mode {
		switch self.selectedItem?.title {
			case "Auto Detect":
				return .Auto
			case "Hex":
				return .Hex
			case "Decimal":
				return .Decimal
			case "Octal":
				return .Octal
			default:
				return .Binary
		}
	}
}
