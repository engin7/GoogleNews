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
    private let network = NetworkManager.shared
    private let db = DatabaseManager.sharedInstance
    private let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Google News"
        CollectionView.dataSource = collectionViewDataSource
        getHeadlines()
    }
    
    func getHeadlines() {
        network.getHeadlines(completion: { [self] success in
            if !success {
                self.showNetworkError()
            } else {
                db.dbRemoveAll() //clear older news
                db.dbInsert(allNews: network.news) //fetch network results to db
                db.dbLoad() // load data from db to newsArray
                self.CollectionView.reloadData()
            }
        })
    }
    
    // MARK:- Helper Methods
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Sorry...", message: "Error occured connecting the Server. Please check your connection and try again.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Retry", style: .default, handler: {
        (UIAlertAction) in
            self.getHeadlines()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
 
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

 
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = CGFloat(320)
        var width:CGFloat
        
        if collectionView.frame.size.width < 768 {
            width  = collectionView.frame.width-10
        } else {
            width  = collectionView.frame.width/2-10
        }
          
        
        
        return CGSize(width: width, height: height)
    }
    
}
