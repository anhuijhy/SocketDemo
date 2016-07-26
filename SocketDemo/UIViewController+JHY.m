//
//  UIViewController.m
//  SocketDemo
//
//  Created by Jason Jiang on 16/7/1.
//  Copyright © 2016年 Jason Jiang. All rights reserved.
//

#import "UIViewController+JHY.h"
#import <objc/runtime.h>


static void *jhyData;
static void *jhyStr;

@interface UIViewController ()
@property (nonatomic, strong) NSMutableData *jhyData; /**< jhyData */
@property (nonatomic, strong) NSString *Str; /**< jhyStr */
@end

@implementation UIViewController(JHY)

- (void)getSomeData{
    
    objc_setAssociatedObject(self, &jhyData, [[NSMutableData alloc] init], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &jhyStr, @"the str value", OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    
    NSString *testDataStr = @"test data str";
    NSData *data = [testDataStr dataUsingEncoding:NSUTF8StringEncoding];
    [self.jhyData appendData:data];
    
    NSString*testStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"the data is %@ %@",self.jhyData,testStr);
    NSLog(@"the jhy str is %@",self.Str);
}


- (NSMutableData*)jhyData{
    
    return objc_getAssociatedObject(self, &jhyData);
}

- (NSString *)Str{
    
    return objc_getAssociatedObject(self, &jhyStr);
}
@end
