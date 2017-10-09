//
//  GlobalManager.h
//  LoginTestDemo
//
//  Created by  壹件事 on 2017/4/8.
//  Copyright © 2017年  壹件事. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Login.h"

#define globalMgr [GlobalManager sharedInstance]

@interface GlobalManager : NSObject

+ (instancetype)sharedInstance;

+ (void)synchronize;

@property (nonatomic, assign) BOOL loggedIn;
@property (nonatomic, strong) NSString *msgServerIp,*dnsServerIp;
@property (nonatomic, assign) int32_t msgSocketPort,dnsSocketPort;
@property (nonatomic, strong) LoginData *loginData;

@end
