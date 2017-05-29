//
//  MagicalTask1UITests.m
//  MagicalTask1UITests
//
//  Created by Varsha on 29/05/17.
//  Copyright © 2017 Varsha. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MagicalTask1UITests : XCTestCase

@end

@implementation MagicalTask1UITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    XCUIElement *cell = [[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:0];
    [cell.buttons[@"Comments 123"] tap];
    
    XCUIElement *okButton = app.alerts[@"Alert"].collectionViews.buttons[@"OK"];
    [okButton tap];
    [cell.buttons[@"Support 456"] tap];
    [okButton tap];
    [app.buttons[@"LeftTop"] tap];
    [okButton tap];
    [app.buttons[@"RightTop"] tap];
    [[[[[[app.otherElements containingType:XCUIElementTypeButton identifier:@"LeftTop"] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1].buttons[@"Button"] tap];
    [app.alerts[@"Circle Menu Action"].collectionViews.buttons[@"Ok"] tap];
    [[tablesQuery.cells containingType:XCUIElementTypeButton identifier:@"Comments 456"].staticTexts[@"How much does a corrupt official earn in India? #Corruption"] tap];
}

@end
