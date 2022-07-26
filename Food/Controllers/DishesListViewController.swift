//
//  DishesListViewController.swift
//  Food
//
//  Created by Николай Щербаков on 04.07.2022.
//

import UIKit

class DishesListViewController: UIViewController {

    var startDrag: CGFloat = 0
    var scrollViewContentOffset: CGFloat = 0
    var padding: CGFloat = 0
    var dishesList: Array<Dish> = DishCoder.getDishes()
    
    @IBOutlet var panGestureRecognizerOutler: UIPanGestureRecognizer!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var collectionViewMinHeight: CGFloat = 400
    var collectionViewMaxHeight: CGFloat = 800
    var maxTotalTranslation: CGFloat = 800
    var minTotalTranslation: CGFloat = 400
    var gestureFlag: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        padding = view.bounds.width / 20

        collectionViewMinHeight = view.bounds.height * 0.3
        startDrag = collectionViewMinHeight
        collectionViewMaxHeight = view.bounds.height * 0.6
        minTotalTranslation = collectionViewMinHeight
        maxTotalTranslation = collectionViewMaxHeight
        
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        collectionView.register(DishCollectionViewCell.nib(), forCellWithReuseIdentifier: DishCollectionViewCell.identifier)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionViewHeight.constant = collectionViewMinHeight
        collectionView.contentInset.left = padding
        collectionView.contentInset.right = padding
    }
    
    func logMaxConstraintValueForYPosition(yPosition : CGFloat, verticalLimit: CGFloat) -> CGFloat {
        return verticalLimit * (1 + log10(yPosition/verticalLimit))
    }
    func logMinConstraintValueForYPosition(yPosition : CGFloat, verticalLimit: CGFloat) -> CGFloat {
        return (verticalLimit * (1 - log10(yPosition/verticalLimit)))
    }
    
    enum Zone {
        case middle
        case top
        case bottom
    }
    
    var zones: Zone = .middle
    
    var drag: CGFloat = .zero
    @IBAction func dragGesture(_ gesture: UIPanGestureRecognizer) {
        
        if  gesture.state == .began {
            //drag = collectionViewMinHeight
        }
        if gesture.state == .changed {
            drag -= gesture.translation(in: view).y
            print("GestureTran: \(gesture.translation(in: view).y)")
            print("drag (x): \(drag)")
            print("viewHeight: \(view.bounds.height)")
            collectionViewHeight.constant = collectionViewMinHeight + (1.0 - (1.0 / ((drag * 0.55 / view.bounds.height) + 1.0))) * view.bounds.height
            print("function: \((1.0 - (1.0 / ((drag * 0.55 / view.bounds.height) + 1.0))) * view.bounds.height)")
            print("constraint: \(collectionViewHeight.constant)")
        }
        if gesture.state == .ended {

        }

//        collectionViewHeight.constant -= gesture.translation(in: view).y
//
//            drag -= gesture.translation(in: view).y
//            collectionViewHeight.constant = (1.0 – (1.0 / ((x * c / d) + 1.0))) * d
        
       // startDrag = translation
        gesture.setTranslation(.zero, in: view)
    }
    
//    let translation = gesture.translation(in: view).y
//    if collectionViewHeight.constant <= collectionViewMinHeight {
//        if translation < 0 {
//            collectionViewHeight.constant -= translation
//        }
//        minTotalTranslation += translation
//        collectionViewHeight.constant = logMinConstraintValueForYPosition(yPosition: minTotalTranslation, verticalLimit: collectionViewMinHeight)
//        endedGestureState(gesture: gesture)
//
//    } else if collectionViewHeight.constant >= collectionViewMaxHeight {
//        if gesture.view is UICollectionView {
//            if translation > 0 && gestureFlag == true {
//                collectionViewHeight.constant -= translation
//            }
//        } else {
//            maxTotalTranslation -= translation
//            collectionViewHeight.constant = logMaxConstraintValueForYPosition(yPosition: maxTotalTranslation, verticalLimit: collectionViewMaxHeight)
//
//            endedGestureState(gesture: gesture)
//        }
//    } else {
//
//        if collectionViewHeight.constant - translation > collectionViewMaxHeight {
//            collectionViewHeight.constant = collectionViewMaxHeight
//        } else if collectionViewHeight.constant - translation < collectionViewMinHeight {
//            collectionViewHeight.constant = collectionViewMinHeight
//        } else {
//            collectionViewHeight.constant -= translation
//        }
//        endedGestureState(gesture: gesture)
//    }
//
//
//    gesture.setTranslation(.zero, in: view)
    
    //helper
    
    func endedGestureState(gesture: UIPanGestureRecognizer){
        if gesture.state == .ended {
            let middle = collectionViewMaxHeight - ((collectionViewMaxHeight - collectionViewMinHeight) / 2)
            if collectionViewHeight.constant >= middle {
                animateHeightTo(collectionViewMaxHeight)
            } else if collectionViewHeight.constant < middle {
                animateHeightTo(collectionViewMinHeight)
            }
        }
    }
    
    func animateHeightTo(_ limitHeight: CGFloat) {
        collectionViewHeight.constant = limitHeight
        minTotalTranslation = collectionViewMinHeight
        maxTotalTranslation = collectionViewMaxHeight
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .allowUserInteraction, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension DishesListViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension DishesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCollectionViewCell.identifier, for: indexPath) as! DishCollectionViewCell
        
        cell.configure(with: UIImage(systemName: "car")!)
        cell.setDishTitle(dishesList.first?.title ?? "default")
        
        return cell
    }
}

extension DishesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat((view.bounds.width - (padding * 4)) / 3)
        let height = width * CGFloat(1.5)
        return CGSize(width: width, height: height)
    }
}

extension DishesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //let y = scrollView.contentOffset.y
        //let dif = y - startScrollOffset
        if collectionViewHeight.constant < collectionViewMaxHeight {
            scrollView.contentOffset.y = scrollViewContentOffset
        }
        
        if scrollView.contentOffset.y > 0 {
            gestureFlag = false
        }
        
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
            gestureFlag = true
        }
        scrollViewContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        gestureFlag = true
    }
}

