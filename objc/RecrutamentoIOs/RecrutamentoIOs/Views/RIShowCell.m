//
//  RIShowCell.m
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/9/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "RIShowCell.h"
#import "RIShow.h"
#import <SDWebImage/UIImageView+WebCache.h>

NSInteger const kCellsPerRow = 3;
CGFloat const kCellsAspectRatio = 1.5;
@interface RIShowCell ()
@property(nonatomic,weak) IBOutlet UIImageView *thumbImage;
@property(nonatomic,weak) IBOutlet UILabel *showName;
@end

@implementation RIShowCell

+(CGSize)cellSizeForBounds:(CGRect)bounds paddingBtwCells:(CGFloat)padding{
    CGFloat cellWidth =  (bounds.size.width - padding*kCellsPerRow)/ kCellsPerRow;
    CGFloat cellHeight = cellWidth*kCellsAspectRatio;
    return CGSizeMake(cellWidth, cellHeight);
}
-(void)setup:(RIShow*)object{
    self.showName.text = object.title;
    [self fetchImage:object.images.posterThumb];
}

-(void)fetchImage:(NSString*)imageUrl{
    NSURL *imageURL = [NSURL URLWithString:imageUrl];
    UIImage *placeholder = [UIImage imageNamed:@"placeholder"];
    [self.thumbImage sd_setImageWithURL:imageURL placeholderImage:placeholder];
}

@end
