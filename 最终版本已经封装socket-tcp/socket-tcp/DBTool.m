//
//  DBTool.m
//  LoginTestDemo
//
//  Created by  壹件事 on 2017/4/6.
//  Copyright © 2017年  壹件事. All rights reserved.
//

#import "DBTool.h"
#import "GlobalManager.h"
#import "FMDB.h"

static const NSString *FBCache_Table = @"FBCache_Table";
static const NSString *GlobalData_Table = @"GlobalData_Table";

@interface DBTool ()

+ (instancetype)sharedInstance;

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation DBTool

static DBTool *mgr = nil;

#define fmdbQueue [FMDatabaseQueue databaseQueueWithPath:[NSHomeDirectory() stringByAppendingString:@"/Documents/test.db"]]

+ (instancetype)sharedInstance
{
    @synchronized (self) {
        if (!mgr) {
            mgr = [[DBTool alloc] init];
        }
    }
    return mgr;
}

+ (void)initialize
{
    [DBTool sharedInstance];
}

- (instancetype)init
{
    if (self = [super init]) {
        NSLog(@"%@",[NSHomeDirectory() stringByAppendingString:@"/Documents/test.db"]);
        self.db = [FMDatabase databaseWithPath:[NSHomeDirectory() stringByAppendingString:@"/Documents/test.db"]];
        [self.db open];
        
        __block BOOL flag = NO;
        
        [fmdbQueue inDatabase:^(FMDatabase *db) {
            flag = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS FBCache_Table(key text NOT NULL, value blob NOT NULL)"];
            if (!flag) {
                NSLog(@"创建网络缓存表失败");
            }
            flag = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS GlobalData_Table(data blob NOT NULL)"];
            if (!flag) {
                NSLog(@"创建全局数据表失败");
            }
        }];
        
        [self.db close];
    }
    return self;
}

+ (void)saveDataToTable:(tableType)type key:(NSString *)key value:(NSData *)data
{
    if (type==tableTypeUrlCache) {
        if (key.length==0||data.length==0) {
            return;
        }
        [[DBTool sharedInstance].db open];
        
        //删除旧值
        [self deleteCacheInTable:type forKey:key];
        
        __block BOOL flg = NO;
        
        [fmdbQueue inDatabase:^(FMDatabase *db) {
            flg = [db executeUpdate:@"INSERT INTO FBCache_Table(key,value) VALUES(?,?)",key,data];
            if (!flg) {
                NSLog(@"插入数据失败");
            }
        }];
        
        [[DBTool sharedInstance].db close];
    }
    else if (type==tableTypeGlobalData) {
        [[DBTool sharedInstance].db open];
        
        //删除旧值
        [self deleteCacheInTable:type forKey:key];
        
        __block BOOL flg = NO;
        
        [fmdbQueue inDatabase:^(FMDatabase *db) {
            flg = [db executeUpdate:@"INSERT INTO GlobalData_Table(data) VALUES(?)",[NSKeyedArchiver archivedDataWithRootObject:globalMgr]];
            if (!flg) {
                NSLog(@"插入数据失败");
            }
        }];
        
        [[DBTool sharedInstance].db close];
    }
}

+ (id)dataInTable:(tableType)type forKey:(NSString *)key
{
    if (type==tableTypeUrlCache) {
        if (key.length==0) {
            return nil;
        }
        [[DBTool sharedInstance].db open];
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM '%@';",FBCache_Table];
        FMResultSet *rs = [[DBTool sharedInstance].db executeQuery:sql];
        while ([rs next]) {
            NSString *key_ = [rs stringForColumn:@"key"];
            if ([key isEqualToString:key_]) {
                NSData *data = rs.resultDictionary[@"value"];
                [[DBTool sharedInstance].db close];
                return data;
                break;
            }
        }
        [[DBTool sharedInstance].db close];
        return nil;
    }
    else if (type==tableTypeGlobalData) {
        [[DBTool sharedInstance].db open];
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM '%@';",GlobalData_Table];
        FMResultSet *rs = [[DBTool sharedInstance].db executeQuery:sql];
        while ([rs next]) {
            NSData *data = rs.resultDictionary[@"data"];
            return [NSKeyedUnarchiver unarchiveObjectWithData:data];
            break;
        }
        [[DBTool sharedInstance].db close];
        return nil;
    }
    return nil;
}

+ (void)deleteCacheInTable:(tableType)type forKey:(NSString *)key
{
    if (type==tableTypeUrlCache) {
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from FBCache_Table where key = '%@'",
                               key];
        __block BOOL delRst = NO;
        [fmdbQueue inDatabase:^(FMDatabase *db) {
            delRst = [db executeUpdate:deleteSql];
            if (!delRst) {
                NSLog(@"删除旧值失败");
            }
        }];
    }
    else if (type==tableTypeGlobalData) {
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete * from GlobalData_Table"];
        __block BOOL delRst = NO;
        [fmdbQueue inDatabase:^(FMDatabase *db) {
            delRst = [db executeUpdate:deleteSql];
            if (!delRst) {
                NSLog(@"删除旧值失败");
            }
        }];
    }
}

@end
