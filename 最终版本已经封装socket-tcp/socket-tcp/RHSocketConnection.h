//
//  RHSocketConnection.h
//  socket-tcp
//
//  Created by sjhz on 2017/8/17.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHSocketConfig.h"

@protocol RHSocketConnectionDelegate <NSObject>

- (void)didDisconnectWithError:(NSError *)error;
- (void)didConnectToHost:(NSString *)host port:(UInt16)port;
- (void)didReceiveData:(NSData *)data tag:(long)tag;



///

- (void)didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag;
/**
 
 读取进度
 **/
//-(void)onSocket:(AsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag;


///

@end
@interface RHSocketConnection : NSObject
@property (nonatomic, weak) id<RHSocketConnectionDelegate> delegate;

- (void)connectWithHost:(NSString *)hostName port:(int)port;
- (void)disconnect;

- (BOOL)isConnected;
- (void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag;
- (void)writeData:(NSData *)data timeout:(NSTimeInterval)timeout tag:(long)tag;
@end
