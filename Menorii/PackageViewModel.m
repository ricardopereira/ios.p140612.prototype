//
//  PackageViewModel.m
//  Menorii
//
//  Created by Ricardo Pereira on 22/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "PackageViewModel.h"

@implementation PackageViewModel

- (instancetype)init
{
    return [self initWithPackage: nil];
}

- (instancetype)initWithPackage:(Package *)package
{
    // Designated
    self = [super init];
    if (self) {
        _packageManager = [[PackageManager alloc] init];
        // ?!
        _package = package;
    }
    return self;
}

- (void)loadQuestions:(void (^)())finallyBlock
{
    [self.packageManager loadQuestions:_package withFinallyBlock:^{
        finallyBlock();
    }];
}

@end
