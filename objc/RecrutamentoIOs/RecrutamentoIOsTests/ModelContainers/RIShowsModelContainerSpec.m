//
//  RIShowsModelContainerSpec.m
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import <Specta.h>
#import <Expecta/Expecta.h>
#import <TLJsonFactory.h>
#import "RIShowsModelContainer.h"

SpecBegin(RIShowsModelContainerSpec)

describe(@"RIShowsModelContainer", ^{
    __block RIShowsModelContainer *modelContainer;
    beforeAll(^{
        modelContainer = [RIShowsModelContainer new];
        modelContainer.shows = @[@1];
    });
    it(@"should be able to create a container obj", ^{
        expect([RIShowsModelContainer new]).toNot.beNil();
    });
    it(@"should be 1 obj", ^{
        expect(modelContainer.shows.count).to.equal(1);
    });
    
    it(@"should be able to add more shows", ^{
        [modelContainer addMoreShows:@[@2,@3]];
        expect(modelContainer.shows.count).to.equal(3);
    });
});

SpecEnd
