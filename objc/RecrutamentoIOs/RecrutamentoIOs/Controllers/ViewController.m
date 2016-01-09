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
#import <SVPullToRefresh.h>
#import <libextobjc/EXTScope.h>

@interface ViewController ()
@property(nonatomic,weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic,weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,weak) IBOutlet UIView *showsCollectionContainer;
@property(nonatomic,assign) NSInteger currentPage;
@property(nonatomic,strong) RIShowsDatasource *datasource;
@property(nonatomic,strong) RIShowsModelContainer *modelContainer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInitialCurrentPageValue];
    [self fetchPopularShows];
    [self setupPullRefresh];
    [self setupInfiniteScroll];
}

-(void)setupInitialCurrentPageValue{
    self.currentPage = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupPullRefresh{
    [self fixSVPullToRefreshBug];
    @weakify(self);
    id handler = ^{
        @strongify(self);
        self.currentPage = 1;
        [self fetchPopularShows];
        [self.collectionView.pullToRefreshView stopAnimating];
    };
    [self.collectionView addPullToRefreshWithActionHandler:handler];
}

-(void)fixSVPullToRefreshBug{
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        UIEdgeInsets insets = self.collectionView.contentInset;
        insets.top = self.navigationController.navigationBar.bounds.size.height +
        [UIApplication sharedApplication].statusBarFrame.size.height;
        self.collectionView.contentInset = insets;
        self.collectionView.scrollIndicatorInsets = insets;
    }
}

-(void)setupInfiniteScroll{
    @weakify(self);
    id handler = ^{
        @strongify(self);
        self.currentPage++;
        [self fetchAddittionalPopularShows];
    };
    [self.collectionView addInfiniteScrollingWithActionHandler:handler];
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
    [self.activityIndicator startAnimating];
    @weakify(self);
    
    id successBlock = ^(NSArray *shows) {
        @strongify(self);
        self.modelContainer.shows = shows;
        [self setupDatasource];
    };
    id finallyBlock = ^{
        @strongify(self);
        self.showsCollectionContainer.hidden = NO;
        [self.activityIndicator stopAnimating];
    };
    
    [[RINetworkClient sharedClient] fetchPopularShowsOnPage:self.currentPage
                                                    success:successBlock
                                                    finally:finallyBlock];
}

-(void)fetchAddittionalPopularShows{
    @weakify(self);
    id successBlock = ^(NSArray *shows) {
        @strongify(self);
        [self.modelContainer addMoreShows:shows];
        [self.collectionView reloadData];
    };
    id finallyBlock = ^{
        @strongify(self);
        [self.collectionView.infiniteScrollingView stopAnimating];
    };
    
    [[RINetworkClient sharedClient] fetchPopularShowsOnPage:self.currentPage
                                                    success:successBlock
                                                    finally:finallyBlock];
}


@end
