//
//  VHTreeNode.h
//  FamilyTree
//
//  Created by Varsha on 31/05/17.
//  Copyright © 2017 Varsha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VHTreeNode : NSObject

-(instancetype)initWithName:(NSString *)name withId:(NSString *)identifier withParentIdentifier:(NSString *)parentIdentifier withLevel:(int)level;

@property (nonatomic) int level;
@property (nonatomic) BOOL nameEntered;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *parentIdentifier;

@end
