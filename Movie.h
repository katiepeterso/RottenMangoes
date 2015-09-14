//
//  Movie.h
//  RottenMangoes1
//
//  Created by Katherine Peterson on 2015-09-14.
//  Copyright (c) 2015 KatieExpatriated. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Movie : NSObject

@property (nonatomic) NSString *movieTitle;
@property (nonatomic) NSNumber *movieRunTime;
@property (nonatomic) UIImage *moviePoster;
@property (nonatomic) NSString *movieReleaseDate;
@property (nonatomic) NSString *movieSynopsis;
@property (nonatomic) NSArray *movieReviews;
@property (nonatomic) NSDictionary *movieRatings;
@property (nonatomic) NSString *movieMPAARating;

- (void)movieWithJSON:(NSDictionary *)json;

@end