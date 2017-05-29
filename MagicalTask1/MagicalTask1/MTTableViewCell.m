//
//  MTTableViewCell.m
//  MagicalTask1
//
//  Created by Varsha on 29/05/17.
//  Copyright © 2017 Varsha. All rights reserved.
//

#import "MTTableViewCell.h"

@interface MTTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *cardView;

@end

@implementation MTTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.cardView.layer setCornerRadius:5.0f];
    [self.cardView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.cardView.layer setBorderWidth:0.2f];
    [self.cardView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [self.cardView.layer setShadowOpacity:0.5];
    [self.cardView.layer setShadowRadius:5.0];
    [self.cardView.layer setShadowOffset:CGSizeMake(5.0f, 5.0f)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)button1Click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(button1Click)]) {
        [self.delegate button1Click];
    }
}

- (IBAction)button2Click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(button2Click)]) {
        [self.delegate button2Click];
    }
}

@end
