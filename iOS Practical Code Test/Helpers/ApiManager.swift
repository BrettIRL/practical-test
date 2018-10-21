//
//  ApiManager.swift
//  iOS Practical Code Test
//
//  Created by Brett Cocking on 2018/10/20.
//  Copyright © 2018 Trademark Technology. All rights reserved.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    let baseUrl = "https://api.stackexchange.com/2.2/questions"
    
    func getQuestions(tagged tag: String, numberOfResults pagesize: Int, complete: @escaping (SearchResults?, Error?) -> Void) {
        let url = baseUrl + "?pagesize=\(pagesize)&order=desc&sort=activity&tagged=\(tag)&site=stackoverflow&filter=withbody"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let request = URL(string: encodedUrl) {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    complete(nil, error)
                    return
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    do {
                        let results = try decoder.decode(SearchResults.self, from: data)
                        complete(results, nil)
                    } catch {
                        complete(nil, error)
                    }
                }
            }
            task.resume()
        }
    }
}
