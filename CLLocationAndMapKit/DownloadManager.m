//
//  DownloadManager.m
//  CLLocationAndMapKit
//
//  Created by Tim Beals on 2016-11-22.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import "DownloadManager.h"
#import "GeoImage.h"

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


- (NSURL *)constructURL {
    NSDictionary *queryDict = @{@"method" : @"flickr.photos.search", @"api_key" : @"4e835c1043b25f5b4711d4f021b45c9d", @"tags" : @"guitar", @"has_geo" : @"1", @"extras" : @"url_m", @"format" : @"json", @"nojsoncallback" : @"1"};
    
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


//https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=4e835c1043b25f5b4711d4f021b45c9d&photo_id=31068299401&format=json&nojsoncallback=1

@end
