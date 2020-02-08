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
    
    @IBOutlet weak var diceCollectionView: UICollectionView!
    
    @IBOutlet var rollButton: UIButton!
    
    let diceCollectionViewController = DiceCollectionViewController()
    var selectedDie: Die?
    var diceNumber = 1 {
        didSet {
            diceNumberTextField.text = "\(diceNumber)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diceCollectionView.delegate = diceCollectionViewController
        diceCollectionView.dataSource = diceCollectionViewController
        
        setupButtonBorders()
        setupAccessibility()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.setTabBar(hidden: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTabBarVisibility()
    }
    
    override func viewWillLayoutSubviews() {
        setTabBarVisibility()
        super.viewWillLayoutSubviews()
    }
    
    func setTabBarVisibility() {
        guard let tabBarController = tabBarController else { return }
        
        if traitCollection.horizontalSizeClass == .compact {
            // load slim view
            tabBarController.setTabBar(hidden: false)
        } else {
            // load wide view
            tabBarController.setTabBar(hidden: true)
        }
    }
    
    func setupButtonBorders() {
        
        rollButton.layer.borderWidth = 1
        rollButton.layer.cornerRadius = 10
    }
    
    @objc func setupAccessibility() {
        setResultAccessibility(value: Int(resultLabel.text!)!)
        
//        d4Button.accessibilityLabel = "d4"
//        d4Button.accessibilityHint = "Tap to select d4 for rolling"
        
        minusButton.isAccessibilityElement = false
        plusButton.isAccessibilityElement = false
        
        diceNumberTextField.accessibilityHint = "Number of dice to roll"
        
        if UIAccessibility.isVoiceOverRunning {
            diceNumberTextField.isUserInteractionEnabled = true
        } else {
            diceNumberTextField.isUserInteractionEnabled = false
        }
    }
    
    func setResultAccessibility(value: Int) {
        var resultValue = "Roll result"
        
        if value > 0 {
            resultValue.append(". \(value)")
        }
        
        resultLabel.accessibilityLabel = resultValue
        resultLabel.accessibilityTraits = .updatesFrequently
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
    
    @IBAction func rollTapped(_ sender: UIButton) {
        guard let selectedDie = selectedDie else { return }
        
        updateTotal(roll(diceNumber, selectedDie))
        UIAccessibility.post(notification: .layoutChanged, argument: resultLabel)
    }
}
