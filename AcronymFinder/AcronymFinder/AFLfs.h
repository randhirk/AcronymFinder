//
//  AFLfs.h
//
//  Created by Randhir  on 3/19/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AFLfs : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double freq;
@property (nonatomic, strong) NSString *lf;
@property (nonatomic, assign) double since;
@property (nonatomic, strong) NSArray *vars;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
