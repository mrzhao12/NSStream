//
//  NSData+Util.m
//  socket-tcp
//
//  Created by sjhz on 2017/8/18.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import "NSData+Util.h"
#import "YMSocketUtils.h"
#import "FBTable.h"
#import "AppDelegate.h"
#define kProtocolHeaderLength (12)                   //头12个字节 总长度4+serviceId 2+commandId 2+version 2+reserved 2
#define kReqDataLength (4)                           //后面发送或接收的数据长度 4
#define fbConfig [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FBConfig" ofType:@"plist"]]
#define ttservice
static inline NSDictionary *getFBConfigByMethod(NSString *method)
{
    NSDictionary *dict_ = nil;
    for (NSString *key in fbConfig) {
        if ([key isEqualToString:method]) {
            dict_ = fbConfig[key];
            break;
        }
    }
    return dict_;
}

static inline NSDictionary *getFBConfig(FBTable *obj)
{
    NSString *cls = NSStringFromClass([obj class]);
    
    NSDictionary *dict = getFBConfigByMethod(cls);
    
    if (!dict) {
        NSLog(@"找不到该接口对应的配置项，请检查FBConfig.plist");
        return nil;
    }
    
    return dict;
}

@implementation NSData (Util)
+ (NSData *)decodeData:(NSData *)data
{
    const Byte *bytes = data.bytes;
    
    if (data.length<=kProtocolHeaderLength+kReqDataLength) {
        return nil;
    }
    
    Byte h4[4] = {bytes[0],bytes[1],bytes[2],bytes[3]};
    Byte sericeId[2] = {bytes[4],bytes[5]};
    Byte commandId[2] = {bytes[6],bytes[7]};
    Byte versionId[2] = {bytes[8],bytes[9]};
    Byte reservedId[2] = {bytes[10],bytes[11]};
    Byte repDataLen[4] = {bytes[12],bytes[13],bytes[14],bytes[15]};
    
    NSData *totalLenData = [[NSData alloc] initWithBytes:h4 length:4];
    NSData *serData = [[NSData alloc] initWithBytes:sericeId length:2];
    NSData *cmdData = [[NSData alloc] initWithBytes:commandId length:2];
    NSData *verData = [[NSData alloc] initWithBytes:versionId length:2];
    NSData *revData = [[NSData alloc] initWithBytes:reservedId length:2];
    NSData *repLenData = [[NSData alloc] initWithBytes:repDataLen length:kReqDataLength];
    
    if ([YMSocketUtils uint32FromBytes:totalLenData]==0||[YMSocketUtils uint32FromBytes:repLenData]<0) {
        NSLog(@"异常，返回数据总长度为0");
        return nil;
    }
    
    NSLog(@"返回数据总长度：%u",[YMSocketUtils uint32FromBytes:totalLenData]);
    NSLog(@"serviceId: %d",[YMSocketUtils uint16FromBytes:serData]);
//    AppDelegate
//    appttservice = [YMSocketUtils uint16FromBytes:serData];
//    NSUInteger *inte = [YMSocketUtils uint16FromBytes:serData] 
    [[NSUserDefaults standardUserDefaults] setInteger:[YMSocketUtils uint16FromBytes:serData]  forKey:@"ttservice"];

//    [[NSUserDefaults standardUserDefaults] setObject:[YMSocketUtils uint16FromBytes:serData] forKey:@"ttservice"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    NSUserDefaults *def = [NSUserDefaults setValue:[YMSocketUtils uint16FromBytes:serData] forKey:@"ttservice"];
//    def
//    ttservice = [YMSocketUtils uint16FromBytes:serData];
    
    NSLog(@"commandId: %d",[YMSocketUtils uint16FromBytes:cmdData]);
    NSLog(@"version: %d",[YMSocketUtils uint16FromBytes:verData]);
    NSLog(@"reservedId: %d",[YMSocketUtils uint16FromBytes:revData]);
    NSLog(@"后面数据长度: %d",[YMSocketUtils uint32FromBytes:repLenData]);
    
    NSData *data_ = [[NSData alloc] initWithBytes:bytes+kProtocolHeaderLength+kReqDataLength length:data.length-kProtocolHeaderLength-kReqDataLength];
    
    return data_;
}

+ (NSData *)encodeObject:(FBTable *)obj
{
    NSDictionary *dict_ = getFBConfig(obj);
    
    if (!dict_) {
        return nil;
    }
    
    NSMutableData *mData = [NSMutableData data];
    NSData *data = [obj getData];
    [mData appendData:[YMSocketUtils bytesFromUInt32:(uint32_t)data.length+kProtocolHeaderLength+kReqDataLength]];
    [mData appendData:[YMSocketUtils bytesFromUInt16:[dict_[@"serviceId"] intValue]]];
    [mData appendData:[YMSocketUtils bytesFromUInt16:[dict_[@"commandId"] intValue]]];
    [mData appendData:[YMSocketUtils bytesFromUInt16:1]];
    [mData appendData:[YMSocketUtils bytesFromUInt16:1]];
    [mData appendData:[YMSocketUtils bytesFromUInt32:(uint32_t)data.length]];
    [mData appendData:data];
    
    NSLog(@"发送数据长度：%ld",(long)mData.length);
    
    return mData;
}


@end
