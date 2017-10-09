//
//  GlobalManager.m
//  LoginTestDemo
//
//  Created by  壹件事 on 2017/4/8.
//  Copyright © 2017年  壹件事. All rights reserved.
//

#import "GlobalManager.h"
#import "MJExtension.h"
#import "DBTool.h"

@implementation GlobalManager

MJCodingImplementation

static GlobalManager *mgr_ = nil;

+ (instancetype)sharedInstance
{
    @synchronized (self) {
        if (!mgr_) {
            mgr_ = [[GlobalManager alloc] init];
        }
    }
    return mgr_;
}

+ (void)initialize
{
    [GlobalManager sharedInstance];
}

- (instancetype)init
{
    if (self = [super init]) {

        self.dnsServerIp = @"119.97.1**.**";
        self.dnsSocketPort = 8080;
    }
    return self;
}

+ (void)synchronize
{
    [DBTool saveDataToTable:tableTypeGlobalData key:nil value:nil];
}

@end
