//
//  QtiExamStudentSheet.h
//  socket-tcp
//
//  Created by sjhz on 2017/8/21.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBTable.h"
@interface QtiExamStudentSheet : NSObject

@end

/*
 
 8.取一次练习（考试）的所有的答题卡
 
 */


@interface QtiExamStudentSheetData : FBTable

@property (nonatomic, strong)NSString *examId;

@property (nonatomic, strong)NSString *paperId;

@property (nonatomic, strong)NSString *questionId;

@property (nonatomic, strong)NSString *questionType;

@property (nonatomic, strong)NSString *questionNo;

@property (nonatomic, strong)NSString *studentId;

@property (nonatomic, strong)NSString *studentName;

@property (nonatomic, strong)NSString *studentLoginName;

@property (nonatomic, strong)NSString *studentClass;

@property (nonatomic, strong)NSString *result;

@property (nonatomic, strong)NSString *rightOrWrong;

@property (nonatomic, strong)NSString *sheetUrl;

@property (nonatomic, strong)NSString *sheetUrlDraw;

@property (nonatomic, strong)NSString *wholeSheetUrl;

@property (nonatomic, strong)NSString *isFav;

@property (nonatomic, strong)NSString *isBest;

@property (nonatomic, strong)NSString *voiceUrl;

@end


@interface QtiExamStudentSheetRep : FBTable

@property (nonatomic, strong)FBMutableArray<QtiExamStudentSheetData *> *data;

@end




@interface QtiExamStudentSheetReq : FBTable

@property (nonatomic, strong)NSString *examId;

@property (nonatomic, strong)NSString *scId;

@end
