//
//  NetworkLayer.swift
//  GoogleNews
//
//  Created by Engin KUK on 15.10.2020.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager() // singleton
    private let homeURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey="
    private var dataTask: URLSessionDataTask? = nil
    private var apiKey: String?
    var news:[News] = []
    typealias SearchComplete = (Bool) -> Void

    func getHeadlines(completion: @escaping SearchComplete) {
        
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
           let Keys =  NSDictionary(contentsOfFile: path) //be sure to add your api key to keys.plist
           apiKey = Keys?.value(forKey: "API_Key") as? String
        }
        
        let url = URL(string: homeURL + apiKey!)!
        dataTask?.cancel()
        let session = URLSession.shared
        dataTask = session.dataTask(with: url, completionHandler: {data, response, error in
            // if cancelled ignore error code and return
            if let error = error as NSError?, error.code == -999 {
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                self.news = self.parse(data: data).articles
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        })
        dataTask?.resume()
    }
       
    // MARK:- Private Methods
    
    private func parse(data: Data) -> Root {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Root.self, from:data)
            return result
        } catch {
            print("JSON Error: \(error)")
            let empty = Root(articles: [])
            return  empty  }
    }
    
}
