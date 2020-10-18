//
//  MainViewController.swift
//  GoogleNews
//
//  Created by Engin KUK on 14.10.2020.
//

import UIKit
import SafariServices

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
                db.dbRemoveAll() //clear older news in db if exist
                db.dbInsert(allNews: network.news) //fetch network results to db
                db.dbLoad() // load data from db to global newsArray
                self.CollectionView.reloadData() // CollectionViewDataSource gets data from newsArray
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
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            // animation
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = CGFloat(320)
        var width:CGFloat
        // two rows for ipad
        if collectionView.frame.size.width < 768 {
            width  = collectionView.frame.width-10
        } else {
            width  = collectionView.frame.width/2-10
        }
        return CGSize(width: width, height: height)
    }
}
