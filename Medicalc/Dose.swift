//
//  Dose.swift
//  Medicalc
//
//  Created by Critz, Michael on 10/5/15.
//  Copyright © 2015 Map of the Unexplored. All rights reserved.
//

import Foundation

enum DoseType {
	case Empty
	case AdultKilgrams,
	MedicinceConcentrationNanogramsPerMilliliter,
	Rate
	
	func desc() -> String {
		switch self {
		case .Empty:
			return "—"
		case .AdultKilgrams:
			return "Kilograms"
		case .MedicinceConcentrationNanogramsPerMilliliter:
			return "nanograms per milliliter"
		case .Rate:
			return "nanograms per kilogram per minute"
		}
	}
	
	func startingValue() -> Double {
		switch self {
		case .AdultKilgrams:
			return 160
		case .MedicinceConcentrationNanogramsPerMilliliter:
			return 50000
		case .Rate:
			return 1
		default:
			return 0
		}
	}
}


class Dose {
	
    var numFormatter: NSNumberFormatter
	
    init() {
        numFormatter = NSNumberFormatter()
        numFormatter.locale = NSLocale.currentLocale()
        numFormatter.numberStyle = .DecimalStyle
		numFormatter.maximumFractionDigits = 2
    }
	
	func dataValues(type: DoseType) -> [Double] {
		switch type {
		case .AdultKilgrams:
			var someKg = [Double]()
			for kk in 45...200 {
				someKg.append(Double(kk))
			}
			return someKg
		case .MedicinceConcentrationNanogramsPerMilliliter:
			var someNgMl = [Double]()
			for mm in 1...100 {
				someNgMl.append(Double(mm) * 1000)
			}
			return someNgMl
		case .Rate:
			var someConcentration = [Double]()
			for cc in 1..<10 {
				someConcentration.append(Double(cc) / 10)
			}
			for bigC in 1...156 {
				someConcentration.append(Double(bigC))
				someConcentration.append(Double(bigC) + 0.5)
			}
			return someConcentration
		default:
			return [0]
		}
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
			guard let inputString = input as String! else { return DoseType.Empty.desc() }
			if (inputString.isEmpty) { return DoseType.Empty.desc() }
			inputDoubles.append(doubleFromString(inputString))
		}
		return formatDose(calculate(inputDoubles))
    }
    
    func formatDose(num: Double?) -> String {
		guard let num = num as Double! else { return DoseType.Empty.desc() }
		if (!num.isNormal) {
			return DoseType.Empty.desc()
		}
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
	
	func updateResult(weight: String?, concentration: String?, rate: String?) -> String {
		return formatDose(calculate(
			doubleFromString(concentration),
			weight: doubleFromString(weight),
			rate: doubleFromString(rate)
		))
	}
}
