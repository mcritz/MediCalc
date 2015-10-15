//
//  ViewController.swift
//  Medicalc
//
//  Created by Critz, Michael on 10/5/15.
//  Copyright © 2015 Map of the Unexplored. All rights reserved.
//

import UIKit

class DosingVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let doseManager = Flolan()
	
	var currentInputData = [String?]()
    
	@IBOutlet weak var weightInput: UITextField!
	@IBOutlet weak var concentrationInput: UITextField!
	@IBOutlet weak var rateInput: UITextField!
	
    @IBOutlet weak var resultLabel: UILabel!
	@IBOutlet weak var dismissButton: UIButton!
	var pickerControl = UIPickerView()
	
	func getPickerFrame() -> CGRect {
		let contentWidth = self.view.bounds.width
		let contentHeight = self.view.bounds.height / 4 > 200 ? self.view.bounds.height/4 : 200
		return CGRectMake(0, 0, contentWidth, contentHeight)
	}

	var activeControl = UIControl()
	
	@IBAction func controlActivated(sender: UIControl) {
		activeControl = sender
		dismissButton.hidden = false
		showPickerControl(sender)
	}
	
	func showPickerControl(control: UIControl) {
		currentInputData = [""]
		guard let controllerId = control.accessibilityIdentifier as String! else { return }
		var doubleValues = [Double]()
		switch controllerId {
		case "doseInput":
			print("weight")
			doubleValues = doseManager.dataValues(Default.AdultKilgrams)
			break
		case "concentrationinput":
			print("concen")
			doubleValues = doseManager.dataValues(Default.MedicinceConcentrationNanogramsPerMilliliter)
			break
		case "rateInput":
			print("rate")
			doubleValues = doseManager.dataValues(Default.Rate)
			break
		default:
			doubleValues = [0]
			break
		}
		for vv in doubleValues {
			currentInputData.append(doseManager.formatDose(vv))
		}
		pickerControl.frame = getPickerFrame()
		pickerControl.hidden = false
		pickerControl.reloadAllComponents()
		print("showing control")
	}
	
	func userUpdatedPicker(value: Int) {
		guard let controllerId = activeControl.accessibilityIdentifier as String! else { return }
		switch controllerId {
		case "doseInput":
			let text = doseManager.formatDose(doseManager.dataValues(Default.AdultKilgrams)[value])
			print("weight is \(text)")
			weightInput.text = text
			break
		case "concentrationinput":
			let text = doseManager.formatDose(doseManager.dataValues(Default.MedicinceConcentrationNanogramsPerMilliliter)[value])
			print("concen is \(text)")
			concentrationInput.text = text
			break
		case "rateInput":
			let text = doseManager.formatDose(doseManager.dataValues(Default.Rate)[value])
			print("rate is \(text)")
			rateInput.text = text
			break
		default:
			break
		}

	}

	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return currentInputData.count
	}
	
	func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
		let someValue = currentInputData[row]
		guard let titleValue = someValue as String! else { return NSAttributedString(string: "—") }
		return NSAttributedString(string: titleValue)
	}
	
    @IBAction func inputChanged(sender: UIControl) {
		dismissButton.hidden = false
        resultLabel.text = doseManager.updateResult(weightInput.text, concentration: concentrationInput.text, rate: rateInput.text)
		activeControl = sender
		pickerControl.hidden = false
    }
	
	@IBAction func dismissKeyboardAction(sender: UIButton) {
		activeControl.resignFirstResponder()
		pickerControl.hidden = true
		sender.hidden = true
	}
        
    override func viewDidLoad() {
        super.viewDidLoad()
		pickerControl.hidden = true
		pickerControl.delegate = self
		pickerControl.dataSource = self
		
		weightInput.inputView = pickerControl
		concentrationInput.inputView = pickerControl
		rateInput.inputView = pickerControl
    }
	
	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		userUpdatedPicker(row - 1)
		resultLabel.text = doseManager.formatDose(
			doseManager.calculate(
				doseManager.doubleFromString(concentrationInput.text),
				weight: doseManager.doubleFromString(weightInput.text),
				rate: doseManager.doubleFromString(rateInput.text)
			)
		)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
