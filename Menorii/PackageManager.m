//
//  PackageManager.m
//  Menorii
//
//  Created by Ricardo Pereira on 22/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "PackageManager.h"

@implementation PackageManager

- (void)loadPackages
{
    _currentState = PackagesStateLoading;
    // Async
    [DataReceiver freePackagesWithCompletionBlock:^(NSArray *packages, NSError *error)
    {
        self.packages = packages;

        if (error)
        {
            switch (error.code)
            {
                case -1009:
                    _currentState = PackagesStateOffline;
                    break;
                default:
                    _currentState = PackagesStateError;
                    break;
            }
        }
        else
            _currentState = PackagesStateLoaded;
    }];
}

- (void)loadQuestions:(Package*)package withFinallyBlock:(void (^)())finallyBlock
{
    // Start questions after receiving the data
    [DataReceiver questionsWithCompletionBlock:package completionBlock:^(NSArray *questions, NSError *error) {
        if (questions.count <= 0)
            return;
        // Get all the questions
        package.questions = questions;
        // Finally
        finallyBlock();
    }];
}

@end