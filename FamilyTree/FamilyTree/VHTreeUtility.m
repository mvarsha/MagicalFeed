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
@property (nonatomic, strong) NSMutableArray *parentTreeNodes;
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
    self.parentTreeNodes = [[NSMutableArray alloc] init];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Paternal Grand Father" withId:@"0" withParentIdentifier:@"-2" withLevel:0]];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Paternal Grand Mother" withId:@"1" withParentIdentifier:@"-2" withLevel:0]];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Maternal Grand Father" withId:@"2" withParentIdentifier:@"-1" withLevel:0]];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Maternal Grand Mother" withId:@"3" withParentIdentifier:@"-1" withLevel:0]];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Father" withId:@"4" withParentIdentifier:@"0" withLevel:1]];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Mother" withId:@"5" withParentIdentifier:@"2" withLevel:1]];
    [self.treeNodes addObject:[[VHTreeNode alloc] initWithName:@"Me" withId:@"6" withParentIdentifier:@"4" withLevel:2]];
}

- (NSArray *)parentNodesOf:(VHTreeNode*)child {
    [self.parentTreeNodes removeAllObjects];
    NSPredicate *matchingParents = [NSPredicate predicateWithFormat:@"(%K = %@) OR (%K = %@)",
                                    @"identifier", child.parentIdentifier,
                                    @"identifier", [NSString stringWithFormat:@"%d", [child.parentIdentifier intValue] + 1]];
    NSArray *treeNodes = [self.treeNodes filteredArrayUsingPredicate:matchingParents];
    NSPredicate *unnamedParents = [NSPredicate predicateWithFormat:@"%K = %d", @"nameEntered", NO];
    [self.parentTreeNodes addObjectsFromArray:[treeNodes filteredArrayUsingPredicate:unnamedParents]];
    [self loadParents:treeNodes];
    
    return self.parentTreeNodes;
}

- (void)loadParents:(NSArray*)nodes {
    for (VHTreeNode *child in nodes) {
        if (child.nameEntered == YES) {

            NSPredicate *matchingParents = [NSPredicate predicateWithFormat:@"((%K = %@) AND (%K == %d)) OR ((%K = %@) AND (%K == %d))",
                                            @"identifier", child.parentIdentifier, @"nameEntered", NO,
                                            @"identifier", [NSString stringWithFormat:@"%d", [child.parentIdentifier intValue] + 1], @"nameEntered", NO];
            NSArray *treeNodes = [self.treeNodes filteredArrayUsingPredicate:matchingParents];
            [self.parentTreeNodes addObjectsFromArray:treeNodes];
            [self loadParents:treeNodes];
        }
    }
}

- (VHTreeNode *)myNode {
    NSArray *allTreeNodes = self.treeNodes;
    return [allTreeNodes lastObject];
}

- (void)updateNodeWith:(VHTreeNode *)node {
    NSInteger index = [self findMatchingNode:node];
    if (index >=0 ) {
        [self.treeNodes replaceObjectAtIndex:[self findMatchingNode:node] withObject:node];
    }
}

- (NSInteger)findMatchingNode:(VHTreeNode *)node {
    [self.treeNodes indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop){
        VHTreeNode *treeNode = (VHTreeNode *)obj;
        return [treeNode.identifier isEqualToString:node.identifier];
    }];
    return -1;
}

@end
