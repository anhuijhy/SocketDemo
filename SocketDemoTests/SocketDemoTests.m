//
//  SocketDemoTests.m
//  SocketDemoTests
//
//  Created by Jason Jiang on 16/6/28.
//  Copyright © 2016年 Jason Jiang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SocketDemoTests : XCTestCase

@end

@implementation SocketDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSLog(@"自定义测试testExample");
    int  a= 3;
    XCTAssertTrue(a == 3,"a 不能等于 0");

    
    XCTAssertEqual(@"fdfa", @"fdfad",@"不等");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
