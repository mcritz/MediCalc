//
//  ViewController.swift
//  Medicalc
//
//  Created by Critz, Michael on 10/5/15.
//  Copyright © 2015 Map of the Unexplored. All rights reserved.
//

import UIKit

class DosingVC: UIViewController {

    let doseManager = Flolan()
    
    @IBOutlet weak var dosingInput: UITextField!
    @IBOutlet weak var concentrationInput: UITextField!
	@IBOutlet weak var rateInput: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
	@IBOutlet weak var dismissButton: UIButton!

	var activeControl = UIControl()
	
	@IBAction func controlActivated(sender: UIControl) {
		activeControl = sender
		dismissButton.hidden = false
	}
	
	
    @IBAction func inputChanged(sender: UIControl) {
		dismissButton.hidden = false
        resultLabel.text = doseManager.updateResult(dosingInput.text, concentration: concentrationInput.text, rate: rateInput.text)
		activeControl = sender
    }
	@IBAction func dismissKeyboardAction(sender: UIButton) {
		activeControl.resignFirstResponder()
		sender.hidden = true
	}
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
