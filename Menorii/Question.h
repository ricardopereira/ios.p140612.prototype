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

@property (nonatomic, strong, readonly) NSString *question;
@property (nonatomic, strong, readonly) NSNumber *answer;

@property (nonatomic, strong) NSMutableArray *answers;

@end