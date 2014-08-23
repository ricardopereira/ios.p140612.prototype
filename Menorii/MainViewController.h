//
//  ViewController.h
//  Menorii
//
//  Created by Ricardo Pereira on 12/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PackagesViewModel.h"

@interface MainViewController : UIViewController

@property (nonatomic, strong) PackagesViewModel *model;

@end
