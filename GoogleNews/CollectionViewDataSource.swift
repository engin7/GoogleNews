//
//  CollectionViewDataSource.swift
//  GoogleNews
//
//  Created by Engin KUK on 14.10.2020.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private let network = NetworkManager.shared

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return network.news.count
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
    
        cell.newsHeadline.text = network.news[indexPath.row].title
        cell.newsText.text = network.news[indexPath.row].content
        cell.source.text = network.news[indexPath.row].source?.name
        cell.newsImageView.loadImageUsingCache(withUrl: network.news[indexPath.row].urlToImage ?? "")
        
        return cell
    }
     
}

