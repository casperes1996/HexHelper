//
//  DecimalConverters.swift
//  HexHelper
//
//  Created by Casper Sørensen on 27/06/2020.
//  Copyright © 2020 TheParallelThread. All rights reserved.
//

import Foundation

extension Int64 {
	
	func convertDecimalToHex() -> String? {
		String(format: "%02x", self)
	}
	
	func convertDecimalToOctal() -> String? {
		return String(self, radix: 8)
	}
	
	func convertDecimalToBinary() -> String? {
		return String(self, radix: 2)
	}
    
    func convertDecimalToChar(using encoding: String.Encoding) -> String {
        var cCharArray = [UInt8(truncatingIfNeeded: self),
                          UInt8(truncatingIfNeeded: self >> 8),
                          UInt8(truncatingIfNeeded: self >> 16),
                          UInt8(truncatingIfNeeded: self >> 24),
                          UInt8(truncatingIfNeeded: self >> 32),
                          UInt8(truncatingIfNeeded: self >> 40),
                          UInt8(truncatingIfNeeded: self >> 48),
                          UInt8(truncatingIfNeeded: self >> 56)
                        ]
        cCharArray = cCharArray.compactMap { if $0 == 0 { return nil } else { return $0 } }
        let byteCountModulo = encoding == .utf16 ? 2 : encoding == .utf32 ? 4 : 1
        while cCharArray.count % byteCountModulo != 0 {
            cCharArray = cCharArray + [0]
        }
        return String.init(bytes: cCharArray.reversed(), encoding: encoding) ?? "Invalid value for selected encoding"
    }
}
