//
//  RIShowSpec.m
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/9/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import <Specta.h>
#import <Expecta/Expecta.h>
#import <TLJsonFactory.h>
#import "RIShow.h"

SpecBegin(RIShowSpec)

describe(@"RIShow", ^{
    __block RIShow *show;
    beforeAll(^{
        NSDictionary *dc = [TLJsonFactory tl_jsonDictFromFile:@"show"];
        NSError *error = nil;
        show = [RIShow parse:dc error:&error];
        expect(error).to.beNil();
    });
    it(@"should be able to parse json into obj", ^{
        expect(show).toNot.beNil();
    });
    it(@"should have a Images obj from kind", ^{
        expect(show.images).to.beKindOf(RIShowImages.class);
    });
    
    it(@"should have a valid Images obj", ^{
        expect(show.images).toNot.beNil();
    });
    it(@"should have a valid posterThumbImage", ^{
        expect(show.images.posterThumb).to.equal(@"https://walter.trakt.us/images/shows/000/001/390/posters/thumb/93df9cd612.jpg");
    });
    
    it(@"should be able to parse shows", ^{
        NSArray *showsDict = [TLJsonFactory tl_jsonArrayFromFile:@"popular_shows"];
        NSError *error = nil;
        NSArray *array = [RIShow parseArray:showsDict error:&error];
        expect(error).to.beNil();
        expect(array).toNot.beNil();
    });
});

SpecEnd
