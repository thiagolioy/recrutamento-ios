//
//  ViewController.swift
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import ModelRocket


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPopularShows()
        
    }

    func fetchPopularShows(){
        
        NetworkManager.sharedInstance.fetchPopularShows(1,closure:{ shows in
            print(shows.count);
        });
        
        
    }


}

