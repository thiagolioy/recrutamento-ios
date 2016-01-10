//
//  RIViewControllerSpec.m
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//


#import <Specta.h>
#import <Expecta/Expecta.h>
#import <TLJsonFactory.h>
#import "RIShowsDatasource.h"
#import "ViewController.h"
#import "RIStubsHelper.h"
#import <OCMock/OCMock.h>
#import "RiShow.h"

@interface ViewController ()
@property(nonatomic,weak) IBOutlet UICollectionView *collectionView;
-(void)setupInitialValues;
-(void)setupPullRefresh;
-(void)fixSVPullToRefreshBug;
-(void)setupInfiniteScroll;
-(BOOL)shouldHandleNoMorePagesToFetchFlow;
-(void)setupDatasource;
-(RIShowsModelContainer *)modelContainer;
-(void)fetchPopularShows;
-(void)fetchAddittionalPopularShows;
@end

SpecBegin(RIViewControllerSpec)

describe(@"RIViewController", ^{
    __block ViewController *controller;
    beforeEach(^{
        [RIStubsHelper stubSuccessResponseDefaultHeaderWithFixture:@"popular_shows"];
        controller =  (ViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
        [controller view];
    });
    
    afterEach(^{
        controller = nil;
    });
    
    it(@"should have a valid modelContainer", ^{
        expect(controller.modelContainer).toNot.beNil();
    });
    
    it(@"should have a valid controller", ^{
        expect(controller).toNot.beNil();
    });
    
    it(@"should have a valid collectionView", ^{
        expect(controller.collectionView).toNot.beNil();
    });
    
    
    it(@"should meet expectations", ^{
        id controllerMock = [OCMockObject partialMockForObject:controller];
        [[[controllerMock expect] andForwardToRealObject] setupInfiniteScroll];
        [[[controllerMock expect] andForwardToRealObject] setupPullRefresh];
        [[[controllerMock expect] andForwardToRealObject] setupInitialValues];
        [[[controllerMock expect] andForwardToRealObject] fetchPopularShows];
        
        [controller viewDidLoad];
        
        [controllerMock verify];
        [controllerMock stopMocking];
    });
    
    it(@"should call fixSVPullToRefreshBug when  setupPullRefresh is called", ^{
        id controllerMock = [OCMockObject partialMockForObject:controller];
        [[controllerMock expect] fixSVPullToRefreshBug];
        
        [controller setupPullRefresh];
        
        [controllerMock verify];
        [controllerMock stopMocking];
    });
    
    
    
});

SpecEnd
