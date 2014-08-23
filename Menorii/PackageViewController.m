//
//  PackageViewController.m
//  Menorii
//
//  Created by Ricardo Pereira on 13/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "PackageViewController.h"

#import "DataReceiver.h"
#import "QuestionViewController.h"

@interface PackageViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelPackageName;

@end

@implementation PackageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.labelPackageName.text = self.model.package.name;
}

- (void)viewPrepare:(Package*)package
{
    assert(package);
    self.model = [[PackageViewModel alloc] initWithPackage:package];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"packageToQuestion"])
    {
        QuestionViewController *view = [segue destinationViewController];
        //?!
        [view viewPrepare:self.model.package];
    }
}

- (IBAction)buttonBackDidPress:(id)sender
{
    [self performSegueWithIdentifier:@"packageToMain" sender:self];
}

- (IBAction)buttonStartDidPress:(id)sender
{
    [self.model loadQuestions:^{
        // Finally
        [self performSegueWithIdentifier:@"packageToQuestion" sender:self];
    }];
}

@end
