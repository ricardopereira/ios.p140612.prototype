//
//  Answer.h
//  Menorii
//
//  Created by Ricardo Pereira on 13/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Mantle.h"

@interface Answer : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong, readonly) NSString *text;

@end
