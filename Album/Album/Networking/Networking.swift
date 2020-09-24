//
//  Networking.swift
//  Album
//
//  Created by Danya on 9/14/20.
//  Copyright © 2020 Danya. All rights reserved.
//

import UIKit

struct FeedResult {
    let albumName: String?
    let artistName: String?
    let imageUrl: String?
    let releaseDate: String?
    let copyRightText: String?
    let genres: [genre]
}

extension FeedResult: Decodable {
    enum CodingKeys: String, CodingKey {
        case albumName = "name"
        case artistName = "artistName"
        case imageUrl = "artworkUrl100"
        case releaseDate = "releaseDate"
        case copyRightText = "copyright"
        case genres
    }
}

struct genre {
    let genreURL: String?
}

extension genre: Decodable {
    enum CodingKeys: String, CodingKey {
        case genreURL = "url"
    }
}
struct Feed {
    let title: String
    let results: [FeedResult]
}
extension Feed: Decodable {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case results
        case feed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let feedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .feed)
        title = try feedContainer.decode(String.self, forKey: .title)
        results = try feedContainer.decode([FeedResult].self, forKey: .results)
    }
}


class Networking: NSObject {
    
    func getFeedData(completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json") {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
}
