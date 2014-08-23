//
//  QuestionViewModel.m
//  Menorii
//
//  Created by Ricardo Pereira on 22/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "QuestionViewModel.h"

@implementation QuestionViewModel

- (instancetype)init
{
    return [self initWithPackage: nil];
}

- (instancetype)initWithPackage:(Package *)package
{
    // Designated
    self = [super init];
    if (self)
    {
        _package = package;
        _currentQuestionIndex = 0;
        _correctAnswers = 0;
        _incorrectAnswers = 0;
    }
    return self;
}

- (BOOL)hasCurrentQuestion
{
    return (_package.questions.count > 0 &&
            _currentQuestionIndex >= 0 && _currentQuestionIndex < _package.questions.count);
}

- (Package*)getCurrentQuestion
{
    if ([self hasCurrentQuestion ])
        return [_package.questions objectAtIndex:_currentQuestionIndex];
    return nil;
}

- (BOOL)nextQuestion
{
    BOOL valid = true;
    _currentQuestionIndex++;
    // Check limit
    if (_currentQuestionIndex >= _package.questions.count) {
        valid = false;
        _currentQuestionIndex = 0;
    }
    // Valid or not
    return valid;
}

- (BOOL)checkAnswer:(NSInteger)index
{
    if (![self hasCurrentQuestion])
        return false;

    if ([self getCurrentQuestion].answer.intValue == index)
    {
        _correctAnswers++;
        return true;
    }
    else
    {
        _incorrectAnswers++;
        return false;
    }
}

@end
