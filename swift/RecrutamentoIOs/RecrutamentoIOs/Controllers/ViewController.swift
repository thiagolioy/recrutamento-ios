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

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var showsCollectionViewContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var datasource:ShowsDatasource?
    private lazy var modelContainer:ShowContainer = {
        let container = ShowContainer()
        return container
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPopularShows()
    }

    func setupDataspurce(){
        self.datasource = ShowsDatasource(container: self.modelContainer,
            controller: self, collectionView: self.collectionView)
        self.collectionView.dataSource = self.datasource!
        self.collectionView.delegate = self.datasource!
        self.collectionView.reloadData()
    }
    func fetchPopularShows(){
        
        NetworkManager.sharedInstance.fetchPopularShows(1,closure:{ shows in
            print(shows.count);
            self.modelContainer.shows = shows
            self.setupDataspurce()
        });
        
        
    }


}

