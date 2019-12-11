//
//  RollerViewController.swift
//  Dicey
//
//  Created by Matthew Dias on 12/7/19.
//  Copyright © 2019 Matthew Dias. All rights reserved.
//

import UIKit

class RollerViewController: UIViewController {
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var diceNumberTextField: UITextField!
    @IBOutlet var plusButton: UIButton!
    
    @IBOutlet var d4Button: UIButton!
    @IBOutlet var d6Button: UIButton!
    @IBOutlet var d8Button: UIButton!
    @IBOutlet var d10Button: UIButton!
    @IBOutlet var d12Button: UIButton!
    @IBOutlet var d20Button: UIButton!
    @IBOutlet var d100Button: UIButton!
    
    @IBOutlet var rollButton: UIButton!
    
    @IBOutlet var dice: [UIButton]!
    
    var diceNumber = 1 {
        didSet {
            diceNumberTextField.text = "\(diceNumber)"
            setStepperButtonsAccessibility(value: diceNumber)
        }
    }
    var selectedDie: Die?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtonBorders()
        setupAccessibility()
    }
    
    func setupButtonBorders() {
        minusButton.layer.borderWidth = 1
        minusButton.layer.cornerRadius = 10
        plusButton.layer.borderWidth = 1
        plusButton.layer.cornerRadius = 10
        
        d4Button.layer.borderWidth = 1
        d4Button.layer.cornerRadius = 10
        d6Button.layer.borderWidth = 1
        d6Button.layer.cornerRadius = 10
        d8Button.layer.borderWidth = 1
        d8Button.layer.cornerRadius = 10
        d10Button.layer.borderWidth = 1
        d10Button.layer.cornerRadius = 10
        d12Button.layer.borderWidth = 1
        d12Button.layer.cornerRadius = 10
        d20Button.layer.borderWidth = 1
        d20Button.layer.cornerRadius = 10
        d100Button.layer.borderWidth = 1
        d100Button.layer.cornerRadius = 10
        
        rollButton.layer.borderWidth = 1
        rollButton.layer.cornerRadius = 10
    }
    
    @objc func setupAccessibility() {
        setResultAccessibility(value: Int(resultLabel.text!)!)
        setStepperButtonsAccessibility(value: diceNumber)
        
        d4Button.accessibilityHint = "Tap to select d4 for rolling"
        d6Button.accessibilityHint = "Tap to select d6 for rolling"
        d8Button.accessibilityHint = "Tap to select d8 for rolling"
        d10Button.accessibilityHint = "Tap to select d10 for rolling"
        d12Button.accessibilityHint = "Tap to select d12 for rolling"
        d20Button.accessibilityHint = "Tap to select d20 for rolling"
        d100Button.accessibilityHint = "Tap to select d100 for rolling"
        

    }
    
    func setResultAccessibility(value: Int) {
        resultLabel.accessibilityLabel = "Roll result"
        resultLabel.accessibilityHint = "Current value: \(value)"
        resultLabel.accessibilityTraits = .updatesFrequently
    }
    
    func setStepperButtonsAccessibility(value: Int) {
        minusButton.accessibilityLabel = "Subtract from number of dice being rolled"
        minusButton.accessibilityHint = "Current number: \(value)"
        plusButton.accessibilityLabel = "Add to number of dice being rolled"
        plusButton.accessibilityHint = "Current number: \(value)"
    }
    
    func setSelected(_ button: UIButton) {
        dice.forEach { $0.isSelected = false }
        
        button.isSelected = true
    }
    
    func roll(_ diceNumber: Int, _ die: Die) -> Int {
        var result = 0
        
        for _ in 1...diceNumber {
            result += Int.random(in: 1...die.rawValue)
        }
        
        return result
    }
    
    func updateTotal(_ value: Int) {
        resultLabel.text = "\(value)"
        
        setResultAccessibility(value: value)
    }

    // MARK: - Actions
    
    @IBAction func minusTapped(_ sender: Any) {
        guard diceNumber > 1 else { return }
        
        diceNumber -= 1
    }
    
    @IBAction func plusTapped(_ sender: Any) {
        guard diceNumber < 100 else { return }
        
        diceNumber += 1
    }
    
    @IBAction func d4Tapped(_ sender: UIButton) {
        setSelected(sender)
        selectedDie = .d4
    }
    
    @IBAction func d6Tapped(_ sender: UIButton) {
        setSelected(sender)
        selectedDie = .d6
    }
    
    @IBAction func d8Tapped(_ sender: UIButton) {
        setSelected(sender)
        selectedDie = .d8
    }
    
    @IBAction func d10Tapped(_ sender: UIButton) {
        setSelected(sender)
        selectedDie = .d10
    }
    
    @IBAction func d12Tapped(_ sender: UIButton) {
        setSelected(sender)
        selectedDie = .d12
    }
    
    @IBAction func d20Tapped(_ sender: UIButton) {
        setSelected(sender)
        selectedDie = .d20
    }
    
    @IBAction func d100Tapped(_ sender: UIButton) {
        setSelected(sender)
        selectedDie = .d100
    }
    
    @IBAction func rollTapped(_ sender: UIButton) {
        guard let selectedDie = selectedDie else { return }
        
        updateTotal(roll(diceNumber, selectedDie))
        UIAccessibility.post(notification: .layoutChanged, argument: resultLabel)
    }
}
