//
//  PackageViewController.m
//  Menorii
//
//  Created by Ricardo Pereira on 13/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "PackageViewController.h"

@implementation PackageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)buttonBackDidPress:(id)sender {
    [self performSegueWithIdentifier:@"packageToMain" sender:self];
}

@end
