//
//  Package.h
//  Menorii
//
//  Created by Ricardo Pereira on 12/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Mantle.h"

@interface Question : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic, readonly) NSString *question;
@property (strong, nonatomic, readonly) NSNumber *answer;

@property (strong, nonatomic) NSArray *answers;

@end