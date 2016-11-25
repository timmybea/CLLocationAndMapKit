//
//  CollectionViewCell.m
//  CLLocationAndMapKit
//
//  Created by Tim Beals on 2016-11-23.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import "CollectionViewCell.h"


@interface CollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation CollectionViewCell

- (void)clearCellForDownload
{
    self.imageView.image = nil;
    self.label.text = nil;
    self.activityIndicator.hidden = NO;
}

- (void)configureCellWithGeoImage:(GeoImage *)geoImage andImage:(UIImage *)image;
{
    self.activityIndicator.hidden = YES;
    self.label.text = geoImage.title;
    self.imageView.image = image;
}

@end
