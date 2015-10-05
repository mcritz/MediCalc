//
//  Dose.swift
//  Medicalc
//
//  Created by Critz, Michael on 10/5/15.
//  Copyright © 2015 Map of the Unexplored. All rights reserved.
//

import Foundation

class Dose {
    
    var numFormatter: NSNumberFormatter {
        set {
            newValue.locale = NSLocale.currentLocale()
            newValue.roundingIncrement = 0.01
        }
        get {
            return self.numFormatter
        }
    }
    
    func doubleFromString(numString: String?) -> Double {
        guard let numStr = numString as String! else { return 0 }
        let numFormatter = NSNumberFormatter()
        numFormatter.locale = NSLocale.currentLocale()
        let someNumber :NSNumber? = numFormatter.numberFromString(numStr)
        guard let someDouble = someNumber as? Double else { return 0 }
        return someDouble
    }
    
    func updateResult(dose: String?, weight: String?) -> String {
        return formatDose(calculate(doubleFromString(dose), weight: doubleFromString(weight)))
    }
    
    func formatDose(num: Double) -> String {
        let numFormatter = NSNumberFormatter()
        numFormatter.locale = NSLocale.currentLocale()
        numFormatter.roundingIncrement = 1
        return numFormatter.stringFromNumber(num)!
    }
    
    func calculate(dose: Double, weight: Double) -> Double {
        return dose * 3 / weight
    }
}