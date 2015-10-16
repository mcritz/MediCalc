//
//  ViewController.swift
//  Medicalc Mac
//
//  Created by Michael Critz on 10/6/15.
//  Copyright © 2015 Map of the Unexplored. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
	
	let doseManager = Dose()
	
	@IBOutlet weak var weightInput: NSTextField!
	@IBOutlet weak var concentrationInput: NSTextField!
	@IBOutlet weak var resultLabel: NSTextField!
	
	override func viewDidLoad() {
		if #available(OSX 10.10, *) {
		    super.viewDidLoad()
		}
		
		self.title = NSLocalizedString("Medicalc", comment:"The brand name of this app")
	}

	override var representedObject: AnyObject? {
		didSet {
		// Update the view, if already loaded.
		}
	}

	@IBAction func inputUpdated(sender: NSTextField) {
		self.resultLabel.stringValue = doseManager.updateResult([weightInput.stringValue, concentrationInput.stringValue])
	}

}

