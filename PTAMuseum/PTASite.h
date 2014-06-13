//
//  PTASite.h
//  PTAMuseum
//
//  Created by Yung-Luen Lan on 6/13/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PTAUser;

@interface PTASite : NSObject
+ (PTASite *) sharedSite;

- (void) loginWithUsername: (NSString *)username password: (NSString *)password result: (void (^)(NSError *error, PTAUser *user))resultBlock;


//- (void) fetchMemberBlogWithPage: (NSNumber *)page result: (void (^)(NSError *error, NSArray *blogs, NSNumber *nextPage))resultBlock;

@end
