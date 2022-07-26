//
//  StoriesContainerViewController.swift
//  Food
//
//  Created by Николай Щербаков on 04.07.2022.
//

import UIKit

class StoriesContainerViewController: UIViewController {
    
    var storiesList: Array<Story> = Story.getStories()
    
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        storiesCollectionView.collectionViewLayout = layout
        storiesCollectionView.showsHorizontalScrollIndicator = false
        storiesCollectionView.register(StoryCollectionViewCell.nib(), forCellWithReuseIdentifier: StoryCollectionViewCell.identifier)
    }
}

extension StoriesContainerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.identifier, for: indexPath) as! StoryCollectionViewCell
        
        cell.configure(with: storiesList[indexPath.row].image)
        
        return cell
    }
}

extension StoriesContainerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension StoriesContainerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = storiesCollectionView.bounds.height
        let width = height
        
        return CGSize(width: width, height: height)
    }
}
