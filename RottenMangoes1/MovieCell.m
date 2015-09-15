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
@property (nonatomic) NSURLSessionDownloadTask *downloadTask;

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
    
    if (self.downloadTask){
        [self.downloadTask suspend];
        [self.downloadTask cancel];
    }
    
    NSString *posterString = movie.movieThumbnailURLString;
    NSURL *posterURL = [NSURL URLWithString:posterString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    self.downloadTask = [session downloadTaskWithURL:posterURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            if ([posterString isEqualToString:movie.movieThumbnailURLString]) {
                UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                dispatch_async(dispatch_get_main_queue(), ^{
                self.movieImageView.image = downloadedImage;
                });
            };
        }
    }];
    
    [self.downloadTask resume];
}

@end
