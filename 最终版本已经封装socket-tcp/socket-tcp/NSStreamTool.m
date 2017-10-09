//
//  NSStreamTool.m
//  socket-tcp
//
//  Created by sjhz on 2017/10/6.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import "NSStreamTool.h"
#import "GlobalManager.h"
#import <GCDAsyncSocket.h>
#define fbConfig [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FBConfig" ofType:@"plist"]]
#define kDnsSocketPort (bTestEnvironment?11001:80)

#define MB_ShowText(text_) {[MBProgressHUD showToastViewOnView:[UIApplication sharedApplication].keyWindow text:(text_) afterDelay:2.f model:NO];}
#define kErrorDomain (@"com.yjs.HomeworkAssistant")
@interface NSStreamTool ()<NSStreamDelegate>
@property (nonatomic, copy) void (^readDataBlock)(id, uint16_t);
@property (nonatomic, copy) void (^errBlock)(NSError *);
@property (nonatomic, assign) int port;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, strong) FBTable *sendData;
@property (nonatomic, copy) NSString *reqName;

@property (nonatomic, strong) NSString *ttmsgHost;
@property (nonatomic, assign) int ttmsgPort;
@property (nonatomic, strong) NSMutableData *longData;
@end
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

@implementation NSStreamTool
{
    NSInputStream *_inputStream;
    NSOutputStream *_outputSteam;
    NSInputStream *_msginputStream;
    NSOutputStream *_msgoutputSteam;

}

- (void)dealloc{
    
    NSLog(@"%s",__func__);
}

+ (instancetype)connectToHost:(NSString *)ip onPort:(int)port sendReq:(FBTable *)data readData:(void (^)(id, uint16_t))rBlk failure:(void (^)(NSError *))err{
    
    return [[self alloc] initWithIp:ip port:port sendReq:data readData:rBlk failure:err];
    
}

+ (instancetype)connectToMsgServerWithReq:(FBTable *)req readData:(void (^)(id, uint16_t))rBlak failure:(void (^)(NSError *))err{

    return [self connectToHost:@"119.9*.1**.1**" onPort:19 sendReq:req readData:rBlak failure:err];

    
}

- (instancetype)initWithIp:(NSString *)ip port:(int)port sendReq:(FBTable *)data readData:(void(^)(id data,uint16_t commandId))rBlk failure:(void(^)(NSError *err))err{
    
    if (self = [super init]) {

        self.ip = ip;
      self.port = port;
        self.readDataBlock = rBlk;
        self.errBlock = err;
        self.sendData = data;
        self.reqName = NSStringFromClass([data class]);

        if (globalMgr.msgServerIp) {
            [self msgConnect];
        }else{
             [self dnsconnect];
        }
    }
    
    return self;
    
}
// 创建nsstream
- (void)dnsconnect{
    
    [self creatNSStreamWith:self.ip port:self.port];
    
}
- (void)creatNSStreamWith:(NSString *)ip port:(int)port{

        //     2.定义输入输出流
        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;
        
        // 3.分配输入输出流的内存空间
        //        CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)([NSStreamObject sharedInstance].dnsHost),  ([NSStreamObject sharedInstance].dnsPort), &readStream, &writeStream);
        CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)ip,port, &readStream, &writeStream);


        // 4.把C语言的输入输出流转成OC对象
        _inputStream = (__bridge NSInputStream *)readStream;
        _outputSteam = (__bridge NSOutputStream *)(writeStream);
        
        // 5.设置代理,监听数据接收的状态
        _outputSteam.delegate = self;
        _inputStream.delegate = self;
        
        // 把输入输入流添加到主运行循环(RunLoop)
        // 主运行循环是监听网络状态
        [_outputSteam scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        [_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        // 6.打开输入输出流
        [_inputStream open];
        [_outputSteam open];

}
//代理的回调是在主线程
//NSLog(@"%@",[NSThread currentThread]);
-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    
    //    NSStreamEventOpenCompleted = 1UL << 0,
    //    NSStreamEventHasBytesAvailable = 1UL << 1,
    //    NSStreamEventHasSpaceAvailable = 1UL << 2,
    //    NSStreamEventErrorOccurred = 1UL << 3,
    //    NSStreamEventEndEncountered = 1UL << 4

    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"aStream:%@",aStream);
            NSLog(@"成功连接建立，形成输入输出流的传输通道"); // 还要等待出现NSStreamEventHasSpaceAvailable才可以发送数据
           
            break;

        case NSStreamEventHasBytesAvailable:
            NSLog(@"************有数据可读");
            if (globalMgr.msgServerIp) {
               [self readMsgData];
            }else{

               [self readData];

            }
            break;

        case NSStreamEventHasSpaceAvailable:
            NSLog(@"可以发送数据");
            [self sendNetWorkData];

            break;

        case NSStreamEventErrorOccurred:
            NSLog(@"有错误发生，连接失败");

            break;

        case NSStreamEventEndEncountered:
            NSLog(@"正常的断开连接");
            //把输入输入流关闭，而还要从主运行循环移除
            [_inputStream close];
            [_outputSteam close];
            [_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            [_outputSteam removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

            break;
        default:
            break;
    }
    
}

