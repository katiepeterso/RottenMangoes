//
//  Review.h
//  RottenMangoes1
//
//  Created by Katherine Peterson on 2015-09-14.
//  Copyright (c) 2015 KatieExpatriated. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property (nonatomic) NSString *reviewQuote;

- (void)reviewWithJSON:(NSDictionary *)json;

@end
