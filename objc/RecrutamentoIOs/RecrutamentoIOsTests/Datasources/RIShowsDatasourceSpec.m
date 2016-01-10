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
#import "RiShow.h"

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
        NSArray *showsDict = [TLJsonFactory tl_jsonArrayFromFile:@"popular_shows"];
        NSError *error = nil;
        NSArray *array = [RIShow parseArray:showsDict error:&error];
        expect(error).to.beNil();
        
        controller =  (ViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
        [controller view];
        
        controller.modelContainer = [RIShowsModelContainer new];
        controller.modelContainer.shows = array;
        controller.datasource = [[RIShowsDatasource alloc] initWithModelContainer:        controller.modelContainer
                                                            controller:controller
                                                        collectionView:controller.collectionView];
        controller.collectionView.dataSource = controller.datasource;
        controller.collectionView.delegate = controller.datasource;
        [controller.collectionView reloadData];

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
    
    it(@"should have a valid datasource", ^{
        expect(controller.datasource).toNot.beNil();
    });
    
    it(@"should have a expected numberOfItens", ^{
        NSInteger numberOfItens = [controller.datasource collectionView:controller.collectionView numberOfItemsInSection:0];;
        expect(numberOfItens).to.equal(4);
    });
    
    it(@"should conform to collectionView protocol", ^{
        expect(controller.datasource).to.conformTo(@protocol(UICollectionViewDataSource));
        expect(controller.datasource).to.conformTo(@protocol(UICollectionViewDelegate));
    });
    it(@"should have a implementation of numberOfItemsInSection", ^{
        expect(controller.datasource).to.respondTo(@selector(collectionView:numberOfItemsInSection:));
    });
    
    it(@"should have a implementation of  to collectionView protocol", ^{
        expect(controller.datasource).to.respondTo(@selector(collectionView:cellForItemAtIndexPath:));
    });
});

SpecEnd
