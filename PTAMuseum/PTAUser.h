//
//  PTAUser.h
//  PTAMuseum
//
//  Created by Yung-Luen Lan on 6/13/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTAUser : NSObject
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *expireDate;

+ (PTAUser *) userFromHTML: (NSString *)htmlString;

@end
