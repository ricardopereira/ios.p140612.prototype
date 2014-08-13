//
//  PackageViewController.m
//  Menorii
//
//  Created by Ricardo Pereira on 13/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "PackageViewController.h"

#import "DataProvider.h"
#import "QuestionViewController.h"

@interface PackageViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelPackageName;

@end

@implementation PackageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.labelPackageName.text = _package.name;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"packageToQuestion"]) {
        QuestionViewController *view = [segue destinationViewController];
        view.package = _package;
    }
}

- (IBAction)buttonBackDidPress:(id)sender {
    [self performSegueWithIdentifier:@"packageToMain" sender:self];
}

- (IBAction)buttonStartDidPress:(id)sender {
    // Start questions after receiving the data
    [DataProvider questionsWithCompletionBlock:_package completionBlock:^(NSArray *questions, NSError *error) {
        if (questions.count <= 0)
            return;
        // Get all the questions
        self.package.questions = questions;
        [self performSegueWithIdentifier:@"packageToQuestion" sender:self];
    }];
}

@end
