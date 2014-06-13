//
//  PTASite.m
//  PTAMuseum
//
//  Created by Yung-Luen Lan on 6/13/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

#import "PTASite.h"
#import "PTAUser.h"
#import "PTAArticle.h"
#import "STHTTPRequest.h"

@implementation PTASite
+ (PTASite *) sharedSite
{
    static PTASite *sharedSite = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSite = [PTASite new];
    });
    return sharedSite;
}

- (void) loginWithUsername: (NSString *)username password: (NSString *)password result: (void (^)(NSError *error, PTAUser *user))resultBlock
{
    STHTTPRequest *req = [STHTTPRequest requestWithURLString: @"http://www.perfume-web.jp/pta/index.php"];
    req.POSTDictionary = @{@"id": username, @"pass": password, @"submit_login": @"LOGIN"};
    req.HTTPMethod = @"POST";
    req.completionBlock = ^(NSDictionary *header, NSString *body) {
        NSLog(@"h: %@", header);
        //        NSLog(@"b: %@", body);
        
        PTAUser *user = [PTAUser userFromHTML: body];
        NSLog(@"%@", user);
        
        //        NSArray *articles = [PTAArticle articlesFromHTML: body];
        resultBlock(nil, user);
    };
    req.errorBlock = ^(NSError *error) {
        
    };
    [req startAsynchronous];
}

@end
