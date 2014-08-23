//
//  MainViewModel.h
//  Menorii
//
//  Created by Ricardo Pereira on 22/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PackageManager.h"

@interface PackagesViewModel : NSObject

@property (nonatomic, strong) PackageManager *packageManager;
@property (nonatomic) NSInteger currentPackageIndex;

- (void)loadPackages;
- (BOOL)hasCurrentPackage;
- (Package*)getCurrentPackage;
- (void)nextPackage;
- (void)prevPackage;

@end
