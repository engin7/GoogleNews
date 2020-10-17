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
 
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Google News"
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        CollectionView.refreshControl = refreshControl
        CollectionView.dataSource = collectionViewDataSource
        getHeadlines()
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        self.CollectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
  
    func getHeadlines() {
        network.getHeadlines(completion: { [self] success in
            if !success {
                self.showNetworkError()
            } else {
                db.dbRemoveAll() //clear older news if exist
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
 
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let urlPath = db.newsArray[indexPath.row].url {
            let url = URL(string: urlPath)!
            let identifier = String(describing: WKWebViewController.self)
            let vc = storyboard?.instantiateViewController(withIdentifier: identifier) as! WKWebViewController
            vc.url = url
            vc.title = url.host

            let transition = CATransition()
            transition.duration = 0.6
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromTop
            self.navigationController?.view.layer.add(transition, forKey: nil)
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
}
    
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
