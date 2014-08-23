//
//  PackageManager.h
//  Menorii
//
//  Created by Ricardo Pereira on 22/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataReceiver.h"
#import "Package.h"

typedef enum : NSUInteger {
    PackagesStateNone,
    PackagesStateLoading,
    PackagesStateLoaded,
    PackagesStateOffline,
    PackagesStateError
} PackagesState;

@interface PackageManager : NSObject

@property (strong, nonatomic) NSArray *packages;
@property (nonatomic) PackagesState currentState;

- (void)loadPackages;
- (void)loadQuestions:(Package*)package withFinallyBlock:(void (^)())finallyBlock;

@end
