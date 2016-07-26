//
//  NSDataTracer.m
//  终端模拟
//
//  Created by Lily on 16/1/16.
//  Copyright © 2016年 黎健. All rights reserved.
//

#import "NSDataTracer.h"
#import "RFIReader.h"

@implementation NSDataTracer
+(void)trace:(NSData *)data{
    RFIReader *read = [RFIReader readerWithData:data];
    NSString *logstr = @"--send:\n";
    NSInteger len = [data length];
    for(int i=0;i<len;i++){
        NSInteger byte = [read readByte];
        NSString *tmp = @"";
        tmp = [NSString stringWithFormat:@"%lx",byte&0xff];
        if([tmp length] <2){
            tmp = [NSString stringWithFormat:@"%lx",byte&0xff];
        }
        if(i%16 ==0){
            tmp = [NSString stringWithFormat:@"%@\n", tmp];
        }else if(i%4 ==0){
            tmp = [NSString stringWithFormat:@"%@ ", tmp];
        }
        logstr =[NSString stringWithFormat:@"%@ %@",logstr,tmp];
    }
    NSLog(@"%@",logstr);
}
@end
