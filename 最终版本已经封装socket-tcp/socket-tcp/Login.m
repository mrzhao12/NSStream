//
//  Login.m
//  socket-tcp
//
//  Created by sjhz on 2017/8/18.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import "Login.h"

@implementation Login

@end

#pragma mark - ClassData

@implementation ClassData

- (NSString *) year {
    
    _year = [self fb_getString:4 origin:_year];
    
    return _year;
    
}

- (void) add_year {
    
    [self fb_addString:_year voffset:4 offset:4];
    
    return ;
    
}

- (NSString *) grade {
    
    _grade = [self fb_getString:6 origin:_grade];
    
    return _grade;
    
}

- (void) add_grade {
    
    [self fb_addString:_grade voffset:6 offset:8];
    
    return ;
    
}

- (NSString *) classType {
    
    _classType = [self fb_getString:8 origin:_classType];
    
    return _classType;
    
}

- (void) add_classType {
    
    [self fb_addString:_classType voffset:8 offset:12];
    
    return ;
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        bb_pos = 16;
        
        origin_size = 16+bb_pos;
        
        bb = [[FBMutableData alloc]initWithLength:origin_size];
        
        [bb setInt32:bb_pos offset:0];
        
        [bb setInt32:10 offset:bb_pos];
        
        [bb setInt16:10 offset:bb_pos-[bb getInt32:bb_pos]];
        
        [bb setInt16:16 offset:bb_pos-[bb getInt32:bb_pos]+2];
        
    }
    
    return self;
    
}

@end

#pragma mark LoginRep

@implementation LoginData

- (NSString *) userId {
    
    _userId = [self fb_getString:4 origin:_userId];
    
    return _userId;
    
}

- (void) add_userId {
    
    [self fb_addString:_userId voffset:4 offset:4];
    
    return ;
    
}

- (NSString *) loginName {
    
    _loginName = [self fb_getString:6 origin:_loginName];
    
    return _loginName;
    
}

- (void) add_loginName {
    
    [self fb_addString:_loginName voffset:6 offset:8];
    
    return ;
    
}

- (NSString *) password {
    
    _password = [self fb_getString:8 origin:_password];
    
    return _password;
    
}

- (void) add_password {
    
    [self fb_addString:_password voffset:8 offset:12];
    
    return ;
    
}

- (NSString *) userName {
    
    _userName = [self fb_getString:10 origin:_userName];
    
    return _userName;
    
}

- (void) add_userName {
    
    [self fb_addString:_userName voffset:10 offset:16];
    
    return ;
    
}

- (NSString *) year {
    
    _year = [self fb_getString:12 origin:_year];
    
    return _year;
    
}

- (void) add_year {
    
    [self fb_addString:_year voffset:12 offset:20];
    
    return ;
    
}

- (NSString *) grade {
    
    _grade = [self fb_getString:14 origin:_grade];
    
    return _grade;
    
}

- (void) add_grade {
    
    [self fb_addString:_grade voffset:14 offset:24];
    
    return ;
    
}

- (NSString *) classType {
    
    _classType = [self fb_getString:16 origin:_classType];
    
    return _classType;
    
}

- (void) add_classType {
    
    [self fb_addString:_classType voffset:16 offset:28];
    
    return ;
    
}

- (NSString *) role {
    
    _role = [self fb_getString:18 origin:_role];
    
    return _role;
    
}

- (void) add_role {
    
    [self fb_addString:_role voffset:18 offset:32];
    
    return ;
    
}

- (NSString *) scId {
    
    _scId = [self fb_getString:20 origin:_scId];
    
    return _scId;
    
}

- (void) add_scId {
    
    [self fb_addString:_scId voffset:20 offset:36];
    
    return ;
    
}

- (NSString *) scType {
    
    _scType = [self fb_getString:22 origin:_scType];
    
    return _scType;
    
}

- (void) add_scType {
    
    [self fb_addString:_scType voffset:22 offset:40];
    
    return ;
    
}

- (NSString *) scName {
    
    _scName = [self fb_getString:24 origin:_scName];
    
    return _scName;
    
}

