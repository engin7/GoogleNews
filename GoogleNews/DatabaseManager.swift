//
//  DatabaseAccessor.swift
//  GoogleNews
//
//  Created by Engin KUK on 16.10.2020.
//

import Foundation
import SQLite


class DatabaseManager {
    
    static let sharedInstance = DatabaseManager() //singleton
    var newsArray = [News]()
     // Private initializer to avoid instancing by other classes
    private init() {
        dbSetup()
    }

    var db: Connection?
    let tblNews = Table("news")
    let dbTitle = Expression<String?>("title")
    let dbContent = Expression<String?>("content")
    let dbUrl = Expression<String?>("url")
    let dbUrlToImage = Expression<String?>("urlToImage")
 
    func dbSetup() {
        let databaseFileName = "db.sqlite3"
        let databaseFilePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(databaseFileName)"
        db = try! Connection(databaseFilePath)
        
        try! db!.run(tblNews.create(ifNotExists: true) { t in
            t.column(dbTitle)
            t.column(dbContent)
            t.column(dbUrl)
            t.column(dbUrlToImage)
         })
        
    }

    func dbInsert(allNews: [News]) {
        //inserting/updating data to the sqlite database
        do {
            for news in allNews {
                _ = try db!.run(tblNews.insert(or: .replace, dbTitle <- news.title,dbContent <- news.content, dbUrl <- news.url, dbUrlToImage <- news.urlToImage))
//                print("Row inserted successfully id: \(rowid)")
             }
        } catch {
            print("insertion failed: \(error)")
        }
    }
    
    func dbRemoveAll() {
        //remove from the sqlite database
        do {
             if try self.db!.run(self.tblNews.delete()) > 0 {
                print("deleted successfully")
            } else {
                print("item for delete not found")
            }
        } catch {
            print("delete failed: \(error)")
        }
    }
    
    func dbLoad() {
        
        do{
            for article in try db!.prepare(tblNews) {
                let source = Source()
                var tempNews = News(source: source)
                tempNews.title = article[dbTitle]
                tempNews.content = article[dbContent]
                tempNews.url = article[dbUrl]
                tempNews.urlToImage = article[dbUrlToImage]
                newsArray.append(tempNews)
            }
        }
        catch {
            print ("selection error: \(error)")
        }
    }
    
}


