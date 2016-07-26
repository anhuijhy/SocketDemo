//
//  JJSocket.m
//  SocketDemo
//
//  Created by Jason Jiang on 16/6/28.
//  Copyright © 2016年 Jason Jiang. All rights reserved.
//

#import "JJSocket.h"
#import "RFIWriter.h"
#import "RFIReader.h"
#import "NSDataTracer.h"

#define NET_TCP_ADDRESS @"54.223.196.137"
#define NET_TCP_PORT 7777

@interface JJSocket ()<AsyncSocketDelegate>

@property (nonatomic, strong) AsyncSocket *tcpSocket; /**< run loop tcp socket */

@end


@implementation JJSocket
+(JJSocket *)instance{
   
    static JJSocket *socket;
    static dispatch_once_t t;
    dispatch_once(&t, ^{
    
        socket = [[JJSocket alloc] init];
        
    });
    
    return socket;
}


- (void)send:(NSString *)header withBody:(NSString*)body{
    
    NSData *datas = [[NSString stringWithFormat:@"{\"header\":\"%@\",\"body\":%@}",header,body] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSInteger mid = 0;
    NSInteger mlen = datas.length;
    NSMutableData *ddt = [[NSMutableData alloc] init];
    /**
     组织socket 要发送的数据
     */
    RFIWriter *rfi = [[RFIWriter alloc] initWithData:ddt];
    [rfi writeInt16:mid];
    [rfi writeInt16:htons(mlen)];
    if(datas.length>0){
        [rfi writeBytes:datas];
        [NSDataTracer trace:rfi.data];
        [self.tcpSocket writeData:rfi.data withTimeout:-1 tag:0];
        [self.tcpSocket readDataWithTimeout:-1 tag:1];
    }
}

/*
 * server
 * port
 *
 */
- (void)connectServer:(NSString *)server withPort:(int)port{
    
    NSError *err = nil;
    BOOL isConnect = [self.tcpSocket connectToHost:NET_TCP_ADDRESS onPort:NET_TCP_PORT withTimeout:30 error:&err];
    NSLog(@"tcp connect error %@",err);
    
    if (isConnect) {
        
        NSLog(@"connect correct");
        
    }else{
        
        
    }
    
}


#pragma marks
#pragma socket delegate
- (BOOL)onSocketWillConnect:(AsyncSocket *)sock{
    
    NSLog(@"will connect");
    return YES;
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    
    NSLog(@"did connect");
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
    
    NSLog(@"will disconnect %@",err);
}
- (void)onSocketDidDisconnect:(AsyncSocket *)sock{
    
    NSLog(@"disconnect");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    NSLog(@"读数据");
    
    RFIReader *reader = [[RFIReader alloc] initWithData:data];
    [reader readInt16];
    [reader readInt16];
//    NSUInteger mid = [reader readInt16];
//    NSUInteger mlen = [reader readInt16];
    NSData *jdata = [reader readBytes:data.length - reader.poz];
    NSLog(@"the correct json data is %@",jdata);
    
   NSLog(@"the feed back data is %@",[NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingMutableLeaves error:nil]);

}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    
    NSLog(@"发数据");
    
        [self.tcpSocket readDataWithTimeout:-1 tag:1];
}

- (void)onSocket:(AsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
    
    NSLog(@"length --%lu",(unsigned long)partialLength);
}
#pragma marks
#pragma runloop tcp socket
- (AsyncSocket *)tcpSocket{
    
    if (!_tcpSocket) {
        
        _tcpSocket = [[AsyncSocket alloc] initWithDelegate:self];
    }
    
    return _tcpSocket;
}


@end
