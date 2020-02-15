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
    @IBOutlet weak var rollingLabel: UILabel!
    @IBOutlet weak var diceCollectionView: UICollectionView!
    @IBOutlet var rollButton: UIButton!
    
    let diceCollectionViewController = DiceCollectionViewController()
    var diceToRoll: [(die: Die, count: Int)] = []
    
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
    @IBAction func resetTapped(_ sender: Any) {
        rollingLabel.text = ""
        diceToRoll = []
    }
    
    @IBAction func rollTapped(_ sender: UIButton) {
        guard !diceToRoll.isEmpty else { return }
        var total = 0
        
        diceToRoll.forEach { pair in
            for _ in 1...pair.count {
                total += roll(1, pair.die)
            }
        }
        
        updateTotal(total)
        UIAccessibility.post(notification: .layoutChanged, argument: resultLabel)
    }
}

// MARK: - DieSelectable
extension RollerViewController: DieSelectable {
    func didSelect(die: Die, count: Int) {
        // make pop out
        guard let popout = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DiePopout") as? DiePopoutViewController else { return }
            
        popout.set(die: die, count: count)
        popout.modalPresentationStyle = .custom
        popout.modalTransitionStyle = .crossDissolve
        popout.providesPresentationContextTransitionStyle = true
        popout.definesPresentationContext = true
        popout.valueDelegate = self
        
        self.present(popout, animated: true, completion: nil)
    }
}

extension RollerViewController: DieValueContainable {
    func updateValue(die: Die, count: Int) {
        guard count > 0 else { return }
        
        if let index = diceToRoll.firstIndex(where: { return $0.0 == die }) {
            diceToRoll[index] = (die, count)
        } else {
            diceToRoll += [(die, count)]
        }
        
        rollingLabel.text = diceToRollString(from: rollingLabel.text ?? "", die: die, count: count)
        
        guard let index = diceCollectionViewController.dice.firstIndex(where: { $0.die == die }) else { return }
        
        diceCollectionViewController.dice[index] = (die, count)
        diceCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
    
    func diceToRollString(from labelText: String, die: Die, count: Int) -> String {
        var labelText = labelText
        
        guard labelText.contains("d\(die.rawValue)") else {
            labelText.append(die: die, count: count)
            return labelText
        }
        
        var dice = labelText.components(separatedBy: ", ") // [1d6,10d4]
        
        guard let index = dice.firstIndex(where: { $0.contains("d\(die.rawValue)") }) else { return "" }
        
        dice[index] = "\(count)d\(die.rawValue)"
        
        return dice.joined(separator: ", ")
    }
}

