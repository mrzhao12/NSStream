//
//  Login.h
//  socket-tcp
//
//  Created by sjhz on 2017/8/18.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Err.h"
@interface Login : NSObject

@end
#pragma mark - ClassData

@interface ClassData : FBTable

@property (nonatomic, strong)NSString *year;

@property (nonatomic, strong)NSString *grade;

@property (nonatomic, strong)NSString *classType;

@end

#pragma mark LoginData


@interface LoginData : FBTable

@property (nonatomic, strong)NSString *userId;

@property (nonatomic, strong)NSString *loginName;

@property (nonatomic, strong)NSString *password;

@property (nonatomic, strong)NSString *userName;

@property (nonatomic, strong)NSString *year;

@property (nonatomic, strong)NSString *grade;

@property (nonatomic, strong)NSString *classType;

@property (nonatomic, strong)NSString *role;

@property (nonatomic, strong)NSString *scId;

@property (nonatomic, strong)NSString *scType;

@property (nonatomic, strong)NSString *scName;

@property (nonatomic, strong)NSString *portrait;

@property (nonatomic, strong)NSString *sex;

@property (nonatomic, strong)FBMutableArray<ClassData *> *classes;

@end


#pragma mark LoginReq

@interface LoginReq : FBTable

@property (nonatomic, strong)NSString *userName;

@property (nonatomic, strong)NSString *password;

@property (nonatomic, assign)int32_t deviceType;

@property (nonatomic, strong)NSString *attachment;

@end


#pragma mark LoginRep

@interface LoginRep : FBTable

@property (nonatomic, strong)Err *err;

@property (nonatomic, strong)LoginData *data;

@end
