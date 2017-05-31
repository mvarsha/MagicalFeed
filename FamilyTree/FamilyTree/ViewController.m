//
//  ViewController.m
//  FamilyTree
//
//  Created by Varsha on 31/05/17.
//  Copyright © 2017 Varsha. All rights reserved.
//

#import "ViewController.h"
#import "VHTreeUtility.h"
#import "VHTreeNode.h"
#import "DownPicker.h"

#define kLabelTag 100

@interface ViewController () <UITextFieldDelegate, DownPickerDataSelected>

@property (nonatomic) DownPicker *picker;
@property (weak, nonatomic) IBOutlet UITextField *addFamily;
@property (nonatomic, strong) NSArray *treeMembers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.treeMembers = [[VHTreeUtility sharedInstance] parentNodesOf:[[VHTreeUtility sharedInstance] myNode]];
    NSArray *memberNames = [self.treeMembers valueForKeyPath:@"name"];
    self.picker = [[DownPicker alloc] initWithTextField:self.addFamily withData:memberNames];
    self.picker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didSelectRow:(NSInteger)row {
    self.addFamily.text = @"Add Family";
    VHTreeNode *node = [self.treeMembers objectAtIndex:row];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter name" message:[NSString stringWithFormat:@"Enter name of your %@", node.name] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter name";
        textField.keyboardType = UIKeyboardTypeNamePhonePad;
    }];
    __weak typeof (self) wself = self;
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *nameField = alertController.textFields.firstObject;
        if (![nameField.text isEqualToString:@""]) {
            UILabel *label = [wself.view viewWithTag:(kLabelTag + [node.identifier intValue])];
            label.text = nameField.text;
            node.name = nameField.text;
            node.nameEntered = YES;
            [[VHTreeUtility sharedInstance] updateNodeInIndex:row withNode:node];
            [wself refreshData];
        }
    }];
    [alertController addAction:confirmAction];
    [alertController.view setNeedsLayout];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) refreshData {
    self.treeMembers = [[VHTreeUtility sharedInstance] parentNodesOf:[[VHTreeUtility sharedInstance] myNode]];
    NSArray *memberNames = [self.treeMembers valueForKeyPath:@"name"];
    [self.picker setData:memberNames];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

@end
