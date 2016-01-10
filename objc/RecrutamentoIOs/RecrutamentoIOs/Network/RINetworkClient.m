//
//  RINetworkClient.m
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/9/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "RINetworkClient.h"
#import <AFNetworking.h>
#import <AFNetworkActivityLogger.h>
#import "RIShow.h"
#import <TSMessage.h>
#import <libextobjc/EXTScope.h>

typedef NS_ENUM(NSInteger, ErrorStatusCode) {
    ServerErrorStatusCode = 500,
    NoInternetErrorCode = -1009
};

@interface RINetworkClient ()
@property(nonatomic,strong) AFHTTPSessionManager *manager;
@end

typedef void (^AFNSuccessBlock)(NSURLSessionDataTask *, id);
typedef void (^AFNFailureBlock)(NSURLSessionDataTask *, NSError *);

@implementation RINetworkClient

static RINetworkClient *_sharedInstance = nil;
+ (instancetype)sharedClient {
    static RINetworkClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        [[AFNetworkActivityLogger sharedLogger] startLogging];
    });
    return _sharedInstance;
}


- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager =  [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://api-v2launch.trakt.tv/"]];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [self setupCustomHeadersForManager:_manager];
    }
    return _manager;
}

-(void)setupCustomHeadersForManager:(AFHTTPSessionManager*)manager{
    [manager.requestSerializer setValue:@"95263dffcdf5ea8f1a58d226b042a7e995da4f66d37fb1378a4f9c54d7269535"
                      forHTTPHeaderField:@"trakt-api-key"];
    [manager.requestSerializer setValue:@"2"
                     forHTTPHeaderField:@"trakt-api-version"];

}

-(void)fetchPopularShowsOnPage:(NSInteger)page
                       success:(FetchPopularShowsSuccess)success
                       finally:(Finally)finally{
    NSDictionary *params = @{
                             @"extended":@"images",
                             @"page":[NSNumber numberWithInteger:page].stringValue,
                             @"limit":@"30"
                             };
    @weakify(self);
    
    id successBlock = ^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        @strongify(self);
        NSError *error = nil;
        NSArray *result = [RIShow parseArray:responseObject error:&error];
        BOOL failToParseResponse = result == nil;
        
        if(failToParseResponse)
            [self handleError:error];
        else
            success(result);
        
        finally();
    };
    
    id failureBlock = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self);
        [self handleError:error];
        finally();
    };
    
    [self.manager GET:@"shows/popular"
           parameters:params
              success:successBlock
              failure:failureBlock];
    

}

-(void)sendErrorMsg:(NSString*)errorMsg{
    [TSMessage showNotificationWithTitle:@"Ops .. "
                                subtitle:errorMsg
                                    type:TSMessageNotificationTypeError];
}

-(void)handleError:(NSError *)error{
    NSDictionary *errors = @{
                             @(NoInternetErrorCode):@"Your are offline, check your internet connection please!",
                              @(ServerErrorStatusCode):@"Server error, try later.."
                             };

    NSString *errorMsg = @"An unexpected error just happened.. Try again";
    if(error && [errors objectForKey:@(error.code)])
        errorMsg = [errors objectForKey:@(error.code)];
    
    [self sendErrorMsg:errorMsg];
    
}

@end
