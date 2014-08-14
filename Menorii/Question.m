//
//  Package.m
//  Menorii
//
//  Created by Ricardo Pereira on 12/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "Question.h"

#import "Answer.h"

@implementation Question

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"question": @"question",
             @"answer": @"answer",
             @"answers": @"answers"
             };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;

    // Init variables

    return self;
}

+ (NSValueTransformer *)answersJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:Answer.class];
}

@end