//
//  AFVars.m
//
//  Created by Randhir  on 3/19/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "AFVars.h"


NSString *const kAFVarsFreq = @"freq";
NSString *const kAFVarsLf = @"lf";
NSString *const kAFVarsSince = @"since";


@interface AFVars ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AFVars

@synthesize freq = _freq;
@synthesize lf = _lf;
@synthesize since = _since;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.freq = [[self objectOrNilForKey:kAFVarsFreq fromDictionary:dict] doubleValue];
            self.lf = [self objectOrNilForKey:kAFVarsLf fromDictionary:dict];
            self.since = [[self objectOrNilForKey:kAFVarsSince fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.freq] forKey:kAFVarsFreq];
    [mutableDict setValue:self.lf forKey:kAFVarsLf];
    [mutableDict setValue:[NSNumber numberWithDouble:self.since] forKey:kAFVarsSince];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.freq = [aDecoder decodeDoubleForKey:kAFVarsFreq];
    self.lf = [aDecoder decodeObjectForKey:kAFVarsLf];
    self.since = [aDecoder decodeDoubleForKey:kAFVarsSince];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_freq forKey:kAFVarsFreq];
    [aCoder encodeObject:_lf forKey:kAFVarsLf];
    [aCoder encodeDouble:_since forKey:kAFVarsSince];
}

- (id)copyWithZone:(NSZone *)zone
{
    AFVars *copy = [[AFVars alloc] init];
    
    if (copy) {

        copy.freq = self.freq;
        copy.lf = [self.lf copyWithZone:zone];
        copy.since = self.since;
    }
    
    return copy;
}


@end
