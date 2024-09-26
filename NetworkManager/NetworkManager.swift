//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Oleksii on 25.09.2024.
//

import Foundation

class NetworkManager {
    
    func getNews(count: String, completion: @escaping ([News]) ->()) {
        // URL
        // request
        // get data
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "newsapi.org"
        urlComponent.path = "/v2/top-headlines"
        
        urlComponent.queryItems = [
        URLQueryItem(name: "country", value: "us"),
        URLQueryItem(name: "category", value: "business"),
        URLQueryItem(name: "apiKey", value: "7138873153854ab69fdd7d68893764ff"),
        URLQueryItem(name: "pageSize", value: count)
        ]
        
        // Request
        if let url = urlComponent.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            // send request and receive data
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                guard let data else {
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completion(response.articles)
                } catch let error {
                    print(error.localizedDescription)
                    return
                }
            }.resume()
        }
    }
}

struct Response: Decodable {
    var articles: [News]
}
// https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7138873153854ab69fdd7d68893764ff

struct News: Decodable {
    var title: String?
    var description: String?
}
