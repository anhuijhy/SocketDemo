//
//  JJSocket.h
//  SocketDemo
//
//  Created by Jason Jiang on 16/6/28.
//  Copyright © 2016年 Jason Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CocoaAsyncSocket; 

@interface JJSocket : NSObject
+(JJSocket *)instance;
- (void)connectServer:(NSString *)server withPort:(int)port;
- (void)send:(NSString *)header withBody:(NSString*)body;
@end
