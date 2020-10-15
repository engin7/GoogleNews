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
        1
    }
    
     
    
      func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.newsHeadline.text = network.news[0].title
        cell.newsText.text = network.news[0].content
        cell.newsImageView.image = UIImage(systemName: "square.and.pencil")
        
        return cell
        
    }
    
    
    
    
}

