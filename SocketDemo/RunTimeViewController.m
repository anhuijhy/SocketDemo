//
//  RunTimeViewController.m
//  SocketDemo
//
//  Created by Jason Jiang on 16/7/8.
//  Copyright © 2016年 Jason Jiang. All rights reserved.
//

#import "RunTimeViewController.h"
#import <objc/runtime.h>

@interface RunTimeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation RunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self runTimeDemo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)runTimeDemo{
    
    unsigned int count;
    objc_property_t *plist = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(plist[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    
    [self.btn addTarget:self action:@selector(jhy:) forControlEvents:UIControlEventTouchUpInside];
}

+(BOOL)resolveClassMethod:(SEL)sel{
    
    NSLog(@"1111没有方法 %@",NSStringFromSelector(sel));
    if ([NSStringFromSelector(sel) isEqualToString:@"jhy:"]) {
        
        return YES;
    }
    
    return YES;
}

+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    NSLog(@"222没有方法 %@",NSStringFromSelector(sel));
    if ([NSStringFromSelector(sel) isEqualToString:@"jhy:"]) {
        
        NSLog(@"替换方法");
        
        class_addMethod(self, sel,[self instanceMethodForSelector:@selector(noMethod)], "v@:*");
    }
    
    return YES;
}

-(IMP)methodForSelector:(SEL)aSelector{
    
    if (!aSelector) [self doesNotRecognizeSelector:aSelector];
    return class_getMethodImplementation(object_getClass((id)self), aSelector);
}

- (void)noMethod{
    
    NSLog(@"no metho");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
