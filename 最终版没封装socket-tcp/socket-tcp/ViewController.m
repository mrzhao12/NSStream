//
//  ViewController.m
//  socket-tcp
//
//  Created by sjhz on 2017/8/17.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import "ViewController.h"
#import "ServerInfo.h"
#import "Login.h"
#import "QtiExamResultQuestion.h"
#import "QtiExamStudentSheet.h"
#import "FBTable.h"
#import "QtiExamList.h"
#import "NSData+Util.h"
#import <GCDAsyncSocket.h>
#define fbConfig [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FBConfig" ofType:@"plist"]]
#define kDnsSocketPort (bTestEnvironment?11001:80)
@interface ViewController () <GCDAsyncSocketDelegate,NSStreamDelegate>

@property (nonatomic, strong) FBTable *sendData;
@property (nonatomic, copy) NSString *reqName;
@property (nonatomic, copy) NSString *messIp;
@property (nonatomic, assign) int messPort;
@property (nonatomic, copy) NSString *scId;



@property (nonatomic, strong) NSMutableData *longData;
@property (nonatomic, strong) NSData *data_;
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
{
    NSString *_serverHost;
    int _serverPort;

    
    NSMutableData * _receivedData;
    NSInputStream *_inputStream;
    NSOutputStream *_outputSteam;
    NSString *loginIp;
    int loginPort;
}
- (NSMutableData *)longData{
    
    if (!_longData) {
        _longData = [NSMutableData dataWithCapacity:0];
                     
    }
    return _longData;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSStreamTest";

    
 
    NSString *host = @"119.**.**9.**0";

    int port  = 8080;
    // 2.定义输入输出流
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    // 3.分配输入输出流的内存空间
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, port, &readStream, &writeStream);
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
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 64, 100, 100)];
    [btn setTitle:@"dns连接" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dnsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *Loginbtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 154, 100, 100)];
    [Loginbtn setTitle:@"登陆" forState:UIControlStateNormal];
    [Loginbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Loginbtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Loginbtn];
    
    
    UIButton *sendOther = [[UIButton alloc] initWithFrame:CGRectMake(40, 350, 100, 100)];
    [sendOther setTitle:@"发送其他网络数据" forState:UIControlStateNormal];
    [sendOther setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendOther addTarget:self action:@selector(sendOther:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendOther];
    
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
            NSLog(@"成功连接建立，形成输入输出流的传输通道");
            break;
            
        case NSStreamEventHasBytesAvailable:
            NSLog(@"************有数据可读");
            
            [self readData];
            
            
            break;
            
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"------------===可以发送数据");
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

