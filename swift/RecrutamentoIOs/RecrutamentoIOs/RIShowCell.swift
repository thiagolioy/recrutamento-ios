//
//  RIShowCell.swift
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Bricks
import Kingfisher

class RIShowCell: BKBaseCollectionViewCell {
    static let cellsPerRow = 3
    static let cellsAspectRatio = 1.5

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var showName: UILabel!

    static func cellSize(bounds:CGRect, paddingBtwCells:CGFloat) -> CGSize{
        let padding = (paddingBtwCells * CGFloat(cellsPerRow))
        let cellWidth = (bounds.size.width - padding) / CGFloat(cellsPerRow);
        let cellHeight = cellWidth*CGFloat(cellsAspectRatio)
        return CGSizeMake(cellWidth,cellHeight)
    }

    func fill(show:Show){
        self.showName.text = show.title.value
        fetchImage(show.thumb.value!)
    }
    
    private func fetchImage(imageUrl:String){
        
        let url = NSURL(string: imageUrl)
        let placeholder = UIImage(contentsOfFile: "placeholder")
        
        self.thumbImage.kf_setImageWithURL(url!,
            placeholderImage: placeholder,
            optionsInfo: [.Options(KingfisherOptions.ForceRefresh)])
    }
    
    static func cellId()->String{
        return "RIShowCell"
//        return "RecrutamentoIOs.RIShowCell"
    }
    
}
