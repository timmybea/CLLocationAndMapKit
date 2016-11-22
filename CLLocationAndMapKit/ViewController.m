//
//  ViewController.m
//  CLLocationAndMapKit
//
//  Created by Tim Beals on 2016-11-22.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (strong, nonatomic) LocationsManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[LocationsManager alloc] init];

}


@end
