//
//  QtiExamResultQuestion.m
//  socket-tcp
//
//  Created by sjhz on 2017/8/18.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import "QtiExamResultQuestion.h"

@implementation QtiExamResultQuestion

@end

@implementation QtiExamResultQuestionData

- (NSString *) questionId {
    
    _questionId = [self fb_getString:4 origin:_questionId];
    
    return _questionId;
    
}

- (void) add_questionId {
    
    [self fb_addString:_questionId voffset:4 offset:4];
    
    return ;
    
}

- (NSString *) rightCount {
    
    _rightCount = [self fb_getString:6 origin:_rightCount];
    
    return _rightCount;
    
}

- (void) add_rightCount {
    
    [self fb_addString:_rightCount voffset:6 offset:8];
    
    return ;
    
}

- (NSString *) wrongCount {
    
    _wrongCount = [self fb_getString:8 origin:_wrongCount];
    
    return _wrongCount;
    
}

- (void) add_wrongCount {
    
    [self fb_addString:_wrongCount voffset:8 offset:12];
    
    return ;
    
}

- (NSString *) examId {
    
    _examId = [self fb_getString:10 origin:_examId];
    
    return _examId;
    
}

- (void) add_examId {
    
    [self fb_addString:_examId voffset:10 offset:16];
    
    return ;
    
}

- (NSString *) paperId {
    
    _paperId = [self fb_getString:12 origin:_paperId];
    
    return _paperId;
    
}

- (void) add_paperId {
    
    [self fb_addString:_paperId voffset:12 offset:20];
    
    return ;
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        bb_pos = 20;
        
        origin_size = 24+bb_pos;
        
        bb = [[FBMutableData alloc]initWithLength:origin_size];
        
        [bb setInt32:bb_pos offset:0];
        
        [bb setInt32:14 offset:bb_pos];
        
        [bb setInt16:14 offset:bb_pos-[bb getInt32:bb_pos]];
        
        [bb setInt16:24 offset:bb_pos-[bb getInt32:bb_pos]+2];
        
    }
    
    return self;
    
}

@end

@implementation QtiExamResultQuestionRep

- (FBMutableArray<QtiExamResultQuestionData *> *) data {
    
    _data = [self fb_getTables:4 origin:_data className:[QtiExamResultQuestionData class]];
    
    return _data;
    
}

- (void) add_data {
    
    [self fb_addTables:_data voffset:4 offset:4];
    
    return ;
    
}

- (NSString *) classStudentCount {
    
    _classStudentCount = [self fb_getString:6 origin:_classStudentCount];
    
    return _classStudentCount;
    
}

- (void) add_classStudentCount {
    
    [self fb_addString:_classStudentCount voffset:6 offset:8];
    
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


@implementation QtiExamResultQuestionReq

- (NSString *) examId {
    
    _examId = [self fb_getString:4 origin:_examId];
    
    return _examId;
    
}

- (void) add_examId {
    
    [self fb_addString:_examId voffset:4 offset:4];
    
    return ;
    
}

- (NSString *) paperId {
    
    _paperId = [self fb_getString:6 origin:_paperId];
    
    return _paperId;
    
}

- (void) add_paperId {
    
    [self fb_addString:_paperId voffset:6 offset:8];
    
    return ;
    
}

- (NSString *) scId {
    
    _scId = [self fb_getString:8 origin:_scId];
    
    return _scId;
    
}

- (void) add_scId {
    
    [self fb_addString:_scId voffset:8 offset:12];
    
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
