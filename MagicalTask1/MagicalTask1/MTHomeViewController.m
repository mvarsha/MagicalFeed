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
#import "CKCircleMenuView.h"

@interface MTHomeViewController () <UITableViewDelegate, UITableViewDataSource, MTTableViewCellDelegate, CKCircleMenuDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *someStaticData;
@property (nonatomic, strong) NSArray *menuButtonImages;

@property (nonatomic) int direction;
@property (nonatomic) CGFloat angle;
@property (nonatomic) CGFloat delay;
@property (nonatomic) int shadow;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CKCircleMenuView* circleMenuView;

@end

@implementation MTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.estimatedRowHeight = 200.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self setUpDummyFeedData];
    [self setUpSideMenu];
}

- (void)setUpDummyFeedData {
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
    
    self.someStaticData = @[ model1, model2, model1, model2];
}

-(void)setUpSideMenu {
    self.menuButtonImages = @[[UIImage imageNamed:@"NavButtonImage"], [UIImage imageNamed:@"NavButtonImage"], [UIImage imageNamed:@"NavButtonImage"], [UIImage imageNamed:@"NavButtonImage"]];
    self.direction = CircleMenuDirectionLeft;
    self.delay = 0.0;
    self.shadow = 0;
    self.radius = 180.0;
    self.angle = 180.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

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

#pragma mark - Circle Menu Button actions

- (IBAction)worldButtonClick:(id)sender {
    if (self.circleMenuView) {
        [self.circleMenuView closeMenu];
        self.circleMenuView = nil;
    } else {
        NSMutableDictionary* tOptions = [NSMutableDictionary new];
        [tOptions setValue:[NSDecimalNumber numberWithFloat:self.delay] forKey:CIRCLE_MENU_OPENING_DELAY];
        [tOptions setValue:[NSDecimalNumber numberWithFloat:self.angle] forKey:CIRCLE_MENU_MAX_ANGLE];
        [tOptions setValue:[NSDecimalNumber numberWithFloat:self.radius] forKey:CIRCLE_MENU_RADIUS];
        [tOptions setValue:[NSNumber numberWithInt:self.direction] forKey:CIRCLE_MENU_DIRECTION];
        [tOptions setValue:[UIColor colorWithRed:0.0 green:0.25 blue:0.5 alpha:1.0] forKey:CIRCLE_MENU_BUTTON_BACKGROUND_NORMAL];
        [tOptions setValue:[UIColor colorWithRed:0.25 green:0.5 blue:0.75 alpha:1.0] forKey:CIRCLE_MENU_BUTTON_BACKGROUND_ACTIVE];
        [tOptions setValue:[UIColor whiteColor] forKey:CIRCLE_MENU_BUTTON_BORDER];
        [tOptions setValue:[NSNumber numberWithInt:self.shadow] forKey:CIRCLE_MENU_DEPTH];
        [tOptions setValue:[NSDecimalNumber decimalNumberWithString:@"20.0"] forKey:CIRCLE_MENU_BUTTON_RADIUS];
        [tOptions setValue:[NSNumber numberWithBool:NO] forKey:CIRCLE_MENU_TAP_MODE];
        [tOptions setValue:[NSNumber numberWithBool:NO] forKey:CIRCLE_MENU_LINE_MODE];
        [tOptions setValue:[NSNumber numberWithBool:NO] forKey:CIRCLE_MENU_BACKGROUND_BLUR];
        [tOptions setValue:[NSNumber numberWithBool:NO] forKey:CIRCLE_MENU_BUTTON_TINT];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        CKCircleMenuView* tMenu = [[CKCircleMenuView alloc] initAtOrigin:CGPointMake(screenWidth, screenHeight/2) usingOptions:tOptions withImageArray:self.menuButtonImages];
        tMenu.delegate = self;
        [self.view addSubview:tMenu];
        [tMenu openMenu];
        self.circleMenuView = tMenu;
    }
}

- (void)circleMenuActivatedButtonWithIndex:(int)anIndex
{
    UIAlertController* tController = [UIAlertController alertControllerWithTitle:@"Circle Menu Action" message:[NSString stringWithFormat:@"Button pressed at index %i.", anIndex] preferredStyle:UIAlertControllerStyleAlert];
    [tController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:tController animated:YES completion:^{
        self.circleMenuView = nil;
    }];
}

- (IBAction)leftTopButtonClick:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"I too will have some action in future" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
