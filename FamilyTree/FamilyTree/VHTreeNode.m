//
//  VHTreeNode.m
//  FamilyTree
//
//  Created by Varsha on 31/05/17.
//  Copyright © 2017 Varsha. All rights reserved.
//

#import "VHTreeNode.h"

@implementation VHTreeNode

-(instancetype)initWithName:(NSString *)name withId:(NSString *)identifier withParentIdentifier:(NSString *)parentIdentifier withLevel:(int)level {
    if (self = [super init]) {
        self.name = name;
        self.identifier = identifier;
        self.parentIdentifier = parentIdentifier;
        self.level = level;
        self.nameEntered = NO;
        if ([name isEqualToString:@"Me"]) {
            self.nameEntered = YES;
        }
    }
    return self;
}

@end
