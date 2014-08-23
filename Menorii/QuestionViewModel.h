//
//  QuestionViewModel.h
//  Menorii
//
//  Created by Ricardo Pereira on 22/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PackageManager.h"
#import "Package.h"

@interface QuestionViewModel : NSObject

@property (nonatomic, strong) Package *package;
@property (nonatomic) NSInteger currentQuestionIndex;

//Data
@property (nonatomic) NSInteger correctAnswers;
@property (nonatomic) NSInteger incorrectAnswers;

- (instancetype)initWithPackage:(Package *)package;

- (BOOL)hasCurrentQuestion;
- (Question *)getCurrentQuestion;
- (BOOL)nextQuestion;
- (BOOL)checkAnswer:(NSInteger)index;

@end
