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
#import "Answer.h"

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
@property (nonatomic) int correctAnswers;
@property (nonatomic) int incorrectAnswers;
@property (strong, nonatomic) Question *currentQuestion;

@end

@implementation QuestionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _currentQuestionIndex = 0;
    _correctAnswers = 0;
    _incorrectAnswers = 0;

    self.buttonAnswer1.tag = 1;
    self.buttonAnswer2.tag = 2;
    self.buttonAnswer3.tag = 3;
    self.buttonAnswer4.tag = 4;

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

    // Correct or incorrect answer
    if (button.tag == [_currentQuestion.answer integerValue]) {
        message = @"Resposta certa.";
        _correctAnswers++;
    } else {
        message = @"Resposta errada.";
        _incorrectAnswers++;
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
        Answer *answer = [_currentQuestion.answers objectAtIndex:0];
        self.labelAnswer1.text = answer.text;
        answer = [_currentQuestion.answers objectAtIndex:1];
        self.labelAnswer2.text = answer.text;
        answer = [_currentQuestion.answers objectAtIndex:2];
        self.labelAnswer3.text = answer.text;
        answer = [_currentQuestion.answers objectAtIndex:3];
        self.labelAnswer4.text = answer.text;
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
    NSString *message = [NSString stringWithFormat:@"Fim do jogo.\nCorrectas: %d\nIncorrectas: %d", _correctAnswers, _incorrectAnswers];

    [UIAlertView showWithTitle:@"Menorii"
                       message:message
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
