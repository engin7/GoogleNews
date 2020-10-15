//
//  MainViewController.swift
//  GoogleNews
//
//  Created by Engin KUK on 14.10.2020.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate {

    
    @IBOutlet weak var CollectionView: UICollectionView!
    private let collectionViewDataSource = CollectionViewDataSource()

     
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Google News"
        CollectionView.dataSource = collectionViewDataSource

    }
 
    // MARK: UICollectionViewDelegate
 
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.height/2.65
        let width  = collectionView.frame.width-20
        return CGSize(width: width, height: height)
    }
    
}
