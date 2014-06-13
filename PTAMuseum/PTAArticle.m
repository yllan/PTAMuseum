//
//  PTAArticle.m
//  PTAMuseum
//
//  Created by Yung-Luen Lan on 6/13/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

#import "PTAArticle.h"
#import "OCGumbo.h"
#import "OCGumbo+Query.h"

@implementation PTAArticle

+ (NSArray *) articlesFromHTML: (NSString *)htmlString
{
    NSMutableArray *resultArray = [NSMutableArray new];
    OCGumboDocument *document = [[OCGumboDocument alloc] initWithHTMLString: htmlString];
    
    for (OCGumboElement *articleElement in document.Query(@"div.article")) {
        PTAArticle *article = [PTAArticle new];
        article.innerHTML = articleElement.html();
        article.title = articleElement.Query(@".article-title").first().text();
        article.date = articleElement.Query(@".article-time").first().text();
        article.category = articleElement.Query(@".article-category").first().text();

        article.bodyHTML = articleElement.Query(@"div").first().html();
        
        [resultArray addObject: article];
    }
    
    return resultArray;
}

- (NSString *) description
{
    return [NSString stringWithFormat: @"PTAArticle(%@, %@, %@)", self.title, self.date, self.category];
}

@end
