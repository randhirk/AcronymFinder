//
//  AFAcronymDataController.m
//  AcronymFinder
//
//  Created by Randhir Kumar on 3/19/16.
//  Copyright © 2016 @Randhir Kumar. All rights reserved.
//

#import "AFAcronymDataController.h"
#import "AFAFAcronymDataModel.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AFMeaningDataModel.h"

static NSString * const acronymBaseURLString = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";

@interface AFAcronymDataController()

@property(nonatomic,strong)AFAFAcronymDataModel *baseDataModel;

@end

@implementation AFAcronymDataController


#pragma mark - Initialization methods

- (id)init
{
    
    if ( self = [super init] )
    {
        self.baseDataModel = [[AFAFAcronymDataModel alloc] init];
    }
    return self;
}

-(void)getURLResponse:(NSString*)acronymString gotData:(getDataBlock)data failed:(getDataFailedBlock)failed
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  Made it nil to avoid contentType error during response
     */
    manager.responseSerializer.acceptableContentTypes = nil;
    
    /**
     *  Pass the parameter dictionary here
     */
    NSDictionary *parameters = @{@"sf": acronymString};
    
    
    [manager GET:acronymBaseURLString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        if (data) {
            data(task,[self parsedJsonObject:responseObject]);
        }
        NSLog(@"%@ %@", task, responseObject);
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failed) {
            failed(operation,error);
        }
    }];
    

}

/**
 *  Data is parsed here to the data model
 *
 *  @param responseObject response object is received from webservice call
 *
 *  @return base data model
 */
-(AFAFAcronymDataModel*)parsedJsonObject:(id)responseObject
{
    if([responseObject isKindOfClass:[NSArray class]] && [responseObject count] > 0 ){
        for(NSDictionary *dict in responseObject){
            self.baseDataModel = [[AFAFAcronymDataModel alloc] init];
            [self.baseDataModel setLfs:[self getlfsMeanings:[dict objectForKey:@"lfs"]]];
            [self.baseDataModel setSf:[dict objectForKey:@"sf"]];
            
            return self.baseDataModel;
        }
        
    }
    return nil;
}

-(NSMutableArray *) getlfsMeanings:(NSMutableArray *) responseArray {
    NSMutableArray *lfsmeaningArray = [NSMutableArray array];
    for(NSDictionary *dict in responseArray){
        
        AFMeaningDataModel *wordMeaning = [[AFMeaningDataModel alloc] init];
        [wordMeaning setLfWordMeaning:[dict objectForKey:@"lf"]] ;
        [wordMeaning setFrequency: [[dict objectForKey:@"freq"] integerValue]] ;
        [wordMeaning setSince: [[dict objectForKey:@"since"] integerValue]] ;
        [wordMeaning setVar:[self getwordVariations:[dict objectForKey:@"vars"]]];
        [lfsmeaningArray addObject:wordMeaning];
    }
    return lfsmeaningArray;
}

-(NSMutableArray *) getwordVariations:(NSMutableArray *) responseArray {
    NSMutableArray *variationsArray = [NSMutableArray array];
    for(NSDictionary *dict in responseArray){
        AFMeaningDataModel *meaning = [[AFMeaningDataModel alloc] init];
        [meaning setLfWordMeaning: [dict objectForKey:@"lf"]] ;
        [meaning setFrequency: [[dict objectForKey:@"freq"] integerValue]] ;
        [meaning setSince: [[dict objectForKey:@"since"] integerValue]] ;
        
        [variationsArray addObject:meaning];
    }
    return variationsArray;
}







@end
