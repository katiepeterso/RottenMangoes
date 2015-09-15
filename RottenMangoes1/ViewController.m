//
//  ViewController.m
//  RottenMangoes1
//
//  Created by Katherine Peterson on 2015-09-14.
//  Copyright (c) 2015 KatieExpatriated. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"
#import "MovieCell.h"
#import "DetailViewController.h"


@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property NSMutableArray *movies;
@property (nonatomic) Movie *currentMovie;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) CGPoint touchLocation;

@end

@implementation ViewController

NSString * const urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=j9fhnct2tp8wu2q9h75kanh9&page_limit=50";


#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.movies = [NSMutableArray new];
    
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
            });
        }
    }];
    
    [dataTask resume];
}

#pragma mark - UICollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MovieCell" forIndexPath:indexPath];
    [cell buildCellWith:self.movies[indexPath.row]];
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MovieCell *)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        Movie *object = self.movies[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - General Methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
