//
//  VHTreeUtility.m
//  FamilyTree
//
//  Created by Varsha on 31/05/17.
//  Copyright © 2017 Varsha. All rights reserved.
//

#import "VHTreeUtility.h"
#import "VHTreeNode.h"

@interface VHTreeUtility()

@property (nonatomic, strong) NSMutableArray *treeNodes;

@end

@implementation VHTreeUtility

+(instancetype)sharedInstance {
    static VHTreeUtility *instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[VHTreeUtility alloc] init];
        [instance initializeTreeNodes];
    });
    return instance;
}

- (void)initializeTreeNodes {
    self.treeNodes = [[NSMutableArray alloc]init];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Paternal Grand Father" withId:@"0" withParentIdentifier:@"-2" withLevel:0]];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Paternal Grand Mother" withId:@"1" withParentIdentifier:@"-2" withLevel:0]];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Maternal Grand Father" withId:@"2" withParentIdentifier:@"-1" withLevel:0]];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Maternal Grand Mother" withId:@"3" withParentIdentifier:@"-1" withLevel:0]];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Father" withId:@"4" withParentIdentifier:@"0" withLevel:1]];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Mother" withId:@"5" withParentIdentifier:@"2" withLevel:1]];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Me" withId:@"6" withParentIdentifier:@"4" withLevel:2]];
}

- (NSArray *)parentNodesOf:(VHTreeNode*)child {
    NSPredicate *matchingParents = [NSPredicate predicateWithFormat:@"((%K = %@) AND (%K == %d)) OR ((%K = %@) AND (%K == %d))",
                                    @"identifier", child.parentIdentifier, @"nameEntered", NO,
                                    @"identifier", [NSString stringWithFormat:@"%d", [child.parentIdentifier intValue] + 1], @"nameEntered", NO];
    NSArray *treeNodes = [self.treeNodes filteredArrayUsingPredicate:matchingParents];
    
    return treeNodes;
}

- (VHTreeNode *)myNode {
    NSArray *allTreeNodes = self.treeNodes;
    return [allTreeNodes lastObject];
}

- (void)updateNodeInIndex:(NSInteger)index withNode:(VHTreeNode *)node {
    [self.treeNodes replaceObjectAtIndex:index withObject:node];
}

@end
