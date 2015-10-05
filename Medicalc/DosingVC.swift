//
//  ViewController.swift
//  Medicalc
//
//  Created by Critz, Michael on 10/5/15.
//  Copyright © 2015 Map of the Unexplored. All rights reserved.
//

import UIKit

class DosingVC: UIViewController {

    @IBOutlet weak var dosingInput: UITextField!
    @IBOutlet weak var concentrationInput: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func inputChanged(sender: AnyObject) {
        resultLabel.text = updateResult(dosingInput.text, weight: concentrationInput.text)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

