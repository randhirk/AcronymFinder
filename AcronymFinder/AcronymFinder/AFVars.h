//
//  AFVars.h
//
//  Created by Randhir  on 3/19/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AFVars : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double freq;
@property (nonatomic, strong) NSString *lf;
@property (nonatomic, assign) double since;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
