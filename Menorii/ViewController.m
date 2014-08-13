//
//  ViewController.m
//  Menorii
//
//  Created by Ricardo Pereira on 12/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "ViewController.h"

#import "DataProvider.h"
#import "Package.h"
#import "Question.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Teste
    [DataProvider freePackagesWithCompletionBlock:^(NSArray *packages, NSError *error) {
        // Enumerate with blocks - iterate all the questions
        [packages enumerateObjectsUsingBlock:^(Package *item, NSUInteger idx, BOOL *stop) {
            NSLog(@"%@", item.name);

            [DataProvider questionsWithCompletionBlock:item completionBlock:^(NSArray *questions, NSError *error) {
                // Iterate all the questions
                for (Question *item in questions) {
                    NSLog(@"%@",item.question);
                }
            }];
        }];
    }];
}

@end
