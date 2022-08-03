//
//  DishTableIngredientsHeaderViewController.swift
//  Food
//
//  Created by Николай Щербаков on 03.08.2022.
//

import UIKit

class DishTableIngredientsHeaderViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        collectionView.register(DishTableMainFooterCollectionViewCell.nib(), forCellWithReuseIdentifier: DishTableMainFooterCollectionViewCell.identifier)
    }
}
