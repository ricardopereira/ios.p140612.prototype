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

@end