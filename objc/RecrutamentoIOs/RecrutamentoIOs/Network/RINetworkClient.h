//
//  RINetworkClient.h
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/9/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FetchPopularShowsSuccess)(NSArray *shows);
typedef void (^Finally)(void);

@interface RINetworkClient : NSObject
+ (instancetype)sharedClient;
-(void)fetchPopularShows:(FetchPopularShowsSuccess)success finally:(Finally)finally;
@end