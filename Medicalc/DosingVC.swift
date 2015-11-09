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
		var defaultSelectedRow: Int?
		var defaultValue = Double(0.0)
		
		switch controllerId {
		case "doseInput":
			pickerControl.accessibilityHint = DoseType.AdultKilgrams.desc()
			doubleValues = doseManager.dataValues(DoseType.AdultKilgrams)
			defaultValue = DoseType.AdultKilgrams.startingValue()
			break
		case "concentrationInput":
			pickerControl.accessibilityHint = DoseType.MedicinceConcentrationNanogramsPerMilliliter.desc()
			doubleValues = doseManager.dataValues(DoseType.MedicinceConcentrationNanogramsPerMilliliter)
			defaultValue = DoseType.MedicinceConcentrationNanogramsPerMilliliter.startingValue()
			break
		case "rateInput":
			pickerControl.accessibilityHint = DoseType.Rate.desc()
			doubleValues = doseManager.dataValues(DoseType.Rate)
			defaultValue = DoseType.Rate.startingValue()
			break
		default:
			pickerControl.accessibilityHint = DoseType.Empty.desc()
			doubleValues = [0]
			break
		}
		defaultSelectedRow = doubleValues.indexOf(defaultValue)
		
		for vv in doubleValues {
			currentInputData.append(doseManager.formatDose(vv))
		}
		pickerControl.frame = getPickerFrame()
		pickerControl.hidden = false
		pickerControl.reloadAllComponents()
		
		if (hasValue(control)) { return }
		
		if let defaultSelectedRow = defaultSelectedRow as Int! {
			setValueForControl(doseManager.formatDose(defaultValue), control: control)
			let defaultRowIndex = defaultSelectedRow + 1 // because the index of the control has a blank value as a default
			pickerControl.selectRow(defaultRowIndex, inComponent: 0, animated: true)
		}
		// TODO: update selected row
	}
	
	func hasValue(control :UIControl) -> Bool {
		if let control = control as? UITextField {
			return control.text != ""
		}
		return false
	}
	
	func setValueForControl(value :String, control :UIControl?) {
		if let textField = control as? UITextField {
			textField.text = value
		}
	}
	
	func defaultRow(picker: UIPickerView, inputType: String?) -> Int {
		guard let dataType = inputType as String! else { return 0 }
		switch dataType {
		case "doseInput":
			break
		default:
			break
		}
		return 0
	}
	
	func userUpdatedPicker(value: Int) {
		guard let controllerId = activeControl.accessibilityIdentifier as String! else { return }
		switch controllerId {
		case "doseInput":
			guard isGoodArray(doseManager.dataValues(DoseType.AdultKilgrams), value: value) else { break }
			let text = doseManager.formatDose(doseManager.dataValues(DoseType.AdultKilgrams)[value])
			weightInput.text = text
			break
		case "concentrationInput":
			guard isGoodArray(doseManager.dataValues(DoseType.MedicinceConcentrationNanogramsPerMilliliter), value: value) else { break }
			let text = doseManager.formatDose(doseManager.dataValues(DoseType.MedicinceConcentrationNanogramsPerMilliliter)[value])
			concentrationInput.text = text
			break
		case "rateInput":
			guard isGoodArray(doseManager.dataValues(DoseType.Rate), value: value) else { break }
			let text = doseManager.formatDose(doseManager.dataValues(DoseType.Rate)[value])
			rateInput.text = text
			break
		default:
			break
		}

	}
	
	func isGoodArray(data :Array<Double>, value :Int) -> Bool {
		return value >= 0 && value <= data.count
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
		self.title = doseManager.description
		
		pickerControl.accessibilityIdentifier = "doseInput"
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
