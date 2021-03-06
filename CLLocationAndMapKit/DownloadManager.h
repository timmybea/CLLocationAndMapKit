//
//  DownloadManager.h
//  CLLocationAndMapKit
//
//  Created by Tim Beals on 2016-11-22.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeoImage.h"

@interface DownloadManager : NSObject

- (void)downloadPhotos:(void (^)(NSArray *geoImages)) completion;
- (void)getImageWithURLFromGeoImage:(GeoImage *)geoImage withCompletion:(void (^)(UIImage *image, NSURL *url)) completion;

@end
