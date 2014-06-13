//
//  PTAImporter.h
//  PTAMuseum
//
//  Created by Yung-Luen Lan on 6/13/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PTASite;

@interface PTAImporter : NSObject

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) PTASite *site;

- (id) initWithContext: (NSManagedObjectContext *)context site: (PTASite *)site;

- (void) importWithUsername: (NSString *)name password: (NSString *)password;

@end
