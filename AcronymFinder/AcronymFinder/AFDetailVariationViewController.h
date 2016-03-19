//
//  AFDetailVariationViewController.h
//  AcronymFinder
//
//  Created by Randhir Kumar on 3/19/16.
//  Copyright © 2016 @Randhir Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFMeaningDataModel.h"

@interface AFDetailVariationViewController : UITableViewController
/**
 *  Data Model for Meanings of acronyms
 */
@property (nonatomic,weak) AFMeaningDataModel *lfWordMeaning;


@end
