//
//  MTFeedModel.h
//  MagicalTask1
//
//  Created by Varsha on 29/05/17.
//  Copyright © 2017 Varsha. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, MTButtonType) {
    MTButtonTypeComments,
    MTButtonTypeSupport,
    MTButtonTypeUpvote
};

@interface MTFeedModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *datePosted;
@property (nonatomic, strong) NSString *textPosted;
@property (nonatomic) MTButtonType button1Type;
@property (nonatomic) NSInteger button1ActivityNumber;
@property (nonatomic) MTButtonType button2Type;
@property (nonatomic) NSInteger button2ActivityNumber;

@end
