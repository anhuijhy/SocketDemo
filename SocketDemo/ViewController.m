//
//  ViewController.m
//  SocketDemo
//
//  Created by Jason Jiang on 16/6/28.
//  Copyright © 2016年 Jason Jiang. All rights reserved.
//

#import "ViewController.h"
#import "JJSocket.h"
#import <objc/runtime.h>
#import "UIViewController+JHY.h"
#import "RunTimeViewController.h"
#import "PageViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSString *jhy; /**< <#属性注释#> */
@property (nonatomic, strong) UITableView *table; /**<  */
@property (nonatomic, strong) NSMutableArray *dataList; /**< <#属性注释#> */
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self table];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma marks
#pragma getter
-(UITableView *)table{
    
    if (!_table) {
        
        _table = [[UITableView alloc] init];
        _table.delegate = self;
        _table.dataSource = self;
        _table.frame = self.view.bounds;
        [self.view addSubview:_table];
    }
    
    return _table;
}
#pragma marks
#pragma tableview delegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }

    cell.textLabel.text = self.dataList[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        [[JJSocket instance] connectServer:nil withPort:0];
            
        [[JJSocket instance] send:@"RegisterReq" withBody:@"{\"content\":{}}"];
            break;
        case 1:{
            RunTimeViewController *runVC = [[RunTimeViewController alloc] init];
            [self.navigationController pushViewController:runVC animated:YES];
        }
            break;
            case 2:
        {
            
            PageViewController *page = [[PageViewController alloc] init];
            [self.navigationController pushViewController:page animated:YES];
        }
            break;
        default:
            break;
    }
    
}
- (NSMutableArray *)dataList{
    
    if (!_dataList) {
        
        _dataList = [NSMutableArray array];
        
        [_dataList addObject:@"socket"];
        [_dataList addObject:@"runTime"];
        [_dataList addObject:@"pageViewController"];
    }
    
    return _dataList;
}
@end
