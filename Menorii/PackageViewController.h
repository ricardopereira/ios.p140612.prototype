//
//  PackageViewController.h
//  Menorii
//
//  Created by Ricardo Pereira on 13/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PackageViewModel.h"

@interface PackageViewController : UIViewController

@property (nonatomic, strong) PackageViewModel *model;

- (void)viewPrepare:(Package*)package;

@end
