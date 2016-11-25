//
//  CollectionViewCell.h
//  CLLocationAndMapKit
//
//  Created by Tim Beals on 2016-11-23.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeoImage.h"

@interface CollectionViewCell : UICollectionViewCell


@property (strong, nonatomic) GeoImage *geoImage;

- (void)configureCellWithGeoImage:(GeoImage *)geoImage andImage:(UIImage *)image;
- (void)clearCellForDownload;

@end
