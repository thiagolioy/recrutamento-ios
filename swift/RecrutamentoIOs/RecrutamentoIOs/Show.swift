//
//  Show.swift
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import ModelRocket


class Show: Model {
    let title  = Property<String>(key: "title")
    let year  = Property<Int>(key: "year")
    let traktId  = Property<Int>(key: "ids.trakt")
    let thumb  = Property<String>(key: "images.poster.thumb")
    
    static func parseJSONArray(array:JSON) ->[Show] {
        var shows:[Show] = []
        
        for anItem in array{
            let s = Show(json:anItem)
            shows.append(s)
        }
        return shows
    }
}

