//
//  QtiExamResultQuestion.h
//  socket-tcp
//
//  Created by sjhz on 2017/8/18.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBTable.h"
@interface QtiExamResultQuestion : NSObject

@end

@interface QtiExamResultQuestionData : FBTable

@property (nonatomic, strong)NSString *questionId;

@property (nonatomic, strong)NSString *rightCount;

@property (nonatomic, strong)NSString *wrongCount;

@property (nonatomic, strong)NSString *examId;

@property (nonatomic, strong)NSString *paperId;

@end



@interface QtiExamResultQuestionRep : FBTable

@property (nonatomic, strong)FBMutableArray<QtiExamResultQuestionData *> *data;

@property (nonatomic, strong)NSString *classStudentCount;

@end


@interface QtiExamResultQuestionReq : FBTable

@property (nonatomic, strong)NSString *examId;

@property (nonatomic, strong)NSString *paperId;

@property (nonatomic, strong)NSString *scId;

@end


