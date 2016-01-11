//
//  NetworkManager.swift
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import ModelRocket
import Alamofire
import netfox

class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
    var headers:[String:String] = [:]
    private override init() {
        super.init()
        setupDefaultHeaders()
        NFX.sharedInstance().start()
    }
    
    internal func setupDefaultHeaders(){
        self.headers = [
            "trakt-api-key": "95263dffcdf5ea8f1a58d226b042a7e995da4f66d37fb1378a4f9c54d7269535",
            "trakt-api-version": "2",
            "Content-type" : "application/json"
        ]
    }
    
    func fetchPopularShows(onPage:NSNumber,closure: (shows:[Show]) -> Void) {
        let parameters = [
            "extended": "images",
            "page":onPage,
            "limit":"30"
        ]
        Alamofire.request(.GET,
            "https://api-v2launch.trakt.tv/shows/popular",
            parameters: parameters,
            headers: self.headers).responseJSON { response in
                let json = JSON(data:response.data)
                let shows = Show.parseJSONArray(json)
                closure(shows: shows)
        }
    }
}
