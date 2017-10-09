//
//  Err.h
//  socket-tcp
//
//  Created by sjhz on 2017/8/18.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import "FBTable.h"

@interface Err : FBTable
@property (nonatomic, assign)int32_t errCode;

@property (nonatomic, strong)NSString *errMsg;

@end
