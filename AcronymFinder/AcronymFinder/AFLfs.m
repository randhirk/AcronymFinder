//
//  AFLfs.m
//
//  Created by Randhir  on 3/19/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "AFLfs.h"
#import "AFVars.h"


NSString *const kAFLfsFreq = @"freq";
NSString *const kAFLfsLf = @"lf";
NSString *const kAFLfsSince = @"since";
NSString *const kAFLfsVars = @"vars";


@interface AFLfs ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AFLfs

@synthesize freq = _freq;
@synthesize lf = _lf;
@synthesize since = _since;
@synthesize vars = _vars;


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
            self.freq = [[self objectOrNilForKey:kAFLfsFreq fromDictionary:dict] doubleValue];
            self.lf = [self objectOrNilForKey:kAFLfsLf fromDictionary:dict];
            self.since = [[self objectOrNilForKey:kAFLfsSince fromDictionary:dict] doubleValue];
    NSObject *receivedAFVars = [dict objectForKey:kAFLfsVars];
    NSMutableArray *parsedAFVars = [NSMutableArray array];
    if ([receivedAFVars isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAFVars) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAFVars addObject:[AFVars modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAFVars isKindOfClass:[NSDictionary class]]) {
       [parsedAFVars addObject:[AFVars modelObjectWithDictionary:(NSDictionary *)receivedAFVars]];
    }

    self.vars = [NSArray arrayWithArray:parsedAFVars];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.freq] forKey:kAFLfsFreq];
    [mutableDict setValue:self.lf forKey:kAFLfsLf];
    [mutableDict setValue:[NSNumber numberWithDouble:self.since] forKey:kAFLfsSince];
    NSMutableArray *tempArrayForVars = [NSMutableArray array];
    for (NSObject *subArrayObject in self.vars) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForVars addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForVars addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForVars] forKey:kAFLfsVars];

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

    self.freq = [aDecoder decodeDoubleForKey:kAFLfsFreq];
    self.lf = [aDecoder decodeObjectForKey:kAFLfsLf];
    self.since = [aDecoder decodeDoubleForKey:kAFLfsSince];
    self.vars = [aDecoder decodeObjectForKey:kAFLfsVars];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_freq forKey:kAFLfsFreq];
    [aCoder encodeObject:_lf forKey:kAFLfsLf];
    [aCoder encodeDouble:_since forKey:kAFLfsSince];
    [aCoder encodeObject:_vars forKey:kAFLfsVars];
}

- (id)copyWithZone:(NSZone *)zone
{
    AFLfs *copy = [[AFLfs alloc] init];
    
    if (copy) {

        copy.freq = self.freq;
        copy.lf = [self.lf copyWithZone:zone];
        copy.since = self.since;
        copy.vars = [self.vars copyWithZone:zone];
    }
    
    return copy;
}


@end
