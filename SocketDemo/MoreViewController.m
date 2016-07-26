//
//  MoreViewController.m
//  SocketDemo
//
//  Created by Jason Jiang on 16/7/8.
//  Copyright © 2016年 Jason Jiang. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *web; /**<  */
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setIdObject:(NSString *)idObject{
    
    _idObject = idObject;
    [self.web loadHTMLString:idObject baseURL:nil];
}

#pragma marks
#pragma getter

- (UIWebView *)web{

    if (!_web) {
        
        _web = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _web.delegate = self;
        _web.scrollView.scrollEnabled = NO;
        [self.view addSubview:_web];
    }
    
    return _web;
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
