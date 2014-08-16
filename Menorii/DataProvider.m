//
//  DataProvider.m
//  Menorii
//
//  Created by Ricardo Pereira on 12/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "DataProvider.h"

#import "PromiseKit.h"
#import "Mantle.h"

#import "Package.h"
#import "Question.h"

static NSString *const packagesUrl = @"https://cld.pt/dl/download/a6b0c5b8-9aa7-44eb-a38a-90aa13dcb6f8/packages.json";

@implementation DataProvider

+ (Promise *)promiseFreePackagesAccess
{
    Promise *results = [NSURLConnection GET:packagesUrl].then(^(NSDictionary *json) {
        // Paremeters vary with the NSURLConnection result: NSDictionary or NSData
        NSArray *freePackages = json[@"free"];

        NSLog(@"Received %lu free packages",(unsigned long)[freePackages count]);

        return freePackages;
    }).then(^(NSArray *packages) {
        // Serialize JSON to objects
        NSArray *packagesObjects = [MTLJSONAdapter modelsOfClass:Package.class fromJSONArray:packages error:nil];
        // Return array with Package items
        return packagesObjects;
    }).catch(^(NSError *error) {
        // Return the error to break the chain
        return error;
    });

    return results;
}

#pragma mark - Moods

+ (void)freePackagesWithCompletionBlock:(void (^)(NSArray *packages, NSError *error))completionBlock
{
    [DataProvider promiseFreePackagesAccess].then(^(NSArray *packages){
        completionBlock(packages,nil);
    }).catch(^(NSError *error){
        completionBlock(nil,error);
    });
}

+ (void)questionsWithCompletionBlock:(Package*)package completionBlock:(void (^)(NSArray *questions, NSError *error))completionBlock
{
    [NSURLConnection GET:package.url].then(^(NSDictionary *json) {
        // Paremeters vary with the NSURLConnection result: NSDictionary or NSData
        NSArray *questions = json[@"questions"];

        NSLog(@"Received %lu questions on package %@",(unsigned long)[questions count],json[@"name"]);

        return questions;
    }).then(^(NSArray *questions) {
        // Serialize JSON to objects
        NSArray *questionsObjects = [MTLJSONAdapter modelsOfClass:Question.class fromJSONArray:questions error:nil];

        completionBlock(questionsObjects,nil);

        // Return array with Package items
        return questionsObjects;
    }).catch(^(NSError *error) {
        // Return the error to break the chain
        return error;
    });
}

@end
