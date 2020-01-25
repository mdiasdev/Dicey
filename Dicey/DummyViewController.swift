//
//  DummyViewController.swift
//  Dicey
//
//  Created by Matthew Dias on 1/25/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import UIKit

class DummyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let roller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RollerViewController")
        navigationController?.pushViewController(roller, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
