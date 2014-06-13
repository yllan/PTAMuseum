//
//  PTAImporter.m
//  PTAMuseum
//
//  Created by Yung-Luen Lan on 6/13/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

#import "PTAImporter.h"
#import "PTASite.h"
#import "PTAArticle.h"
#import "PTAArticleEntity.h"

@implementation PTAImporter

- (id) initWithContext: (NSManagedObjectContext *)context site: (PTASite *)site
{
    self = [super init];
    if (self) {
        self.context = context;
        self.site = site;
    }
    return self;
}

- (void) importBlogAtPage: (NSNumber *)page
{
    void (^handler)(NSError *, NSArray *, NSNumber *) = ^(NSError *error, NSArray *blogs, NSNumber *nextPage) {
        NSLog(@"%@", page);
        for (PTAArticle *blog in blogs) {
            NSLog(@"%@", blog);
        }
        if (nextPage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self importBlogAtPage: nextPage];
            });
        }
    };
    [self.site fetchMemberBlogWithPage: page result: handler];
}

- (void) importBlogArchiveAtPage: (NSNumber *)page
{
    void (^handler)(NSError *, NSArray *, NSNumber *) = ^(NSError *error, NSArray *blogs, NSNumber *nextPage) {
        NSLog(@"%@", page);
        for (PTAArticle *blog in blogs) {
            NSLog(@"%@", blog);
        }
        if (nextPage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self importBlogArchiveAtPage: nextPage];
            });
        }
    };
    [self.site fetchMemberBlogArchiveWithPage: page result: handler];
}


- (void) importWithUsername: (NSString *)name password: (NSString *)password
{
    [self.site loginWithUsername: name password: password result: ^(NSError *error, PTAUser *user) {
        if (error) {
            return;
        }
        
        [self importBlogArchiveAtPage: @1];
    }];
}

@end
