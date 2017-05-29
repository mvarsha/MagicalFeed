//
//  MTTableViewCell.h
//  MagicalTask1
//
//  Created by Varsha on 29/05/17.
//  Copyright © 2017 Varsha. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTTableViewCellDelegate <NSObject>
- (void)button1Click;
- (void)button2Click;
@end

@interface MTTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *datePosted;
@property (weak, nonatomic) IBOutlet UILabel *textPosted;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) id<MTTableViewCellDelegate> delegate;
@end
