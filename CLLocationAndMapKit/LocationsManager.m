//
//  LocationsManager.m
//  CLLocationAndMapKit
//
//  Created by Tim Beals on 2016-11-22.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import "LocationsManager.h"

@interface  LocationsManager() <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *CLlocationManager;
@property (strong, nonatomic) CLLocation *startLocation;

@end

@implementation LocationsManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setupCLLocationManager];
    }
    return self;
}


- (void)setupCLLocationManager
{
    self.CLlocationManager = [[CLLocationManager alloc] init];
    self.CLlocationManager.delegate = self;
    self.CLlocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    [self.CLlocationManager requestWhenInUseAuthorization];
}



#pragma - CLLocationManager delegate methods -

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kSecAttrAccessibleAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.CLlocationManager startUpdatingLocation];
    }
    else
    {
        [self.CLlocationManager stopUpdatingLocation];
        NSLog(@"location services have stopped");
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if(self.startLocation == nil)
    {
        self.startLocation = locations.firstObject;
    }
    else
    {
        CLLocation *latestLocation = [locations lastObject];
        NSLog(@"location: %@", latestLocation);
        
    }
}


@end
