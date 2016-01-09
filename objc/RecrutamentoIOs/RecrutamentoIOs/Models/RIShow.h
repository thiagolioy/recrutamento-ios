//
//  RIShow.h
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/9/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import <bricks-Mantle/BKMBaseMantleObj.h>

@interface RIShowImages : BKMBaseMantleObj
@property(nonatomic,strong)NSString *posterThumb;
@end

@interface RIShow : BKMBaseMantleObj
@property(nonatomic,strong) NSString *title;
@property(nonatomic,assign) NSInteger year;
@property(nonatomic,assign) NSInteger traktID;
@property(nonatomic,strong) RIShowImages *images;
@end



