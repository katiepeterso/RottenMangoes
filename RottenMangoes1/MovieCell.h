//
//  MovieCell.h
//  RottenMangoes1
//
//  Created by Katherine Peterson on 2015-09-14.
//  Copyright (c) 2015 KatieExpatriated. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface MovieCell : UICollectionViewCell

@property (nonatomic)Movie *movieForCell;

-(void)buildCellWith:(Movie *)movie;

@end
