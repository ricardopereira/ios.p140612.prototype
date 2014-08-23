//
//  MainViewModel.m
//  Menorii
//
//  Created by Ricardo Pereira on 22/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "PackagesViewModel.h"

@implementation PackagesViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _packageManager = [[PackageManager alloc] init];
        _currentPackageIndex = -1;
    }
    return self;
}

- (void)loadPackages
{
    [_packageManager loadPackages];
    // First package
    _currentPackageIndex = 0;
}

- (BOOL)hasCurrentPackage
{
    return (_packageManager.packages.count > 0 &&
            _currentPackageIndex >= 0 && _currentPackageIndex < _packageManager.packages.count);
}

- (Package*)getCurrentPackage
{
    if ([self hasCurrentPackage ])
        return [_packageManager.packages objectAtIndex:_currentPackageIndex];
    return nil;
}

- (void)nextPackage
{
    _currentPackageIndex++;
    // Check limit
    if (_currentPackageIndex >= _packageManager.packages.count) {
        _currentPackageIndex = -1;
    }
}

- (void)prevPackage
{
    _currentPackageIndex--;
    // Check limit
    if (_currentPackageIndex < 0) {
        _currentPackageIndex = -1;
    }
}

@end
