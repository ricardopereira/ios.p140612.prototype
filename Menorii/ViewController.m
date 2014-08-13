//
//  ViewController.m
//  Menorii
//
//  Created by Ricardo Pereira on 12/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewDetail;
@property (weak, nonatomic) IBOutlet UILabel *labelPackageName;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesturePackage;

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehavior;
@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;
@property (strong, nonatomic) UISnapBehavior *snapBehavior;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Init
    self.viewDetail.alpha = 0;

    // UI Dynamics
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    //[self performSegueWithIdentifier:@"mainToPackage" sender:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self showPackage];

    // Data
    self.labelPackageName.text = @"Teste";

    self.viewDetail.alpha = 1;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"mainToPackage"]) {

    }
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

- (void)showPackage
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
    //number++;
    // Test porpuse
    //if number > 3 {
    //    number = 0
    //}

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
