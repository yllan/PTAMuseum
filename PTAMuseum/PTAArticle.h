//
//  PTAArticle.h
//  PTAMuseum
//
//  Created by Yung-Luen Lan on 6/13/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PTAArticle : NSObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * innerHTML;
@property (nonatomic, retain) NSString * bodyHTML;
@property (nonatomic, retain) NSString * digest;

+ (NSArray *) articlesFromHTML: (NSString *)htmlString;
@end
