//
//  Dice.swift
//  Dicey
//
//  Created by Matthew Dias on 12/7/19.
//  Copyright © 2019 Matthew Dias. All rights reserved.
//

import UIKit.UIImage

enum Die: Int, CaseIterable {
    case d4 = 4
    case d6 = 6
    case d8 = 8
    case d10 = 10
    case d12 = 12
    case d20 = 20
    case d100 = 100
    
    func image() -> UIImage {
        switch self {
        case .d4:
            return UIImage(named: "d4")!
        case .d6:
            return UIImage(named: "d6")!
        case .d8:
            return UIImage(named: "d8")!
        case .d10:
            return UIImage(named: "d10")!
        case .d12:
            return UIImage(named: "d12")!
        case .d20:
            return UIImage(named: "d20")!
        case .d100:
            return UIImage(named: "d100")!
        }
    }
}
