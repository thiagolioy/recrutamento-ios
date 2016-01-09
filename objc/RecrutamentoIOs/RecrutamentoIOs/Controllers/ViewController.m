//
//  ViewController.m
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/9/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

#import "ViewController.h"
#import "RINetworkClient.h"

@interface ViewController ()

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


-(void)fetchPopularShows{
    [[RINetworkClient sharedClient] fetchPopularShows:^(NSArray *shows) {
        
    } finally:^{
        
    }];
}

@end
