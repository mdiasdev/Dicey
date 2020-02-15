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
    var dice: [(die: Die, count: Int)] = [(.d4, 0),
                                           (.d6, 0),
                                           (.d8, 0),
                                           (.d10, 0),
                                           (.d12, 0),
                                           (.d20, 0),
                                           (.d100, 0)]
    
    weak var selectableDelegate: DieSelectable?
    weak var dieValueDelegate: DieValueContainable?

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
        
        cell.imageView.image = die.die.image()
        cell.die = die.die
        cell.count = die.count
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DieCollectionViewCell else { return }
        
        selectableDelegate?.didSelect(die: cell.die, count: cell.count)
    }

}

// TODO: find a better spot for these
protocol DieSelectable: class {
    func didSelect(die: Die, count: Int)
}

protocol DieValueContainable: class {
    func updateValue(die: Die, count: Int)
}
