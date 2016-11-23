//
//  ViewController.m
//  CLLocationAndMapKit
//
//  Created by Tim Beals on 2016-11-22.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import "ViewController.h"
#import "DownloadManager.h"

@interface ViewController ()

@property (strong, nonatomic) LocationsManager *locationManager;
@property (strong, nonatomic) DownloadManager *downloadManager;
@property (strong, nonatomic) NSArray *geoImages;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 //   self.locationManager = [[LocationsManager alloc] init];
    self.downloadManager = [[DownloadManager alloc] init];

    [self getPhotos];
    
    
}




- (void)getPhotos {
    [self.downloadManager downloadPhotos:^(NSArray *geoImages) {
        self.geoImages = geoImages;
    }];
}

@end
