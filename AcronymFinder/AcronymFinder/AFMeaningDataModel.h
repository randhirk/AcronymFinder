//
//  AFMeaningDataModel.h
//  AcronymFinder
//
//  Created by Randhir Kumar on 3/19/16.
//  Copyright © 2016 @Randhir Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFMeaningDataModel : NSObject

/**
 *  actual acronym meaning
 */
@property(nonatomic,copy)NSString *lfWordMeaning;
/**
 *  variations
 */
@property(nonatomic,copy)NSMutableArray *var;
/**
 *  Frequency
 */
@property NSInteger frequency;
/**
 *  first time used
 */
@property NSInteger since;

@end
