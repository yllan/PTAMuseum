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
#import "NSString+RegexAddition.h"

@implementation PTAArticle

+ (NSArray *) articlesFromHTML: (NSString *)htmlString
{
    NSMutableArray *resultArray = [NSMutableArray new];
    OCGumboDocument *document = [[OCGumboDocument alloc] initWithHTMLString: htmlString];
    
    for (OCGumboElement *articleElement in document.Query(@"div.article")) {
        PTAArticle *article = [PTAArticle new];
        article.innerHTML = articleElement.html();

#define GetText(e) (e ? e.text() : nil)
#define GetHtml(e) (e ? e.html() : nil)
        
        article.title = GetText(articleElement.Query(@".article-title").first());
        article.date = GetText(articleElement.Query(@".article-time").first());
        
        article.category = GetText(articleElement.Query(@".article-category").first());
        article.bodyHTML = GetHtml(articleElement.Query(@"div").first());
        if (article.title == nil && article.date == nil) continue;
        [resultArray addObject: article];
    }
    
    
    for (OCGumboElement *articleElement in document.Query(@"div.day")) {
        PTAArticle *article = [PTAArticle new];
        article.innerHTML = articleElement.html();
        NSString *category = nil;
        if ([articleElement.attr(@"class") rangeOfString: @"member-47"].location != NSNotFound) {
            category = @"のっち";
        } else if ([articleElement.attr(@"class") rangeOfString: @"member-46"].location != NSNotFound) {
            category = @"かしゆか";
        } else if ([articleElement.attr(@"class") rangeOfString: @"member-45"].location != NSNotFound) {
            category = @"あ～ちゃん";
        }
        
        article.title = GetText(articleElement.Query(@"h3").first());
        article.date = [GetText(articleElement.Query(@"h4").first()) firstSubstringMatchesPattern: @"\\d+\\.\\d+\\.\\d+"];
        article.category = category;
        article.bodyHTML = GetHtml(articleElement.Query(@"div.itembody").first());
        [resultArray addObject: article];
    }
    return resultArray;
}

- (NSString *) description
{
    return [NSString stringWithFormat: @"PTAArticle(%@, %@, %@)", self.title, self.date, self.category];
}

@end
