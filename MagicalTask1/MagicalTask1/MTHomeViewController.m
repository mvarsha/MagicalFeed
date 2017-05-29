//
//  MTHomeViewController.m
//  MagicalTask1
//
//  Created by Varsha on 29/05/17.
//  Copyright © 2017 Varsha. All rights reserved.
//

#import "MTHomeViewController.h"
#import "MTTableViewCell.h"
#import "MTFeedModel.h"

@interface MTHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *someStaticData;

@end

@implementation MTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.estimatedRowHeight = 200.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    MTFeedModel *model1 = [[MTFeedModel alloc] init];
    model1.name = @"Alphonso Mango";
    model1.datePosted = @"April 1";
    model1.textPosted = @"I see skies of blue, And clouds of white, The bright blessed day, The dark sacred night, And I think to myself, What a wonderful world. #Luis Armstrong";
    model1.buttonType = 
    self.someStaticData = @[ @{@"":@""}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MTTableViewCell";
    
    MTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    return cell;
}

@end
