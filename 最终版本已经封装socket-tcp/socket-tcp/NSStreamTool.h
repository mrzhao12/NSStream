//
//  NSStreamTool.h
//  socket-tcp
//
//  Created by sjhz on 2017/10/6.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerInfo.h"
#import "Login.h"
#import "QtiExamResultQuestion.h"
#import "QtiExamStudentSheet.h"
#import "FBTable.h"
#import "QtiExamList.h"
#import "NSData+Util.h"
@interface NSStreamTool : NSObject

+ (instancetype) connectToHost:(NSString *)ip
                        onPort:(int)port
                       sendReq:(FBTable *)data
                      readData:(void(^)(id rep, uint16_t commandId))rBlk
                       failure:(void(^)(NSError *err))err;


// msg
+(instancetype)connectToMsgServerWithReq:(FBTable *)req
                                readData:(void(^)(id rep, uint16_t commandId))rBlak
                                 failure:(void(^)(NSError *err))err;


@end
