//
//  PageViewController.m
//  SocketDemo
//
//  Created by Jason Jiang on 16/7/8.
//  Copyright © 2016年 Jason Jiang. All rights reserved.
//

#import "PageViewController.h"
#import "MoreViewController.h"

@interface PageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (nonatomic, strong) UIPageViewController *pageVC; /**<  */
@property (nonatomic, strong) NSMutableArray *pageArray; /**<  */
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self pageVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marks
#pragma getter

- (UIPageViewController *)pageVC{
    
    if (!_pageVC) {
        
        NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                           forKey: UIPageViewControllerOptionSpineLocationKey];
        
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
        _pageVC.view.frame = self.view.bounds;
        [_pageVC setViewControllers:@[[self getMoreVC:0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
            
        }];
        [self addChildViewController:_pageVC];
        [self.view addSubview:_pageVC.view];
    }
    
    return _pageVC;
}

- (MoreViewController *)getMoreVC:(NSUInteger)idx{
    
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    moreVC.idObject = self.pageArray[idx];
    return moreVC;
}

- (NSMutableArray *)pageArray{
    
    if (!_pageArray) {
        
        _pageArray = [NSMutableArray array];
        
        for (int i = 0; i < 11; i++) {
            
            NSString *contentStr = [NSString stringWithFormat:@"the content if %d",i];
            
            [_pageArray addObject:contentStr];
        }
    }
    
    
    return _pageArray;
}

#pragma marks
#pragma pagevc delegate and datasource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    MoreViewController *moreVC = (MoreViewController *)viewController;
    
    NSUInteger index = [self.pageArray indexOfObject:moreVC.idObject];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    
    return [self getMoreVC:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    MoreViewController *moreVC = (MoreViewController *)viewController;
    NSUInteger index = [self.pageArray indexOfObject:moreVC.idObject];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageArray count]) {
        return nil;
    }
    return [self getMoreVC:index];
    
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
