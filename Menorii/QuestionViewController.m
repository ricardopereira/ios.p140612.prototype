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

@end

@implementation QuestionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.buttonAnswer1.tag = 1;
    self.buttonAnswer2.tag = 2;
    self.buttonAnswer3.tag = 3;
    self.buttonAnswer4.tag = 4;

    self.labelPackageName.text = self.model.package.name;

    [self loadCurrentQuestion];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self loadCurrentQuestion];
}

- (void)viewPrepare:(Package*)package
{
    assert(package);
    self.model = [[QuestionViewModel alloc] initWithPackage:package];
}

- (IBAction)buttonCloseDidPress:(id)sender
{
    // Close
    [self performSegueWithIdentifier:@"questionToMain" sender:self];
}

- (IBAction)buttonAnswerDidPress:(id)sender
{
    // Answered
    UIButton *button = sender;
    NSString *message;

    BOOL correct = [self.model checkAnswer:button.tag];

    // Correct or incorrect answer
    if (correct)
        message = @"Resposta certa.";
    else
        message = @"Resposta errada.";

    [UIAlertView showWithTitle:@"Menorii"
                       message:message
             cancelButtonTitle:@"Sair"
             otherButtonTitles:@[@"Próximo"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                              // Close
                              [self performSegueWithIdentifier:@"questionToMain" sender:self];
                          } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Próximo"]) {
                              // Next question
                              [self nextQuestion];
                          }
                      }];
}

- (void)loadCurrentQuestion
{
    if (![self.model hasCurrentQuestion])
        return;

    // Data
    Question *question = [self.model getCurrentQuestion];
    self.labelQuestion.text = question.question;

    if (question.answers && question.answers.count == 4) {
        Answer *answer = [question.answers objectAtIndex:0];
        self.labelAnswer1.text = answer.text;
        answer = [question.answers objectAtIndex:1];
        self.labelAnswer2.text = answer.text;
        answer = [question.answers objectAtIndex:2];
        self.labelAnswer3.text = answer.text;
        answer = [question.answers objectAtIndex:3];
        self.labelAnswer4.text = answer.text;
    }
}

- (void)nextQuestion
{
    if (![self.model nextQuestion])
        // Reach the end of the game
        [self theEnd];
    else
        // Refresh the next question
        [self refreshView];
}

- (void)refreshView
{
    [self viewDidAppear:true];
}

- (void)theEnd
{
    NSString *message = [NSString stringWithFormat:@"Fim do jogo.\nCorrectas: %ld\nIncorrectas: %ld",
                         (long)self.model.correctAnswers, (long)self.model.incorrectAnswers];

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
