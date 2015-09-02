//
//  TQFoolInterceptorTests.m
//  TQFoolInterceptorTests
//
//  Created by qfu on 9/2/15.
//  Copyright (c) 2015 qfu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface TQFoolInterceptorTests : XCTestCase

@end

@implementation TQFoolInterceptorTests

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
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)test_fool_initWithObjects_count
{
    id value = nil;
    
    NSArray *array = @[@"1",value];
    
    if (array && array.count == 0)
    {
        XCTAssert(YES, @"Pass");
    }
}

@end
