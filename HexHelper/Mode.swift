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
    case Ascii
    case utf8
    case utf16
    case utf32
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
        case "Ascii":
                return .Ascii
        case "UTF-8":
            return .utf8
        case "UTF-16":
            return .utf16
        case "UTF-32":
            return .utf32
			default:
				return .Binary
		}
	}
}
