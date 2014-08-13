//
//  QuestionViewController.m
//  Menorii
//
//  Created by Ricardo Pereira on 13/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "QuestionViewController.h"

#import "UIAlertView+Blocks.h"

#import "Question.h"

@interface QuestionViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buttonClose;

@property (weak, nonatomic) IBOutlet UILabel *labelPackageName;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion;

@property (weak, nonatomic) IBOutlet UILabel *labelAnswer1;
@property (weak, nonatomic) IBOutlet UILabel *labelAnswer2;
@property (weak, nonatomic) IBOutlet UILabel *labelAnswer3;
@property (weak, nonatomic) IBOutlet UILabel *labelAnswer4;

@property (weak, nonatomic) IBOutlet UIButton *buttonAnswer1;
@property (weak, nonatomic) IBOutlet UIButton *buttonAnswer2;
@property (weak, nonatomic) IBOutlet UIButton *buttonAnswer3;
@property (weak, nonatomic) IBOutlet UIButton *buttonAnswer4;

//Data
@property (nonatomic) int currentQuestionIndex;
@property (strong, nonatomic) Question *currentQuestion;

@end

@implementation QuestionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _currentQuestionIndex = 0;

    self.buttonAnswer1.tag = 0;
    self.buttonAnswer2.tag = 1;
    self.buttonAnswer3.tag = 2;
    self.buttonAnswer4.tag = 3;

    self.labelPackageName.text = _package.name;

    [self loadCurrentQuestion];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self loadCurrentQuestion];
}

- (IBAction)buttonCloseDidPress:(id)sender {
    // Close
    [self performSegueWithIdentifier:@"questionToMain" sender:self];
}

- (IBAction)buttonAnswerDidPress:(id)sender {
    // Answered
    UIButton *button = sender;
    NSString *message;

    if (button.tag == [_currentQuestion.answer integerValue]) {
        message = @"Resposta certa.";
    } else {
        message = @"Resposta errada.";
    }

    [UIAlertView showWithTitle:@"Menorii"
                       message:message
             cancelButtonTitle:@"Sair"
             otherButtonTitles:@[@"Próximo"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                              // Close
                              [self performSegueWithIdentifier:@"questionToMain" sender:self];
                          } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Próximo"]) {
                              [self nextQuestion];
                          }
                      }];
}

- (void)loadCurrentQuestion
{
    if (_currentQuestionIndex >= _package.questions.count)
        return;
    // Data
    self.currentQuestion = [_package.questions objectAtIndex:_currentQuestionIndex];
    self.labelQuestion.text = _currentQuestion.question;

    if (_currentQuestion.answers && _currentQuestion.answers.count == 4) {
        self.labelAnswer1.text = [_currentQuestion.answers objectAtIndex:0];
        self.labelAnswer2.text = [_currentQuestion.answers objectAtIndex:1];
        self.labelAnswer3.text = [_currentQuestion.answers objectAtIndex:2];
        self.labelAnswer4.text = [_currentQuestion.answers objectAtIndex:3];
    }
}

- (void)nextQuestion
{
    _currentQuestionIndex++;
    // Check limit
    if (_currentQuestionIndex >= _package.questions.count) {
        // The End
        [self theEnd];
    }

    [self refreshView];
}

- (void)refreshView
{
    [self viewDidAppear:true];
}

- (void)theEnd
{
    [UIAlertView showWithTitle:@"Menorii"
                       message:@"Fim do jogo"
             cancelButtonTitle:@"Ok"
             otherButtonTitles:nil
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                              // Close
                              [self performSegueWithIdentifier:@"questionToMain" sender:self];
                          }
                      }];
}

@end
