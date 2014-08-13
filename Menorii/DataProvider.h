//
//  DataProvider.h
//  Menorii
//
//  Created by Ricardo Pereira on 12/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Package.h"

@interface DataProvider : NSObject

+ (void)freePackagesWithCompletionBlock:(void(^)(NSArray *packages, NSError *error))completionBlock;
+ (void)questionsWithCompletionBlock:(Package*)package completionBlock:(void (^)(NSArray *questions, NSError *error))completionBlock;

@end
