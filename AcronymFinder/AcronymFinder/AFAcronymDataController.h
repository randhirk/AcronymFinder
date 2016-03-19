//
//  AFAcronymDataController.h
//  AcronymFinder
//
//  Created by Randhir Kumar on 3/19/16.
//  Copyright © 2016 @Randhir Kumar. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AFAFAcronymDataModel.h"


typedef void (^getDataBlock)(NSURLSessionTask *task, AFAFAcronymDataModel *dataModel);
typedef void (^getDataFailedBlock)(NSURLSessionTask *task, NSError *error);



@interface AFAcronymDataController : NSObject


/**
 *  This method is called to get the data from webservice
 *
 *  @param acronymString this is string passed as parameter dictionary
 *  @param data          data is received or not in this block
 *  @param failed        data received is failed will come in this block
 */
-(void)getURLResponse:(NSString*)acronymString gotData:(getDataBlock)data failed:(getDataFailedBlock)failed;



@end
