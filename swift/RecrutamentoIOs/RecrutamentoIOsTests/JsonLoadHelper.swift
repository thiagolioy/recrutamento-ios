//
//  JsonLoadHelper.swift
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Foundation
import ModelRocket

class JsonLoadHelper {
    
    let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    func load() -> JSON?{
    
        let bundle = NSBundle(forClass: self.dynamicType)
        if let path = bundle.pathForResource(self.filename, ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                return JSON(data: data)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            return nil
        }
        return nil
    }
}
