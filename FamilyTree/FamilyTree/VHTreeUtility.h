//
//  VHTreeUtility.h
//  FamilyTree
//
//  Created by Varsha on 31/05/17.
//  Copyright © 2017 Varsha. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VHTreeNode;
@interface VHTreeUtility : NSObject

+(instancetype)sharedInstance;
- (NSArray *)parentNodesOf:(VHTreeNode*)child;
- (VHTreeNode *)myNode;
- (void)updateNodeWith:(VHTreeNode *)node;

@end
