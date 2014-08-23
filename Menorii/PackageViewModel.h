//
//  PackageViewModel.h
//  Menorii
//
//  Created by Ricardo Pereira on 22/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PackageManager.h"
#import "Package.h"

@interface PackageViewModel : NSObject

@property (nonatomic, strong) PackageManager *packageManager;
@property (nonatomic, strong) Package *package;

- (instancetype)initWithPackage:(Package *)package;

- (void)loadQuestions:(void (^)())finallyBlock;

@end
