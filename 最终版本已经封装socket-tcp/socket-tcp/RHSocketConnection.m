//
//  RHSocketConnection.m
//  socket-tcp
//
//  Created by sjhz on 2017/8/17.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import "RHSocketConnection.h"
#import "GCDAsyncSocket.h"  

@interface RHSocketConnection ()  <GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *_asyncSocket;
}

@end


@implementation RHSocketConnection
- (instancetype)init
{
    if (self = [super init]) {
        _asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

- (void)dealloc
{
    _asyncSocket.delegate = nil;
    _asyncSocket = nil;
}

- (void)connectWithHost:(NSString *)hostName port:(int)port
{
    NSError *error = nil;
    [_asyncSocket connectToHost:hostName onPort:port error:&error];
    if (error) {
        RHSocketLog(@"[RHSocketConnection] connectWithHost error: %@", error.description);
        if (_delegate && [_delegate respondsToSelector:@selector(didDisconnectWithError:)]) {
            [_delegate didDisconnectWithError:error];
        }
    }
}

- (void)disconnect
{
    [_asyncSocket disconnect];
}

- (BOOL)isConnected
{
    return [_asyncSocket isConnected];
}

- (void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag
{
    [_asyncSocket readDataWithTimeout:timeout tag:tag];
}

- (void)writeData:(NSData *)data timeout:(NSTimeInterval)timeout tag:(long)tag
{
    [_asyncSocket writeData:data withTimeout:timeout tag:tag];
}

#pragma mark -
#pragma mark GCDAsyncSocketDelegate method

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    RHSocketLog(@"[RHSocketConnection] didDisconnect...%@---%@", err.description,err);
    if (_delegate && [_delegate respondsToSelector:@selector(didDisconnectWithError:)]) {
        [_delegate didDisconnectWithError:err];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    RHSocketLog(@"[RHSocketConnection] didConnectToHost: %@, port: %d", host, port);
    if (_delegate && [_delegate respondsToSelector:@selector(didConnectToHost:port:)]) {
        [_delegate didConnectToHost:host port:port];
    }
}

//- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
- (void)socket:(GCDAsyncSocket *)sock didReadData:(nonnull NSData *)data withTag:(long)tag

//- (void)readDataToData:(NSData *)data withTimeout:(NSTimeInterval)timeout tag:(long)tag
{
    RHSocketLog(@"[RHSocketConnection] didReadData length: %lu, tag: %ld", (unsigned long)data.length, tag);
    if (_delegate && [_delegate respondsToSelector:@selector(didReceiveData:tag:)]) {
        [_delegate didReceiveData:data tag:tag];
    }
    [sock readDataWithTimeout:-1 tag:tag];
}
// 读取进度
//-(void)onSocket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{

    
    
    //  sock readDataToData:<#(nonnull NSData *)#> withTimeout:<#(NSTimeInterval)#> tag:<#(long)#>
    RHSocketLog(@"[RHSocketConnection] didReadPartialDataOfLength length :%lu, tag:%ld",partialLength,tag);

    if ([_delegate respondsToSelector:@selector(didReadPartialDataOfLength:tag:)]) {
        [_delegate didReadPartialDataOfLength:partialLength tag:tag];
    }
//    [sock readDataWithTimeout:-1 tag:tag];
      [sock readDataWithTimeout:-1 tag:tag];
}



- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    RHSocketLog(@"[RHSocketConnection] didWriteDataWithTag: %ld", tag);
    [sock readDataWithTimeout:-1 tag:tag];
}
@end