- (void)dnsBtnClick:(UIButton *)btn {
    //发送请求 使用输出流
        ServerInfoReq *req = [[ServerInfoReq alloc] init];
        req.netType = 22;
    
        self.sendData = req;
    
        NSLog(@"self.sendData:%d",req.netType);
    NSData *data2 = [NSData encodeObject:self.sendData];
    self.reqName = NSStringFromClass([req class]);
    
  
    //uint8_t * 字符数组
//    NSData *data = [loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [_outputSteam write:data2.bytes maxLength:data2.length];
    
}
- (void)loginClick:(UIButton *)btn{

    // 2.定义输入输出流
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    // 3.分配输入输出流的内存空间
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)loginIp, loginPort, &readStream, &writeStream);
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
    ///
    
    
    LoginReq *req = [[LoginReq alloc] init];
    req.userName = @"y**";
        req.password = @"**44*";
        req.deviceType = 22;
        req.attachment = @"";
        NSData *data2 = [NSData encodeObject:req];
    
        self.reqName = NSStringFromClass([req class]);
    
     [_outputSteam write:data2.bytes maxLength:data2.length];
}
- (void)sendOther:(UIButton *)btn{

    
    QtiExamStudentSheetReq *req2 = [[QtiExamStudentSheetReq alloc] init];
    req2.examId = @"1**";
    req2.scId = @"1*";
    NSData *data2 = [NSData encodeObject:req2];

    self.reqName = NSStringFromClass([req2 class]);
    [_outputSteam write:data2.bytes maxLength:data2.length];


}
#pragma mark 读取服务器返回的数据
-(void)readData{
    
    //定义缓冲区 这个缓冲区只能存储1024字节
    uint8_t buf[1024*1000];
    
 
    NSDictionary *dict = getFBConfigByMethod(self.reqName);
    NSString *repCls = dict[@"repCls"];
    Class cls = NSClassFromString(repCls);
    NSLog(@"&&&&:%@",cls);
    NSLog(@"repCls:%@",repCls);
     if ([repCls isEqualToString:@"ServerInfoRep"]) {
         NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
         NSLog(@"888888:%d",len);
         
         NSData *data = [NSData dataWithBytes:buf length:len];
         NSData *data_ = [NSData decodeData:data];
         
         ServerInfoRep *rep = [ServerInfoRep getRootAs:data_];
//         NSLog(@"rep:%@----%d",rep.data.ip,rep.data.port);
         //    loginIp = rep.data.ip;
         loginIp = getIp(rep.data.ip, rep.data.port);
         loginPort = rep.data.port;

         [_inputStream close];
         [_outputSteam close];
     }
    
     else if([repCls isEqualToString:@"LoginRep"]){
         NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
         NSLog(@"888888:%ld",len);
         
         NSData *data = [NSData dataWithBytes:buf length:len];
         NSData *data_ = [NSData decodeData:data];
         NSLog(@"来到了登陆");
         LoginRep *rep =   [LoginRep getRootAs:data_];
         NSLog(@"userName:%@----sex:%@",rep.data.userName,rep.data.sex);
         
     }else if ([repCls isEqualToString:@"QtiExamListRep"]){
         NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];

             NSLog(@"首页列表888888:%ld",len);
             
             NSData *data = [NSData dataWithBytes:buf length:len];
             NSData *data_ = [NSData decodeData:data];
         NSNumber *ser = [[NSUserDefaults standardUserDefaults]objectForKey:@"ttservice"];
           if ([@117 isEqual:ser]) {
             NSLog(@"来到了首页列表");
             // QtiExamListReq
             
             QtiExamListRep *rep = [QtiExamListRep getRootAs:data_];
             NSLog(@"rep.data.count:%ld",rep.data.count);
             
             for (int i = 0; i< rep.data.count; i++) {
                 NSLog(@"data的examName:%@----examType:%@",rep.data[i].examName,rep.data[i].examType);
             }

         }


         
     }else if ([repCls isEqualToString:@"QtiExamStudentSheetRep"]){
         NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
         NSLog(@"批阅888888:%ld",len);
         
         NSData *data = [NSData dataWithBytes:buf length:len];
         [self.longData appendData:data];
         

//         if (self.longData.length<138250) {  139751      138348
         if (self.longData.length<138347) {
             NSLog(@"self.longData.length:%ld",self.longData.length);
             // 139752
             return;
         }else{
             self.data_ = [NSData decodeData:self.longData];
             NSLog(@"self.longData.length:%ld",self.longData.length);
             NSNumber *ser = [[NSUserDefaults standardUserDefaults]objectForKey:@"ttservice"];

             if ([@125 isEqual:ser]) {

             NSLog(@"来到了批阅");
             QtiExamStudentSheetRep *rep = [QtiExamStudentSheetRep getRootAs:self.data_];
             
             //         QtiExamStudentSheetRep *rep = [QtiExamStudentSheetRep getRootAs:data_];
             NSLog(@"rep.data.count:%ld",rep.data.count);
             for (int i = 0; i< rep.data.count; i++) {
                 NSLog(@"studentLoginName:%@---studentName:%@",rep.data[i].studentLoginName,rep.data[i].studentName);
             }
             
         }
         }

     }

}



/**
 通过域名和端口查询对应的ipv4/ipv6的ip
 
 @param domain 域名
 @param port 端口
 @return dns服务器解析后的ip
 */
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
            ip = @"119.*7.**9.1*0";
        }
        else {
            ip = @"119.*7.**9.1*4";
        }
    }
    return ip;
    
}


@end
