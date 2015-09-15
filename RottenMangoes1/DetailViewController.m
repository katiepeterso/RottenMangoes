//
//  DetailViewController.m
//  RottenMangoes1
//
//  Created by Katherine Peterson on 2015-09-14.
//  Copyright (c) 2015 KatieExpatriated. All rights reserved.
//

#import "DetailViewController.h"
#import "Movie.h"
#import "Review.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailMovieImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailMovieTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailSynopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailReleaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailRunTimeLabel;
@property (nonatomic) Review *currentReview;
@property (nonatomic) NSMutableArray *reviews;
@property (weak, nonatomic) IBOutlet UILabel *detailReviewsLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDetailItem:(Movie *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailMovieTitle.text = self.detailItem.movieTitle;
        self.detailRatingLabel.text = [@"MPAA Rating: " stringByAppendingString:self.detailItem.movieMPAARating];
        self.detailSynopsisLabel.text = self.detailItem.movieSynopsis;
        self.detailReleaseLabel.text = [@"Release Date: " stringByAppendingString:self.detailItem.movieReleaseDate];
        self.detailRunTimeLabel.text = [[@"Run Time: " stringByAppendingString:[self.detailItem.movieRunTime stringValue]]stringByAppendingString:@" minutes"];
        
        self.detailMovieImageView.image = nil;
        
        NSString *posterString = self.detailItem.moviePosterURLString;
        NSURL *posterURL = [NSURL URLWithString:posterString];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:posterURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            if (!error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([posterString isEqualToString:self.detailItem.moviePosterURLString]) {
                        self.detailMovieImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                    }
                });
            }
        }];
        
        [downloadTask resume];
        
        self.reviews = [NSMutableArray new];
        NSURLSessionTask *reviewTask = [session dataTaskWithURL:[NSURL URLWithString:self.detailItem.movieReviewURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (!error) {
                
                NSError *jsonError = nil;
                
                NSArray *reviewsArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError][@"reviews"];
                
                for (NSDictionary *eachReview in reviewsArray){
                    self.currentReview = [Review new];
                    [self.currentReview reviewWithJSON:eachReview];
                    
                    [self.reviews addObject:self.currentReview.reviewQuote];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
    
                    self.detailReviewsLabel.text = [@"Reviews\n\n" stringByAppendingString:[self.reviews componentsJoinedByString:@"\n\n"]];
                });
            }
        }];
        
        [reviewTask resume];

    }
}
@end
