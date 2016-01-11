//
//  ShowsDatasource.swift
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import Bricks

class ShowsDatasource: UICollectionViewFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource {
    let modelContainer:ShowContainer
    let controller:UIViewController
    let showsCollectionView:UICollectionView
    
    init(container:ShowContainer,controller:UIViewController,collectionView:UICollectionView) {
        self.modelContainer = container
        self.controller = controller
        self.showsCollectionView = collectionView
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:RIShowCell = collectionView.dequeueReusableCellWithReuseIdentifier(RIShowCell.cellId(),forIndexPath: indexPath) as! RIShowCell
        let show = self.modelContainer.shows[indexPath.row]
        cell.fill(show)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.modelContainer.shows.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return RIShowCell.cellSize(self.controller.view.bounds, paddingBtwCells: CGFloat(10))
    }
    
    
}
