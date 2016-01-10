//
//  RIStubsHelper.m
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "RIStubsHelper.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <TLJsonFactory.h>

@implementation RIStubsHelper

+(void)stubResponseWithFixture:(NSString*)fixtureJson
                  responseKind:(Class)class
                    statusCode:(int)statusCode
                       headers:(NSDictionary *)headers{
    
    id stubRequest = ^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"api-v2launch.trakt.tv"];
    };
    
    id stubResponse = ^OHHTTPStubsResponse*(NSURLRequest *request) {
        
        BOOL isDict = [class isSubclassOfClass:[NSDictionary class]];
        
        id data = isDict ? [TLJsonFactory tl_jsonDictFromFile:fixtureJson]:[TLJsonFactory tl_jsonArrayFromFile:fixtureJson];
        
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                           options:0
                                                             error:&error];
        return [OHHTTPStubsResponse responseWithData:jsonData
                                          statusCode:statusCode
                                             headers:headers];
        
    };
    
    [OHHTTPStubs stubRequestsPassingTest:stubRequest
                        withStubResponse:stubResponse];
}

+(void)stubResponseWithObjResponse:(NSDictionary*)objResponse
                        statusCode:(int)statusCode
                           headers:(NSDictionary *)headers{
    
    id stubRequest = ^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"api-v2launch.trakt.tv"];
    };
    
    id stubResponse = ^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:objResponse
                                                           options:0
                                                             error:&error];
        return [OHHTTPStubsResponse responseWithData:jsonData
                                          statusCode:statusCode
                                             headers:headers];
        
    };
    
    [OHHTTPStubs stubRequestsPassingTest:stubRequest
                        withStubResponse:stubResponse];
}
+(void)stubSuccessResponseWithDefaultHeaderWithResponseObj:(NSDictionary*)responseObj{
    [RIStubsHelper stubResponseWithObjResponse:responseObj
                                      statusCode:200
                                         headers:@{@"Content-Type":@"application/json"}];
    
}


+(void)stubSuccessResponseDefaultHeaderWithFixture:(NSString*)fixtureJson{
    [RIStubsHelper stubResponseWithFixture:fixtureJson
                                responseKind:[NSArray class]
                                  statusCode:200
                                     headers:@{@"Content-Type":@"application/json"}];
    
}

@end
