//
//  DiePopoutViewController.swift
//  Dicey
//
//  Created by Matthew Dias on 2/8/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import UIKit

class DiePopoutViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    @IBOutlet weak var popoutContainer: UIView!
    
    weak var valueDelegate: DieValueContainable?
    var value = 0 {
        didSet {
            valueLabel.text = "\(value)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popoutContainer.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateView()
    }
    
    func animateView() {
        blurEffect.alpha = 0
        imageView.alpha = 0
        valueLabel.alpha = 0
        stepper.alpha = 0
        popoutContainer.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.blurEffect.alpha = 1
            self.imageView.alpha = 1
            self.valueLabel.alpha = 1
            self.stepper.alpha = 1
            self.popoutContainer.alpha = 1
        }
    }
   
    @IBAction func valueChanged(_ sender: UIStepper) {
        self.value = Int(sender.value)
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        valueDelegate?.updateValue(count: value)
        
        dismiss(animated: true, completion: nil)
    }
}
