//
//  RINetworkClientSpec.m
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//


#import <Specta.h>
#import <Expecta/Expecta.h>
#import <TLJsonFactory.h>
#import <OCMock/OCMock.h>
#import "RINetworkClient.h"
#import "RIStubsHelper.h"
#import <AFNetworking.h>

@interface RINetworkClient ()
@property(nonatomic,strong) AFHTTPSessionManager *manager;
-(void)setupCustomHeadersForManager:(AFHTTPSessionManager*)manager;

-(void)fetchPopularShowsOnPage:(NSInteger)page
                       success:(FetchPopularShowsSuccess)success
                       finally:(Finally)finally;
-(void)sendErrorMsg:(NSString*)errorMsg;
-(void)handleError:(NSError *)error;
@end

SpecBegin(RINetworkClientSpec)

describe(@"RINetworkClient", ^{
    __block RINetworkClient *sharedClient;
    beforeEach(^{
        sharedClient = [RINetworkClient sharedClient];
        sharedClient.manager = nil;
    });
    
    
    it(@"should call setup headers during lazy load manager", ^{
        id clientMock = [OCMockObject partialMockForObject:sharedClient];
        [[clientMock expect] setupCustomHeadersForManager:OCMOCK_ANY];
        [sharedClient manager];
        [clientMock verify];
        [clientMock stopMocking];
    });
    
    context(@"valid error", ^{
        it(@"should call sendErrorMsg when handlerError method is called", ^{
            id clientMock = [OCMockObject partialMockForObject:sharedClient];
            [[clientMock expect] sendErrorMsg:OCMOCK_ANY];
            [sharedClient handleError:nil];
            [clientMock verify];
            [clientMock stopMocking];
        });
    });
    
    context(@"invalida error", ^{
        it(@"should call sendErrorMsg when handlerError method is called", ^{
            id clientMock = [OCMockObject partialMockForObject:sharedClient];
            [[clientMock expect] sendErrorMsg:OCMOCK_ANY];
            [sharedClient handleError:[NSError errorWithDomain:@"" code:-1009 userInfo:nil]];
            [clientMock verify];
            [clientMock stopMocking];
        });
    });
    
    
    context(@"status code 200 response", ^{
        beforeEach(^{
            [RIStubsHelper stubSuccessResponseDefaultHeaderWithFixture:@"popular_shows"];
        });
        it(@"should not call handle error for 200", ^{
            id clientMock = [OCMockObject partialMockForObject:sharedClient];
            [[clientMock reject] handleError:OCMOCK_ANY];
            waitUntil(^(DoneCallback done) {
                [sharedClient fetchPopularShowsOnPage:1 success:^(NSArray *shows, BOOL hasNextPage) {} finally:^{done();}];
            });
            [clientMock verify];
            [clientMock stopMocking];
        });
    });
    
    context(@"status code 500 response", ^{
        beforeEach(^{
            [RIStubsHelper stubResponseWithFixture:@"error_response" responseKind:NSDictionary.class statusCode:500 headers:@{@"Content-Type":@"application/json"}];
        });
        it(@"should call handle error for 500 response", ^{
            id clientMock = [OCMockObject partialMockForObject:sharedClient];
            [[clientMock expect] handleError:OCMOCK_ANY];
            waitUntil(^(DoneCallback done) {
                [sharedClient fetchPopularShowsOnPage:1 success:^(NSArray *shows, BOOL hasNextPage) {} finally:^{done();}];
            });
            
            [clientMock verify];
            [clientMock stopMocking];
        });
    });
    
    
    
});

SpecEnd
