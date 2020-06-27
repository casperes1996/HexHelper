//
//  StringConverters.swift
//  HexHelper
//
//  Created by Casper Sørensen on 26/06/2020.
//  Copyright © 2020 TheParallelThread. All rights reserved.
//

import Foundation

extension String {
	
	func convertHexToDecimal() -> Int {
		convertToDecimal(radix: 16)
	}
	
	func convertBinaryToDecimal() -> Int {
		convertToDecimal(radix: 2)
	}
	
	func convertOctalToDecimal() -> Int {
		convertToDecimal(radix: 8)
	}
	
	private func convertToDecimal(radix: Int) -> Int {
		var value = 0
		var modifier = 1
		for letter in self.reversed() {
			if let number = letter.hexDigitValue {
				value += number*modifier
				if modifier == 1 {
					modifier += radix-1
				} else {
					modifier *= radix
				}
			}
		}
		return value

	}
	
	
}
