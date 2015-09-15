//
//  Review.m
//  RottenMangoes1
//
//  Created by Katherine Peterson on 2015-09-14.
//  Copyright (c) 2015 KatieExpatriated. All rights reserved.
//

#import "Review.h"

@implementation Review

- (void)reviewWithJSON:(NSDictionary *)json {
    self.reviewQuote = json[@"quote"];
}


@end
