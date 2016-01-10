//
//  RIStubsHelper.h
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RIStubsHelper : NSObject
+(void)stubResponseWithFixture:(NSString*)fixtureJson
                  responseKind:(Class)class
statusCode:(int)statusCode
headers:(NSDictionary *)headers;
+(void)stubResponseWithObjResponse:(NSDictionary*)objResponse
                        statusCode:(int)statusCode
                           headers:(NSDictionary *)headers;
+(void)stubSuccessResponseWithDefaultHeaderWithResponseObj:(NSDictionary*)responseObj;
+(void)stubSuccessResponseDefaultHeaderWithFixture:(NSString*)fixtureJson;
@end
