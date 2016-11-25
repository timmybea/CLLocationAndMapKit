//
//  GeoImage.h
//  CLLocationAndMapKit
//
//  Created by Tim Beals on 2016-11-22.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GeoImage : NSObject

@property (nonatomic) NSURL *imageURL;
@property (nonatomic) NSString *title;
+ (NSArray *)geoImagesWithArray:(NSArray *)array;

//- (void)coordinateWithDictionary:(NSDictionary *)dictionary;

@end
