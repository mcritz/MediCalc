//
//  Dose.swift
//  Medicalc
//
//  Created by Critz, Michael on 10/5/15.
//  Copyright © 2015 Map of the Unexplored. All rights reserved.
//

import Foundation

class Dose {
    
    var numFormatter: NSNumberFormatter
    
    init() {
        numFormatter = NSNumberFormatter()
        numFormatter.locale = NSLocale.currentLocale()
        numFormatter.numberStyle = .DecimalStyle
    }
    
    func doubleFromString(numString: String?) -> Double {
        guard let numStr = numString as String! else { return 0 }
        let someNumber :NSNumber? = numFormatter.numberFromString(numStr)
        guard let someDouble = someNumber as? Double else { return 0 }
        return someDouble
    }
    
	func updateResult(inputs: [String?]) -> String {
		var inputDoubles = [Double]()
		for input in inputs {
			guard let inputString = input as String! else { return "—" }
			if (inputString.isEmpty) { return "—" }
			inputDoubles.append(doubleFromString(inputString))
		}
//		guard let dose = dose as String! else { return "—" }
//		guard let weight = weight as String! else { return "—" }
//		if (dose.isEmpty || weight.isEmpty) { return "—" }
//        return formatDose(calculate(doubleFromString(dose), weight: doubleFromString(weight)))
		return formatDose(calculate(inputDoubles))
    }
    
    func formatDose(num: Double?) -> String {
		guard let num = num as Double! else { return "—" }
        return numFormatter.stringFromNumber(num)!
    }
    
	func calculate(inputs: [Double]) -> Double {
		var calculation = Double()
		for input in inputs {
			calculation += input
		}
		calculation -= inputs.last!
		calculation = calculation/inputs.last!
        return calculation
    }
}


class Flolan : Dose {
	func calculate(concentration: Double, weight: Double, rate: Double) -> Double {
		return weight * 60 / concentration * rate
	}
}
