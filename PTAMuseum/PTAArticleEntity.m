//
//  PTAArticleEntity.m
//  PTAMuseum
//
//  Created by Yung-Luen Lan on 6/13/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

#import "PTAArticleEntity.h"
#import "PTAArticle.h"

@implementation PTAArticleEntity

@dynamic title;
@dynamic date;
@dynamic category;
@dynamic innerHTML;
@dynamic bodyHTML;
@dynamic digest;

- (void) loadFromArticle: (PTAArticle *)article
{
    self.title = article.title;
    self.date = article.date;
    self.innerHTML = article.innerHTML;
    self.bodyHTML = article.bodyHTML;
    self.digest = article.digest;
}

@end
