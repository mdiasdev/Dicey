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
    
    @IBOutlet weak var diceCollectionView: UICollectionView!
    
    @IBOutlet var rollButton: UIButton!
    
    let diceCollectionViewController = DiceCollectionViewController()
    var selectedDie: Die?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diceCollectionView.delegate = diceCollectionViewController
        diceCollectionView.dataSource = diceCollectionViewController
        diceCollectionViewController.selectableDelegate = self
        
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
    
    @IBAction func rollTapped(_ sender: UIButton) {
        guard let selectedDie = selectedDie else { return }
        
        updateTotal(roll(1, selectedDie)) // TODO: update with real values to roll
        UIAccessibility.post(notification: .layoutChanged, argument: resultLabel)
    }
}

// MARK: - DieSelectable
extension RollerViewController: DieSelectable {
    func didSelect(die: Die) {
        // make pop out
        guard let popout = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DiePopout") as? DiePopoutViewController else { return }
            
        _ = popout.view
        popout.imageView.image = die.image()
        popout.modalPresentationStyle = .custom
        popout.modalTransitionStyle = .crossDissolve
        popout.providesPresentationContextTransitionStyle = true
        popout.definesPresentationContext = true
        
        self.present(popout, animated: true, completion: nil)
    }
}
