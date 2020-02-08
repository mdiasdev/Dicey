//
//  DiceCollectionViewController.swift
//  Dicey
//
//  Created by Matthew Dias on 2/1/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Die"

class DiceCollectionViewController: UICollectionViewController {
    let dice: [Die] = [.d4, .d6, .d8, .d10, .d12, .d20, .d100]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(DieCollectionViewCell.self, forCellWithReuseIdentifier: "reuseIdentifier")
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return dice.count }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? DieCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        let die = dice[indexPath.row]
        
        cell.imageView.image = die.image()
    
        return cell
    }

}