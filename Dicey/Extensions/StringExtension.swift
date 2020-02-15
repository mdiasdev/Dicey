//
//  StringExtension.swift
//  Dicey
//
//  Created by Matthew Dias on 2/11/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import Foundation

extension String {
    mutating func append(die: Die, count: Int) {
        if !self.isEmpty {
            self.append(", ")
        }
        
        self.append("\(count)d\(die.rawValue)")
    }
}
