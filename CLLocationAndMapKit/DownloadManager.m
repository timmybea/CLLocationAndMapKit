//
//  DownloadManager.m
//  CLLocationAndMapKit
//
//  Created by Tim Beals on 2016-11-22.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import "DownloadManager.h"



@interface DownloadManager()

@end

@implementation DownloadManager


- (void)downloadPhotos:(void (^)(NSArray *geoImages)) completion
{
    
    NSURL *url = [self constructURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
                    
        //parse the json into a usable dictionary of elements
        NSDictionary *photosDict = jsonDictionary[@"photos"];
        NSArray *arrayOfPhotos = photosDict[@"photo"];
        
        //turn the array of json data into an array of geoImage objects.
        NSArray *arrayOfGeoImages = [GeoImage geoImagesWithArray:arrayOfPhotos];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(arrayOfGeoImages);
        }];
    }];
    
    [dataTask resume];
}

- (void)getImageWithURLFromGeoImage:(GeoImage *)geoImage withCompletion:(void (^)(UIImage *image, NSURL *url)) completion
{
    NSURL *url = geoImage.imageURL;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        if (error)
        {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(image, geoImage.imageURL);
        }];
    }];
    [downloadTask resume];
}










//
//- (void) downloadLocationData:(NSArray *)geoImages
//{
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    for (GeoImage *geoImage in geoImages)
//    {
//        NSURL *url = [self constructImageURL:geoImage];
//
//        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//
//        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            
//            if (error) {
//                NSLog(@"error: %@", error.localizedDescription);
//                return;
//            }
//            
//            NSError *jsonError = nil;
//            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//            
//            if (jsonError) {
//                NSLog(@"jsonError: %@", jsonError.localizedDescription);
//                return;
//            }
//        
//            NSDictionary *location = jsonDictionary[@"photo"][@"location"];
//            [geoImage coordinateWithDictionary:location];
//            
//        }];
//        [dataTask resume];
//    }
//}


- (NSURL *)constructURL {
    NSDictionary *queryDict = @{@"method" : @"flickr.photos.search", @"api_key" : @"4e835c1043b25f5b4711d4f021b45c9d", @"tags" : @"guitars", @"has_geo" : @"1", @"extras" : @"url_m", @"format" : @"json", @"nojsoncallback" : @"1"};
    
    NSMutableArray *queries = [NSMutableArray new];
    for (NSString *key in queryDict) {
        [queries addObject:[NSURLQueryItem queryItemWithName:key value:queryDict[key]]];
    }
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = @"api.flickr.com";
    components.path = @"/services/rest/";
    components.queryItems = queries;
    
    return components.URL;
}



//- (NSURL *)constructImageURL:(GeoImage *)geoImage
//{
//    NSDictionary *queryDict = @{@"method" : @"flickr.photos.geo.getlocation", @"api_key" : @"4e835c1043b25f5b4711d4f021b45c9d", @"photo_id" : geoImage.imageId, @"format" : @"json", @"nojsoncallback" : @"1"};
//    
//    NSArray *keys = @[@"method", @"api_key", @"photo_id", @"format", @"nojsoncallback"];
//    
//    NSMutableArray *queries = [NSMutableArray new];
//    for (NSString *key in keys) {
//        [queries addObject:[NSURLQueryItem queryItemWithName:key value:queryDict[key]]];
//    }
//    
//    NSURLComponents *components = [[NSURLComponents alloc] init];
//    components.scheme = @"https";
//    components.host = @"api.flickr.com";
//    components.path = @"/services/rest/";
//    components.queryItems = queries;
//    
//    return components.URL;
//    
//}


@end
