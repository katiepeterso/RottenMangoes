//
//  MovieCell.m
//  RottenMangoes1
//
//  Created by Katherine Peterson on 2015-09-14.
//  Copyright (c) 2015 KatieExpatriated. All rights reserved.
//

#import "MovieCell.h"
#import "Movie.h"

@interface MovieCell ()

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;

@end

@implementation MovieCell

- (void)setMovieForCell:(Movie *)movieForCell {
    _movieForCell = movieForCell;
    [self buildCellWith:movieForCell];
}

#pragma mark - General Methods

-(void)buildCellWith:(Movie *)movie {
    self.movieTitleLabel.text = movie.movieTitle;
    self.movieImageView.image = nil;
    
    NSString *posterString = movie.movieThumbnailURLString;
    NSURL *posterURL = [NSURL URLWithString:posterString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:posterURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([posterString isEqualToString:movie.movieThumbnailURLString]) {
                    self.movieImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                }
            });
        }
    }];
    
    [downloadTask resume];
}

@end
