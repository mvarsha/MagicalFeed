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

@interface MTHomeViewController () <UITableViewDelegate, UITableViewDataSource, MTTableViewCellDelegate>
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
    model1.button1Type = MTButtonTypeComments;
    model1.button1ActivityNumber = 123;
    model1.button2Type = MTButtonTypeSupport;
    model1.button2ActivityNumber = 456;
    
    MTFeedModel *model2 = [[MTFeedModel alloc] init];
    model2.name = @"Some One";
    model2.datePosted = @"March 1";
    model2.textPosted = @"How much does a corrupt officialearn in India? #Corruption";
    model2.button1Type = MTButtonTypeComments;
    model2.button1ActivityNumber = 456;
    model2.button2Type = MTButtonTypeSupport;
    model2.button2ActivityNumber = 386;
    
    self.someStaticData = @[ model1, model2];
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
    return [self.someStaticData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MTTableViewCell";
    
    MTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
        cell.delegate = self;
    }
    MTFeedModel *model = [self.someStaticData objectAtIndex:indexPath.row];
    cell.name.text = model.name;
    cell.textPosted.text = model.textPosted;
    //TODO Would need to convert date received to string here. For simplification, have added date as string in the model
    cell.datePosted.text = [NSString stringWithFormat:@"Posted on %@", model.datePosted];
    //TODO attr string should have different font sizes
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [cell.button1 setAttributedTitle:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Comments\n%ld", (long)model.button1ActivityNumber] attributes:@{NSParagraphStyleAttributeName:paragraphStyle}] forState:UIControlStateNormal];
    [cell.button2 setAttributedTitle:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Support\n%ld", (long)model.button2ActivityNumber] attributes:@{NSParagraphStyleAttributeName:paragraphStyle}] forState:UIControlStateNormal];
    return cell;
}

#pragma mark - MTTableViewCellDelegate

-(void)button1Click {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Comments click" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)button2Click {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Support click" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
