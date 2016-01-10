//
//  RIShowsDatasourceSpec.m
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

@interface ViewController ()
@property(nonatomic,weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic,weak) IBOutlet UIView *showsCollectionContainer;
@property(nonatomic,strong) RIShowsDatasource *datasource;
@property(nonatomic,strong) RIShowsModelContainer *modelContainer;
@end

SpecBegin(RIShowsDatasourceSpec)

describe(@"RIShowsDatasource", ^{
    __block ViewController *controller;
    beforeEach(^{
        
        [RIStubsHelper stubSuccessResponseDefaultHeaderWithFixture:@"shows"];
        
        controller =  (ViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
        
        controller.modelContainer = [RIShowsModelContainer new];
        controller.datasource = [[RIShowsDatasource alloc] initWithModelContainer:        controller.modelContainer
                                                            controller:controller
                                                        collectionView:controller.collectionView];
        [controller view];

    });
    
    afterEach(^{
        controller = nil;
    });
    
    it(@"should have a valid modelContainer", ^{
        expect(controller.modelContainer).toNot.beNil();
    });
    

});

SpecEnd
