//
//  ViewController.m
//  Menorii
//
//  Created by Ricardo Pereira on 12/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "ViewController.h"

#import "PromiseKit.h"
#import "Mantle.h"

#import "Question.h"

static NSString *const packageUrl = @"https://raw.githubusercontent.com/ricardopereira/ios.p140612.prototype/master/Data/pack01.json";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NSURLConnection GET:packageUrl].then(^(NSDictionary *json) {
        // Paremeters vary with the NSURLConnection result: NSDictionary or NSData
        NSArray *questions = json[@"questions"];

        NSLog(@"Received %d questions on package %@",[questions count],json[@"name"]);

        return questions;
    }).then(^(NSArray *questions) {
        // Serialize JSON to objects
        NSArray *questionObjects = [MTLJSONAdapter modelsOfClass:Question.class fromJSONArray:questions error:nil];

        // Iterate all the questions
        for (Question *item in questionObjects) {
            NSLog(@"%@",item.question);
        }

        return [MTLJSONAdapter modelsOfClass:Question.class fromJSONArray:questions error:nil];
    }).catch(^(NSError *error) {
        // Show an error perhaps
        // Return the error to break the chain
        return error;
    });
}

@end
