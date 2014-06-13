//
//  NSString+RegexAddition.m
//  PTAMuseum
//
//  Created by Yung-Luen Lan on 6/13/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

#import "NSString+RegexAddition.h"

@implementation NSString (RegexAddition)
- (NSString *) firstSubstringMatchesPattern: (NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: pattern options: 0 error: &error];
    if (regex == nil) return nil;
    
    NSTextCheckingResult *result = [regex firstMatchInString: self options: 0 range: NSMakeRange(0, self.length)];
    if (!result) return nil;
    return [self substringWithRange: result.range];
}
@end