- (void)sendNetWorkData{
    NSLog(@"sendNetWorkData");
    NSData *data = [NSData encodeObject:self.sendData];
    [_outputSteam write:data.bytes maxLength:data.length];
    
}
- (void)readData{

    NSLog(@"readData____");
    uint8_t buf[1024*1000];
    // 读取数据
    // len为从服务器读取到的实际字节数
    NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
      NSData *data = [NSData dataWithBytes:buf length:len];

        if (self.readDataBlock&&len) {

            NSData *tmpData = [NSData decodeData:data];
            NSDictionary *dict = getFBConfigByMethod(self.reqName);
            NSString *repCls = dict[@"repCls"];
            Class cls = NSClassFromString(repCls);
            // 把socket返回的数据解析到父类FBTable：NSObject
            FBTable *table = [cls getRootAs:tmpData];

                 // 断开dns
            [_inputStream close];
            [_outputSteam close];
            [_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            [_outputSteam removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            self.readDataBlock(table,(uint16_t)[dict[@"commandId"] intValue]);
   

        }

}
- (NSMutableData *)longData{
    
    if (!_longData) {
        _longData = [NSMutableData dataWithCapacity:0];
        
    }
    return _longData;
    
}
- (void)readMsgData{
    

    NSLog(@"readMsgData");
    uint8_t buf[1024*1000];
    NSDictionary *dict = getFBConfigByMethod(self.reqName);
    NSString *repCls = dict[@"repCls"];
   
   
    if ([repCls isEqualToString:@"QtiExamStudentSheetRep"]) {
        // 读取数据
        // len为从服务器读取到的实际字节数
        NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
         NSLog(@"批阅888888:%ld",len);
        NSData *data = [NSData dataWithBytes:buf length:len];
         [self.longData appendData:data];
        
        
        if (self.longData.length < 138347) {
            NSLog(@"self.longData.length:%ld",self.longData.length);
            // 139752
            return;
        }else{
            
            if (self.readDataBlock&&len) {
                
                NSData *tmpData = [NSData decodeData:self.longData];
                
                 NSLog(@"readDataBlock里self.longData.length:%ld",self.longData.length);
                
                Class cls = NSClassFromString(repCls);
                // 把socket返回的数据解析到父类FBTable：NSObject
                FBTable *table = [cls getRootAs:tmpData];
                [_inputStream close];
                [_outputSteam close];
                self.readDataBlock(table,(uint16_t)[dict[@"commandId"] intValue]);
                
            }
            
        }
    }else{
        
        if (self.readDataBlock) {
            // 读取数据
            // len为从服务器读取到的实际字节数
            NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
            NSData *data = [NSData dataWithBytes:buf length:len];
            NSData *tmpData = [NSData decodeData:data];
            
            Class cls = NSClassFromString(repCls);
            // 把socket返回的数据解析到父类FBTable：NSObject
            FBTable *table = [cls getRootAs:tmpData];
            [_inputStream close];
            [_outputSteam close];
            self.readDataBlock(table,(uint16_t)[dict[@"commandId"] intValue]);
            
        }
        
    }

}

- (void)msgConnect{

     [self creatNSStreamWith:@"119.1*.1**.1**" port:19];
    

}


///**
// 通过域名和端口查询对应的ipv4/ipv6的ip
//
// @param domain 域名
// @param port 端口
// @return dns服务器解析后的ip
// */
//static NSString *getIp(NSString *domain,int port)
//{
//    if (!domain||port==0) {
//        return nil;
//    }
//    NSError *err;
//    NSMutableArray *lst = [GCDAsyncSocket lookupHost:domain port:port error:&err];
//    NSString *ip;
//    if (lst.count) {
//        BOOL flag = NO;
//        NSString *ipv6;
//        //先找ipv6，不存在就找ipv4
//        for (NSData *data in lst) {
//            if ([GCDAsyncSocket isIPv6Address:data]) {
//                flag = YES;
//                ipv6 = [GCDAsyncSocket hostFromAddress:data];
//                ip = ipv6;
//                break;
//            };
//        }
//        if (!flag) {
//            NSString *ipv4;
//            for (NSData *data in lst) {
//                if ([GCDAsyncSocket isIPv4Address:data]) {
//                    flag = YES;
//                    ipv4 = [GCDAsyncSocket hostFromAddress:data];
//                    ip = ipv4;
//                    break;
//                };
//            }
//        }
//    }
//
//    //默认IP
//    if (!ip) {
//        if ([domain isEqualToString:@"data.51miaohui.com"]) {
//            ip = @"11";
//        }
//        else {
//            ip = @"119.";
//        }
//    }
//    return ip;
//
//}
@end
