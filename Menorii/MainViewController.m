//
//  ViewController.m
//  Menorii
//
//  Created by Ricardo Pereira on 12/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "MainViewController.h"

#import "DataProvider.h"
#import "Package.h"
#import "Question.h"

#import "PackageViewController.h"

typedef enum : NSUInteger {
    PackagesStateNone,
    PackagesStateLoading,
    PackagesStateLoaded
} PackagesState;

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewDetail;
@property (weak, nonatomic) IBOutlet UILabel *labelPackageName;
@property (weak, nonatomic) IBOutlet UIButton *buttonPackage;
@property (weak, nonatomic) IBOutlet UILabel *labelWelcomeDetail;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesturePackage;

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehavior;
@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;
@property (strong, nonatomic) UISnapBehavior *snapBehavior;

//Data
@property (strong, nonatomic) NSArray *packages;
@property (nonatomic) PackagesState loadingPackages;
@property (nonatomic) int currentPackageIndex;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self start];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (_loadingPackages == PackagesStateLoaded) {
        [self showPackage];
    }
    else {
        [self showWelcome];
    }

    self.viewDetail.alpha = 1;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"mainToPackage"]) {
        if (_packages.count <= 0 || _currentPackageIndex >= _packages.count)
            return;
        PackageViewController *viewPackage = [segue destinationViewController];
        viewPackage.package = [_packages objectAtIndex:_currentPackageIndex];
    }
}

- (IBAction)buttonPackageDidPress:(id)sender {

}

- (IBAction)handleGesturePackage:(id)sender {
    UIView *currentView = self.viewDetail;

    CGPoint location = [sender locationInView:self.view];
    CGPoint boxLocation = [sender locationInView:currentView];

    // Teste
    //self.viewDetail.center = location;

    if ([sender state] == UIGestureRecognizerStateBegan) {
        // Start of the gesture.
        // You could remove any layout constraints that interfere
        // with changing of the position of the content view.

        [self.animator removeBehavior:self.snapBehavior];

        UIOffset centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(currentView.bounds), boxLocation.y - CGRectGetMidY(currentView.bounds));

        self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:currentView offsetFromCenter:centerOffset attachedToAnchor:location];

        self.attachmentBehavior.frequency = 0;

        [self.animator addBehavior:self.attachmentBehavior];
    }
    else if ([sender state] == UIGestureRecognizerStateChanged) {
        // Current
        self.attachmentBehavior.anchorPoint = location;
    }
    else if ([sender state] == UIGestureRecognizerStateEnded) {
        // Dragging has ended.
        // You could add layout constraints back to the content view here.

        [self.animator removeBehavior:self.attachmentBehavior];

        self.snapBehavior = [[UISnapBehavior alloc] initWithItem:currentView snapToPoint:self.view.center];

        [self.animator addBehavior:self.snapBehavior];

        // Falling?
        CGPoint translation = [sender translationInView:self.view];
        if (translation.y > 100) {
            // Fall down
            [self.animator removeAllBehaviors];

            self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[currentView]];
            self.gravityBehavior.gravityDirection = CGVectorMake(0, 10);

            [self.animator addBehavior:self.gravityBehavior];

            [self nextPackage];
        }
    }
}

- (void)start
{
    [self loadPackages];

    // Init
    self.viewDetail.alpha = 0;
    _currentPackageIndex = 0;
    // UI Dynamics
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)loadPackages
{
    _loadingPackages = PackagesStateLoading;
    // Teste
    [DataProvider freePackagesWithCompletionBlock:^(NSArray *packages, NSError *error) {
        self.packages = packages;
        _loadingPackages = PackagesStateLoaded;

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

- (void)showWelcome
{
    self.labelWelcomeDetail.hidden = false;
    self.buttonPackage.hidden = true;

    // Data
    self.labelPackageName.text = @"Bem-vindo";

    // Animation
    [self animateDetail];
}

- (void)showPackage
{
    self.labelWelcomeDetail.hidden = true;
    self.buttonPackage.hidden = false;

    // Data
    if (_packages.count > 0) {
        Package *item = [_packages objectAtIndex:_currentPackageIndex];
        self.labelPackageName.text = item.name;
    }

    // Animation
    [self animateDetail];
}

- (void)animateDetail
{
    CGAffineTransform scale = CGAffineTransformMakeScale(0.5, 0.5);
    CGAffineTransform translate = CGAffineTransformMakeTranslation(0, -200);

    self.viewDetail.transform = CGAffineTransformConcat(scale, translate);

    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:0 animations:^{
        // Animate
        CGAffineTransform scale = CGAffineTransformMakeScale(1, 1);
        CGAffineTransform translate = CGAffineTransformMakeTranslation(0, 0);

        self.viewDetail.transform = CGAffineTransformConcat(scale, translate);
    }completion:^(BOOL finished) {
        // Finally
        
    }];
}

- (void)nextPackage
{
    _currentPackageIndex++;
    // Check limit
    if (_currentPackageIndex >= _packages.count) {
        _currentPackageIndex = 0;
    }

    [self.animator removeAllBehaviors];

    // ?!
    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:self.viewDetail snapToPoint:self.view.center];

    self.attachmentBehavior.anchorPoint = self.view.center;

    [self refreshView];
}

- (void)refreshView
{
    self.viewDetail.center = self.view.center;
    [self viewDidAppear:true];
}

@end
