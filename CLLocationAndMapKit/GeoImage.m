//
//  GeoImage.m
//  CLLocationAndMapKit
//
//  Created by Tim Beals on 2016-11-22.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import "GeoImage.h"


@interface GeoImage() <MKAnnotation>

@property(nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString *imageId;

@end

@implementation GeoImage

- (instancetype)initWithImageInfo:(NSDictionary *)dictionary
{
    self = [super init];
    if(self)
    {
        self.title = dictionary[@"title"];
        self.imageId = dictionary[@"id"];
        NSString *string =
        [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",
         dictionary[@"farm"],
         dictionary[@"server"],
         dictionary[@"id"],
         dictionary[@"secret"]];
        self.imageURL = [NSURL URLWithString:string];
    }
    return self;
}

//turn the array of json data into an array of geoImage objects.
+ (NSArray *)geoImagesWithArray:(NSArray *)array
{
    NSMutableArray *arrayOfGeoImages = [[NSMutableArray alloc] init];
    
    for(NSDictionary *imageInfo in array)
    {
        GeoImage *newGeo = [[GeoImage alloc] initWithImageInfo:imageInfo];
        [arrayOfGeoImages addObject:newGeo];
    }
    
    return arrayOfGeoImages;
}


//- (void)coordinateWithDictionary:(NSDictionary *)dictionary
//{
// 
//    NSLog(@"hello");
//    NSNumber *latitude = [dictionary objectForKey:@"latitude"];
//    NSNumber *longitude = [dictionary objectForKey:@"longitude"];
//    
//    self.coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
//    
//}




@end
