//
//  PeopleModel.m
//
//  Created by   on 2021/1/6
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "PeopleModel.h"


NSString *const kPeopleModelName = @"name";
NSString *const kPeopleModelAddress = @"address";
NSString *const kPeopleModelAge = @"age";


@interface PeopleModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PeopleModel

@synthesize name = _name;
@synthesize address = _address;
@synthesize age = _age;


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
            self.name = [self objectOrNilForKey:kPeopleModelName fromDictionary:dict];
            self.address = [self objectOrNilForKey:kPeopleModelAddress fromDictionary:dict];
            self.age = [self objectOrNilForKey:kPeopleModelAge fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kPeopleModelName];
    [mutableDict setValue:self.address forKey:kPeopleModelAddress];
    [mutableDict setValue:self.age forKey:kPeopleModelAge];

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

    self.name = [aDecoder decodeObjectForKey:kPeopleModelName];
    self.address = [aDecoder decodeObjectForKey:kPeopleModelAddress];
    self.age = [aDecoder decodeObjectForKey:kPeopleModelAge];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kPeopleModelName];
    [aCoder encodeObject:_address forKey:kPeopleModelAddress];
    [aCoder encodeObject:_age forKey:kPeopleModelAge];
}

- (id)copyWithZone:(NSZone *)zone
{
    PeopleModel *copy = [[PeopleModel alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.age = [self.age copyWithZone:zone];
    }
    
    return copy;
}


@end
