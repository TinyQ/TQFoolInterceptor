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

#pragma mark test NSArray

- (void)test_fool_initWithObjects_count
{
    id value = nil;
    
    NSArray *array = @[@"1",value];
}

- (void)test_fool_objectAtIndex
{
    NSArray *array = @[@"1",@"2"];
    
    id value = [array objectAtIndex:2];
}

#pragma mark test NSMutableArray

- (void)test_fool_insertObject_atIndex
{
    NSMutableArray *array = [NSMutableArray array];
    
    id value = nil;
    
    [array addObject:value];
}

#pragma mark test NSDictionary

- (void)test_fool_initWithObjects_forKeys_count
{
    id value = nil;
    
    NSDictionary *dic = @{@"key":value};
    
    dic = @{value:@"value"};
}

#pragma mark test NSMutableDictionary

- (void)test_fool_setObject_forKey
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    id obj = nil;
    
    [dic setObject:obj forKey:@"key"];
    
    
    [dic setObject:@"" forKey:obj];

}

@end
