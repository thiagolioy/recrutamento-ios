//
//  ViewController.m
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/9/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "ViewController.h"
#import "RINetworkClient.h"
#import "RIShowsDatasource.h"
#import "RIShowsModelContainer.h"

@interface ViewController ()
@property(nonatomic,weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong) RIShowsDatasource *datasource;
@property(nonatomic,strong) RIShowsModelContainer *modelContainer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchPopularShows];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)setupDatasource{
    self.datasource = [[RIShowsDatasource alloc] initWithModelContainer:self.modelContainer
                                                             controller:self
                                                              collectionView:self.collectionView];
    self.collectionView.dataSource = self.datasource;
    self.collectionView.delegate = self.datasource;
    [self.collectionView reloadData];
}

-(RIShowsModelContainer *)modelContainer{
    if(!_modelContainer){
        _modelContainer = [RIShowsModelContainer new];
        _modelContainer.shows = @[];
    }
    return _modelContainer;
}

-(void)fetchPopularShows{
    [[RINetworkClient sharedClient] fetchPopularShows:^(NSArray *shows) {
        self.modelContainer.shows = shows;
        [self setupDatasource];
    } finally:^{
        
    }];
}

@end
