//
//  Package.m
//  Menorii
//
//  Created by Ricardo Pereira on 12/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "Question.h"

@implementation Question

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"question": @"question",
             @"answer": @"answer"
             };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;

    _answers = [[NSMutableArray alloc] init];

    return self;
}

@end