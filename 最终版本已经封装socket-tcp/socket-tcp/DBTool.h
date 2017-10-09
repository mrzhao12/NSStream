//
//  DBTool.h
//  LoginTestDemo
//
//  Created by  壹件事 on 2017/4/6.
//  Copyright © 2017年  壹件事. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, tableType) {
    tableTypeUrlCache,              //网络数据缓存
    tableTypeGlobalData,            //全局数据表
};

@interface DBTool : NSObject

+ (void)saveDataToTable:(tableType)type
                    key:(NSString *)key
                  value:(NSData *)data;

+ (id)dataInTable:(tableType)type
           forKey:(NSString *)key;

+ (void)deleteCacheInTable:(tableType)type
                    forKey:(NSString *)key;

@end
