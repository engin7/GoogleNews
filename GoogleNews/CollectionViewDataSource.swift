//
//  CollectionViewDataSource.swift
//   
//
//  Created by Engin KUK on 14.10.2020.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private let db = DatabaseManager.sharedInstance
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return db.newsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.newsHeadline.text = db.newsArray[indexPath.row].title
        cell.newsText.text = db.newsArray[indexPath.row].content
        cell.source.text = db.newsArray[indexPath.row].source?.name
        cell.newsImageView.loadImageUsingCache(withUrl: db.newsArray[indexPath.row].urlToImage ?? "")
        
        return cell
    }
    
}

