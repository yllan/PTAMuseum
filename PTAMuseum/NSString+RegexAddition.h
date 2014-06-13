//
//  NSString+RegexAddition.h
//  PTAMuseum
//
//  Created by Yung-Luen Lan on 6/13/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegexAddition)
- (NSString *) firstSubstringMatchesPattern: (NSString *)pattern;
@end
