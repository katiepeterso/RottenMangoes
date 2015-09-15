//
//  Movie.m
//  RottenMangoes1
//
//  Created by Katherine Peterson on 2015-09-14.
//  Copyright (c) 2015 KatieExpatriated. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (void)movieWithJSON:(NSDictionary *)json {
    self.movieTitle = json[@"title"];
    self.movieMPAARating = json[@"mpaa_rating"];
    self.movieReleaseDate = json[@"release_dates"][@"theater"];
    self.movieThumbnailURLString = json[@"posters"][@"original"];
    self.moviePosterURLString = [self getHighResImageWithURL:self.movieThumbnailURLString];
    
    self.movieRunTime = json[@"runtime"];
    self.movieSynopsis = json[@"synopsis"];
    self.movieReviews = json[@""];
    self.movieRatings = json[@"ratings"];
}

- (NSString *)getHighResImageWithURL:(NSString *)urlString {
    NSArray *urlPathComponents = [urlString pathComponents];
    NSArray *trimmedURLPathComponents = [urlPathComponents subarrayWithRange:NSMakeRange(4, urlPathComponents.count-4)];
    return [NSString pathWithComponents:trimmedURLPathComponents];
}

@end
