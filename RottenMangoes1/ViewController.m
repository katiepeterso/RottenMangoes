//
//  ViewController.m
//  RottenMangoes1
//
//  Created by Katherine Peterson on 2015-09-14.
//  Copyright (c) 2015 KatieExpatriated. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"

@interface ViewController ()

@property NSMutableArray *movies;
@property (nonatomic) Movie *currentMovie;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.movies = [NSMutableArray new];
    
    
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=j9fhnct2tp8wu2q9h75kanh9&page_limit=50";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            NSArray *moviesArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError][@"movies"];
            
            for (NSDictionary *eachMovie in moviesArray){
                self.currentMovie = [Movie new];
                [self.currentMovie movieWithJSON:eachMovie];
                
                [self.movies addObject:self.currentMovie];
            }
            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [self.tableView reloadData];
//                
//            });
            
        }
        
    }];
    
    [dataTask resume];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
