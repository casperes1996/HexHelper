//
//  DecimalConverters.swift
//  HexHelper
//
//  Created by Casper Sørensen on 27/06/2020.
//  Copyright © 2020 TheParallelThread. All rights reserved.
//

import Foundation

extension Int {
	
	func convertDecimalToHex() -> String? {
		String(format: "%02x", self)
	}
	
	func convertDecimalToOctal() -> String? {
		return String(self, radix: 8)
	}
	
	func convertDecimalToBinary() -> String? {
		return String(self, radix: 2)
	}
}
