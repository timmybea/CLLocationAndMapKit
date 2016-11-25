//
//  ViewController.m
//  CLLocationAndMapKit
//
//  Created by Tim Beals on 2016-11-22.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import "ViewController.h"
#import "DownloadManager.h"
#import "CollectionViewCell.h"
#import "GeoImage.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) LocationsManager *locationManager;
@property (strong, nonatomic) DownloadManager *downloadManager;
@property (strong, nonatomic) NSArray *geoImages;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



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
        [self.collectionView reloadData];
    }];
}


#pragma - collection view delegate methods -

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.geoImages.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    GeoImage *currentImage = [self.geoImages objectAtIndex:indexPath.row];
    cell.geoImage = currentImage;
    [cell clearCellForDownload];
    [self.downloadManager getImageWithURLFromGeoImage:currentImage withCompletion:^(UIImage *image, NSURL *url)
    {
        if([cell.geoImage.imageURL isEqual:url])
        {
            [cell configureCellWithGeoImage:currentImage andImage:image];
        }
    }];
    
    return cell;
}

@end






