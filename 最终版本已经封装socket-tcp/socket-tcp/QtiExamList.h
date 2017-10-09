//
//  QtiExamList.h
//  WorkAssistant
//
//  Created by  壹件事 on 2017/7/5.
//  Copyright © 2017年  壹件事. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FBTable.h"
@interface QtiExamList : NSObject

@end

/*4.练习（或考试）list
 Version 1.0
 (1)请求ID  116 （代码中的commandId）
 */

@interface MediaData : FBTable

@property (nonatomic, strong)NSString *title;

@property (nonatomic, strong)NSString *mediaUrl;

@property (nonatomic, strong)NSString *coverUrl;

@property (nonatomic, strong)NSString *duration;

@property (nonatomic, strong)NSString *convertState;

@end

#pragma mark - QtiExamListReq

@interface QtiExamListReq : FBTable

@property (nonatomic, strong)NSString *examId;

@property (nonatomic, strong)NSString *examName;

@property (nonatomic, strong)NSString *creatorId;

@property (nonatomic, strong)NSString *examType;

@property (nonatomic, strong)NSString *year;

@property (nonatomic, strong)NSString *gradeType;

@property (nonatomic, strong)NSString *classType;

@property (nonatomic, strong)NSString *subjectType;

@property (nonatomic, strong)NSString *isFinished;

@property (nonatomic, strong)NSString *scId;

@property (nonatomic, strong)NSString *scIdStr;

@property (nonatomic, strong)NSString *useCard;

@property (nonatomic, strong)NSString *grade;

@property (nonatomic, strong)NSString *chapter;

@property (nonatomic, strong)NSString *section;

@property (nonatomic, strong)NSString *state;

@property (nonatomic, strong)NSString *examStateStr;

@property (nonatomic, strong)NSString *paperId;

@property (nonatomic, strong)NSString *timeType;

@property (nonatomic, strong)NSString *startTime;

@property (nonatomic, strong)NSString *endTime;

@property (nonatomic, strong)NSString *reverse;

@property (nonatomic, strong)NSString *start;

@property (nonatomic, strong)NSString *end;

@end
// (2)响应ID  117        (代码中的serviceId)

#pragma mark - QtiExamData

@interface QtiExamData : FBTable

@property (nonatomic, strong)NSString *examId;

@property (nonatomic, strong)NSString *examName;

@property (nonatomic, strong)NSString *creatorId;

@property (nonatomic, strong)NSString *creatorName;

@property (nonatomic, strong)NSString *body;

@property (nonatomic, strong)NSString *examType;

@property (nonatomic, strong)NSString *year;

@property (nonatomic, strong)NSString *gradeType;

@property (nonatomic, strong)NSString *classType;

@property (nonatomic, strong)NSString *subjectType;

@property (nonatomic, strong)NSString *isFinished;

@property (nonatomic, strong)NSString *useCard;

@property (nonatomic, strong)NSString *progress;

@property (nonatomic, strong)NSString *grade;

@property (nonatomic, strong)NSString *chapterId;

@property (nonatomic, strong)NSString *sectionId;

@property (nonatomic, strong)NSString *chapterName;

@property (nonatomic, strong)NSString *sectionName;

@property (nonatomic, strong)NSString *knowledge;

@property (nonatomic, strong)NSString *state;

@property (nonatomic, strong)NSString *examState;

@property (nonatomic, strong)NSString *paperIdStr;

@property (nonatomic, strong)NSString *startTime;

@property (nonatomic, strong)NSString *endTime;

@property (nonatomic, strong)NSString *createTime;

@property (nonatomic, strong)FBMutableArray<MediaData *> *media;

@property (nonatomic, strong)NSString *questionRandom;

@property (nonatomic, strong)NSString *choiseRandom;

@end


#pragma mark - QtiExamListRep

@interface QtiExamListRep : FBTable

@property (nonatomic, strong)FBMutableArray<QtiExamData *> *data;


@end

