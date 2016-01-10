//
//  ViewController.swift
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Alamofire
import netfox
import ModelRocket


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NFX.sharedInstance().start()
        
        fetchPopularShows()
        
    }

    func fetchPopularShows(){
        let parameters = [
            "extended": "images",
            "page":1,
            "limit":"30"
        ]
        
        let headers = [
            "trakt-api-key": "95263dffcdf5ea8f1a58d226b042a7e995da4f66d37fb1378a4f9c54d7269535",
            "trakt-api-version": "2",
            "Content-type" : "application/json"
            
        ]

        Alamofire.request(.GET,
            "https://api-v2launch.trakt.tv/shows/popular",
            parameters: parameters,
            headers: headers).responseJSON { response in
              let json = JSON(data:response.data)
              let shows = Show.parseJSONArray(json)
              print(shows.count)
        }

        

        
    }


}

