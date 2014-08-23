//
//  QuestionViewController.h
//  Menorii
//
//  Created by Ricardo Pereira on 13/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QuestionViewModel.h"

@interface QuestionViewController : UIViewController

@property (nonatomic, strong) QuestionViewModel *model;

- (void)viewPrepare:(Package*)package;

@end
