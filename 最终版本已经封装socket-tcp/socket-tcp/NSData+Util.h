//
//  NSData+Util.h
//  socket-tcp
//
//  Created by sjhz on 2017/8/18.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark 发送／响应数据编码解码
@class  FBTable;
@interface NSData (Util)
+ (NSData *)decodeData:(NSData *)data;

+ (NSData *)encodeObject:(FBTable *)obj;


- (NSInteger)repLength;

- (NSInteger)serviceId;
@end
