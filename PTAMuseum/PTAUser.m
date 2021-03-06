//
//  PTAUser.m
//  PTAMuseum
//
//  Created by Yung-Luen Lan on 6/13/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

#import "PTAUser.h"
#import "OCGumbo.h"
#import "OCGumbo+Query.h"
#import "NSString+RegexAddition.h"

@implementation PTAUser
+ (PTAUser *) userFromHTML: (NSString *)htmlString
{
    OCGumboDocument *document = [[OCGumboDocument alloc] initWithHTMLString: htmlString];
    NSString *nameInnerText = document.Query(@"#user-id").first().text();
    NSString *dateInnerText = document.Query(@"#pta-days").first().text();
    
    // Extract the actual data from html string.
    NSString *name = [nameInnerText firstSubstringMatchesPattern: @"[A-Z]\\d+"];
    NSString *date = [dateInnerText firstSubstringMatchesPattern: @"\\d+\\.\\d+\\.\\d+"];
    
    if (!date || !name) return nil;
    
    PTAUser *user = [PTAUser new];
    user.userID = name;
    user.expireDate = date;
    return user;
}

- (NSString *) description
{
    return [NSString stringWithFormat: @"PTAUser(%@, %@)", self.userID, self.expireDate];
}

@end
