//
//  RIShowsDatasource.m
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/9/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "RIShowsDatasource.h"
#import "RIShowCell.h"
#import "RIShow.h"

@implementation RIShowsDatasource
@dynamic modelContainer;

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelContainer.shows.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RIShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RIShowCell cellIdentifier] forIndexPath:indexPath];
    RIShow *show = [self.modelContainer.shows objectAtIndex:indexPath.row];
    [cell setup:show];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [RIShowCell cellSizeForBounds:self.controller.view.bounds
                         paddingBtwCells:10];
}

@end
