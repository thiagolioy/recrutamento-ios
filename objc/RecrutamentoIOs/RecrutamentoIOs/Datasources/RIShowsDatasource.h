//
//  RIShowsDatasource.h
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/9/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "BKBaseCollectionViewDatasourceAndDelegate.h"
#import "RIShowsModelContainer.h"

@interface RIShowsDatasource : BKBaseCollectionViewDatasourceAndDelegate<UICollectionViewDelegateFlowLayout>
@property(nonatomic,weak) RIShowsModelContainer *modelContainer;
@end
