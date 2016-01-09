//
//  RIShowsModelContainer.m
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/9/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "RIShowsModelContainer.h"

@implementation RIShowsModelContainer
-(void)addMoreShows:(NSArray*)shows{
    NSMutableArray *mutable =  ((NSArray *)self.shows.copy).mutableCopy;
    [mutable addObjectsFromArray:shows];
    self.shows = (NSArray*)mutable.copy;
}
@end
