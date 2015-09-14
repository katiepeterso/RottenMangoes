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
    self.moviePoster = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:json[@"posters"][@"original"]]]];
    self.movieRunTime = json[@"runtime"];
    self.movieSynopsis = json[@"synopsis"];
    self.movieReviews = json[@""];
    self.movieRatings = json[@"ratings"];
}

@end