- (void) add_scName {
    
    [self fb_addString:_scName voffset:24 offset:44];
    
    return ;
    
}

- (NSString *) portrait {
    
    _portrait = [self fb_getString:26 origin:_portrait];
    
    return _portrait;
    
}

- (void) add_portrait {
    
    [self fb_addString:_portrait voffset:26 offset:48];
    
    return ;
    
}

- (NSString *) sex {
    
    _sex = [self fb_getString:28 origin:_sex];
    
    return _sex;
    
}

- (void) add_sex {
    
    [self fb_addString:_sex voffset:28 offset:52];
    
    return ;
    
}

- (FBMutableArray<ClassData *> *) classes {
    
    _classes = [self fb_getTables:30 origin:_classes className:[ClassData class]];
    
    return _classes;
    
}

- (void) add_classes {
    
    [self fb_addTables:_classes voffset:30 offset:56];
    
    return ;
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        bb_pos = 38;
        
        origin_size = 60+bb_pos;
        
        bb = [[FBMutableData alloc]initWithLength:origin_size];
        
        [bb setInt32:bb_pos offset:0];
        
        [bb setInt32:32 offset:bb_pos];
        
        [bb setInt16:32 offset:bb_pos-[bb getInt32:bb_pos]];
        
        [bb setInt16:60 offset:bb_pos-[bb getInt32:bb_pos]+2];
        
    }
    
    return self;
    
}

@end

#pragma mark LoginReq

@implementation LoginReq

- (NSString *) userName {
    
    _userName = [self fb_getString:4 origin:_userName];
    
    return _userName;
    
}

- (void) add_userName {
    
    [self fb_addString:_userName voffset:4 offset:4];
    
    return ;
    
}

- (NSString *) password {
    
    _password = [self fb_getString:6 origin:_password];
    
    return _password;
    
}

- (void) add_password {
    
    [self fb_addString:_password voffset:6 offset:8];
    
    return ;
    
}

- (int32_t) deviceType {
    
    _deviceType = [self fb_getInt32:8 origin:_deviceType];
    
    return _deviceType;
    
}

- (void) add_deviceType {
    
    [self fb_addInt32:_deviceType voffset:8 offset:12];
    
    return ;
    
}

- (NSString *) attachment {
    
    _attachment = [self fb_getString:10 origin:_attachment];
    
    return _attachment;
    
}

- (void) add_attachment {
    
    [self fb_addString:_attachment voffset:10 offset:16];
    
    return ;
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        bb_pos = 18;
        
        origin_size = 20+bb_pos;
        
        bb = [[FBMutableData alloc]initWithLength:origin_size];
        
        [bb setInt32:bb_pos offset:0];
        
        [bb setInt32:12 offset:bb_pos];
        
        [bb setInt16:12 offset:bb_pos-[bb getInt32:bb_pos]];
        
        [bb setInt16:20 offset:bb_pos-[bb getInt32:bb_pos]+2];
        
    }
    
    return self;
    
}

@end

#pragma mark LoginRep

@implementation LoginRep

- (Err *) err {
    
    _err = [self fb_getTable:4 origin:_err className:[Err class]];
    
    return _err;
    
}

- (void) add_err {
    
    [self fb_addTable:_err voffset:4 offset:4];
    
    return ;
    
}

- (LoginData *) data {
    
    _data = [self fb_getTable:6 origin:_data className:[LoginData class]];
    
    return _data;
    
}

- (void) add_data {
    
    [self fb_addTable:_data voffset:6 offset:8];
    
    return ;
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        bb_pos = 14;
        
        origin_size = 12+bb_pos;
        
        bb = [[FBMutableData alloc]initWithLength:origin_size];
        
        [bb setInt32:bb_pos offset:0];
        
        [bb setInt32:8 offset:bb_pos];
        
        [bb setInt16:8 offset:bb_pos-[bb getInt32:bb_pos]];
        
        [bb setInt16:12 offset:bb_pos-[bb getInt32:bb_pos]+2];
        
    }
    
    return self;
    
}

@end
