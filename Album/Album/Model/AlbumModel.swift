//
//  AlbumModel.swift
//  Album
//
//  Created by Danya on 9/15/20.
//  Copyright © 2020 Danya. All rights reserved.
//

import UIKit

class AlbumModel: NSObject {
    var feedsList: Feed?
    var resultsArray:[FeedResult]?
    var selectedIndex: Int?
    func getAlbumList(_ completion: @escaping ((_ status: Bool) -> Void)) {
        let networkingObj = Networking()
        networkingObj.getFeedData { (result) in
                switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(Feed.self,
                                                               from: data)
                    self.feedsList = decodedData
                    self.resultsArray = self.feedsList?.results
                    completion (true)

                } catch {
                    completion (false)
                }
            case .failure(let error):
                print(error)
                    completion (false)
            }
        }
    }
}
