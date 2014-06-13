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
#import "OCGumbo.h"
#import "OCGumbo+Query.h"

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
        //        NSArray *articles = [PTAArticle articlesFromHTML: body];
        resultBlock(nil, user);
    };
    req.errorBlock = ^(NSError *error) {
        
    };
    [req startAsynchronous];
}

- (void) fetchMemberBlogWithPage: (NSNumber *)page result: (void (^)(NSError *error, NSArray *blogs, NSNumber *nextPage))resultBlock
{
    STHTTPRequest *req = [STHTTPRequest requestWithURLString: [NSString stringWithFormat: @"http://www.perfume-web.jp/pta/blog/?page=%@", page ?: @1]];
    req.completionBlock = ^(NSDictionary *header, NSString *body) {
        NSArray *blogs = [PTAArticle articlesFromHTML: body];
        
        OCGumboDocument *document = [[OCGumboDocument alloc] initWithHTMLString: body];

        NSString *nextURL = document.Query(@"#pagination-next").find(@"a").first().attr(@"href");

        NSString *nextPageString = [[nextURL componentsSeparatedByString: @"="] lastObject];
        NSNumber *nextPage = (nextPageString.length > 0) ? @(nextPageString.intValue) : nil;
        resultBlock(nil, blogs, nextPage);
    };
    [req startAsynchronous];
}

@end
