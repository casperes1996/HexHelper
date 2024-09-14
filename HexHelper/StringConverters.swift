//
//  StringConverters.swift
//  HexHelper
//
//  Created by Casper Sørensen on 26/06/2020.
//  Copyright © 2020 TheParallelThread. All rights reserved.
//

import Foundation

extension String {
	
	func convertHexToDecimal() -> Int64? {
		convertToDecimal(radix: 16)
	}
	
	func convertBinaryToDecimal() -> Int64? {
		convertToDecimal(radix: 2)
	}
	
	func convertOctalToDecimal() -> Int64? {
		convertToDecimal(radix: 8)
	}
	
	private func convertToDecimal(radix: Int64) -> Int64? {
        var value: Int64? = 0
        var modifier: Int64 = 1
		for letter in self.reversed() {
			if let number32 = letter.hexDigitValue {
                let number = Int64(number32)
                let (newValue, overflow) = value?.addingReportingOverflow(modifier) ?? (nil, true)
                value = overflow ? nil : newValue
				if modifier == 1 {
					modifier += radix-1
				} else {
                    let (newModifier, overflow) = modifier.multipliedReportingOverflow(by: radix)
                    modifier = newModifier
                    value = overflow ? nil : value
				}
			}
		}
		return value

	}
}
