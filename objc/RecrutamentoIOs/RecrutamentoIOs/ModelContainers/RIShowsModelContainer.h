//
//  RIShowsModelContainer.h
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/9/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RIShowsModelContainer : NSObject
@property(nonatomic,strong) NSArray *shows;

-(void)addMoreShows:(NSArray*)shows;
@end
