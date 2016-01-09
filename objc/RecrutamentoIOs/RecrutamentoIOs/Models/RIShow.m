//
//  RIShow.m
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/9/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "RIShow.h"

@implementation RIShowImages
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"posterThumb":@"poster.thumb"
             };
}
@end

@implementation RIShow
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"title":@"title",
             @"year":@"year",
             @"traktID":@"ids.trakt",
             @"images":@"images"
             };
}

+ (NSValueTransformer *)imagesJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[RIShowImages class]];
}

@end
