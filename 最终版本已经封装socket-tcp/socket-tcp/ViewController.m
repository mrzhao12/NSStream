//
//  ViewController.m
//  socket-tcp
//
//  Created by sjhz on 2017/8/17.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import "ViewController.h"
#import "RHSocketConnection.h"
#import "ServerInfo.h"
#import "Login.h"
#import "QtiExamResultQuestion.h"
#import "QtiExamStudentSheet.h"
#import "FBTable.h"
#import "QtiExamList.h"
#import "NSData+Util.h"
#import <GCDAsyncSocket.h>

#import "NSStreamTool.h"
#import "GlobalManager.h"
#define fbConfig [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FBConfig" ofType:@"plist"]]
#define kDnsSocketPort (bTestEnvironment?11001:80)
@interface ViewController ()
//@property (nonatomic, strong) GCDAsyncSocket *clientSocket;
@property (nonatomic, strong) FBTable *sendData;
@property (nonatomic, copy) NSString *reqName;
@property (nonatomic, copy) NSString *messIp;
@property (nonatomic, assign) int messPort;
@property (nonatomic, copy) NSString *scId;

@property (nonatomic, strong) NSStreamTool *streamTool;

@property (nonatomic, strong) NSMutableData *longData;
@property (nonatomic, strong) NSData *data_;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, assign) int port;

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
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSStreamTest";
    
    
    ServerInfoReq *req = [[ServerInfoReq alloc] init];
    req.netType = 1;
  
    __weak typeof(self) weakSelf = self;

        self.streamTool = [NSStreamTool connectToHost:@"119.**.***.***" onPort:8080 sendReq:req readData:^(ServerInfoRep *rep, uint16_t commandId) {
        NSLog(@"%d",commandId);
        NSLog(@"thread_block: %@",[NSThread currentThread]);
        NSLog(@"获取Msg服务器信息成功!");
        if (rep.data) {
            NSLog(@"rep.data.ip:%@",rep.data.ip);

            globalMgr.msgServerIp=rep.data.ip;
            globalMgr.msgSocketPort=rep.data.port;
            
            NSLog(@"globalMgr.msgServerIp:%@",globalMgr.msgServerIp);
            
            NSLog(@"----6666^^^:%ld",(long)rep.data.port);
            [weakSelf connectMsgServer];
            
        }
    } failure:^(NSError *err) {
        if (err) {
            NSLog(@"err: %@",err.userInfo[@"errMsg"]);
        }
    }];



    
    
}

- (void)connectMsgServer
{
    LoginReq *req = [[LoginReq alloc] init];
    req.userName = @"y***";

    req.password = @"***44***";

     __weak typeof(self) weakSelf = self;
     self.streamTool = [NSStreamTool connectToMsgServerWithReq:req readData:^(LoginRep *rep, uint16_t commandId) {
        NSLog(@"%d",commandId);
        NSLog(@"thread_block: %@",[NSThread currentThread]);
        NSLog(@"学生登录成功!");
        NSLog(@"----rep.err.errMsg:%@",rep.err.errMsg);
        if (rep.data) {

            NSLog(@"******rep.data.userId:%ld",(long)rep.data.userId);
            NSLog(@"rep.data.userName:%@",rep.data.userName);
            [weakSelf request1];
        }
    } failure:^(NSError *err) {
        if (err) {

        }
    }];
    

}

- (void)request1{
    
    QtiExamListReq *req1 = [[QtiExamListReq alloc] init];
    req1.creatorId = @"522221";
    req1.examType = @"课堂练习,课后练习";

      __weak typeof(self) weakSelf = self;
    self.streamTool = [NSStreamTool connectToMsgServerWithReq:req1 readData:^(QtiExamListRep *rep, uint16_t commandId) {
         NSLog(@"第一个请求");
        NSLog(@"课堂练习,课后练习");
        for (int i = 0; i < rep.data.count; i++) {
            NSLog(@"examName:%@---examState:%@",rep.data[i].examName,rep.data[i].examState);
        }
        [weakSelf request2];
    } failure:^(NSError *err) {
        
    }];
    
}
- (void)request2
{
    QtiExamStudentSheetReq *req2 = [[QtiExamStudentSheetReq alloc] init];
    req2.examId = @"**";
    req2.scId = @"**";
    self.streamTool = [NSStreamTool connectToMsgServerWithReq:req2 readData:^(QtiExamStudentSheetRep *rep, uint16_t commandId) {
          NSLog(@"第二个请求");
        for (int i = 0; i< rep.data.count; i++) {
            NSLog(@"examId:%@-----studentName:%@",rep.data[i].examId,rep.data[i].studentName);
        }
    } failure:^(NSError *err) {
        
    }];

}
///**
// 通过域名和端口查询对应的ipv4/ipv6的ip
//
// @param domain 域名
// @param port 端口
// @return dns服务器解析后的ip
// */
static NSString *getIp(NSString *domain,int port)
{
    if (!domain||port==0) {
        return nil;
    }
    NSError *err;
    NSMutableArray *lst = [GCDAsyncSocket lookupHost:domain port:port error:&err];
    NSString *ip;
    if (lst.count) {
        BOOL flag = NO;
        NSString *ipv6;
        //先找ipv6，不存在就找ipv4
        for (NSData *data in lst) {
            if ([GCDAsyncSocket isIPv6Address:data]) {
                flag = YES;
                ipv6 = [GCDAsyncSocket hostFromAddress:data];
                ip = ipv6;
                break;
            };
        }
        if (!flag) {
            NSString *ipv4;
            for (NSData *data in lst) {
                if ([GCDAsyncSocket isIPv4Address:data]) {
                    flag = YES;
                    ipv4 = [GCDAsyncSocket hostFromAddress:data];
                    ip = ipv4;
                    break;
                };
            }
        }
    }
    
    //默认IP
    if (!ip) {
        if ([domain isEqualToString:@"data.51baidu.com"]) {
            ip = @"119.97.1**.***";
        }
        else {
            ip = @"119.97.1**.***";
        }
    }
    return ip;
    
}


@end
