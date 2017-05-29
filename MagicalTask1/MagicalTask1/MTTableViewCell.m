//
//  MTTableViewCell.m
//  MagicalTask1
//
//  Created by Varsha on 29/05/17.
//  Copyright © 2017 Varsha. All rights reserved.
//

#import "MTTableViewCell.h"

@interface MTTableViewCell()

@end

@implementation MTTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.layer setCornerRadius:5.0f];
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.layer setBorderWidth:0.2f];
    [self.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
    [self.layer setShadowOpacity:1.0];
    [self.layer setShadowRadius:5.0];
    [self.layer setShadowOffset:CGSizeMake(5.0f, 5.0f)];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
