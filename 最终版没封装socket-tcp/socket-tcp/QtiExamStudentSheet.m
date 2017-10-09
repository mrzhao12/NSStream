//
//  QtiExamStudentSheet.m
//  socket-tcp
//
//  Created by sjhz on 2017/8/21.
//  Copyright © 2017年 sjhz. All rights reserved.
//

#import "QtiExamStudentSheet.h"

@implementation QtiExamStudentSheet

@end


@implementation QtiExamStudentSheetRep

- (FBMutableArray<QtiExamStudentSheetData *> *) data {
    
    _data = [self fb_getTables:4 origin:_data className:[QtiExamStudentSheetData class]];
    
    return _data;
    
}

- (void) add_data {
    
    [self fb_addTables:_data voffset:4 offset:4];
    
    return ;
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        bb_pos = 12;
        
        origin_size = 8+bb_pos;
        
        bb = [[FBMutableData alloc]initWithLength:origin_size];
        
        [bb setInt32:bb_pos offset:0];
        
        [bb setInt32:6 offset:bb_pos];
        
        [bb setInt16:6 offset:bb_pos-[bb getInt32:bb_pos]];
        
        [bb setInt16:8 offset:bb_pos-[bb getInt32:bb_pos]+2];
        
    }
    
    return self;
    
}

@end

@implementation QtiExamStudentSheetData

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

- (NSString *) questionId {
    
    _questionId = [self fb_getString:8 origin:_questionId];
    
    return _questionId;
    
}

- (void) add_questionId {
    
    [self fb_addString:_questionId voffset:8 offset:12];
    
    return ;
    
}

- (NSString *) questionType {
    
    _questionType = [self fb_getString:10 origin:_questionType];
    
    return _questionType;
    
}

- (void) add_questionType {
    
    [self fb_addString:_questionType voffset:10 offset:16];
    
    return ;
    
}

- (NSString *) questionNo {
    
    _questionNo = [self fb_getString:12 origin:_questionNo];
    
    return _questionNo;
    
}

- (void) add_questionNo {
    
    [self fb_addString:_questionNo voffset:12 offset:20];
    
    return ;
    
}

- (NSString *) studentId {
    
    _studentId = [self fb_getString:14 origin:_studentId];
    
    return _studentId;
    
}

- (void) add_studentId {
    
    [self fb_addString:_studentId voffset:14 offset:24];
    
    return ;
    
}

- (NSString *) studentName {
    
    _studentName = [self fb_getString:16 origin:_studentName];
    
    return _studentName;
    
}

- (void) add_studentName {
    
    [self fb_addString:_studentName voffset:16 offset:28];
    
    return ;
    
}

- (NSString *) studentLoginName {
    
    _studentLoginName = [self fb_getString:18 origin:_studentLoginName];
    
    return _studentLoginName;
    
}

- (void) add_studentLoginName {
    
    [self fb_addString:_studentLoginName voffset:18 offset:32];
    
    return ;
    
}

- (NSString *) studentClass {
    
    _studentClass = [self fb_getString:20 origin:_studentClass];
    
    return _studentClass;
    
}

- (void) add_studentClass {
    
    [self fb_addString:_studentClass voffset:20 offset:36];
    
    return ;
    
}

- (NSString *) result {
    
    _result = [self fb_getString:22 origin:_result];
    
    return _result;
    
}

- (void) add_result {
    
    [self fb_addString:_result voffset:22 offset:40];
    
    return ;
    
}

- (NSString *) rightOrWrong {
    
    _rightOrWrong = [self fb_getString:24 origin:_rightOrWrong];
    
    return _rightOrWrong;
    
}

- (void) add_rightOrWrong {
    
    [self fb_addString:_rightOrWrong voffset:24 offset:44];
    
    return ;
    
}

- (NSString *) sheetUrl {
    
    _sheetUrl = [self fb_getString:26 origin:_sheetUrl];
    
    return _sheetUrl;
    
}

- (void) add_sheetUrl {
    
    [self fb_addString:_sheetUrl voffset:26 offset:48];
    
    return ;
    
}

- (NSString *) sheetUrlDraw {
    
    _sheetUrlDraw = [self fb_getString:28 origin:_sheetUrlDraw];
    
    return _sheetUrlDraw;
    
}

- (void) add_sheetUrlDraw {
    
    [self fb_addString:_sheetUrlDraw voffset:28 offset:52];
    
    return ;
    
}

- (NSString *) wholeSheetUrl {
    
    _wholeSheetUrl = [self fb_getString:30 origin:_wholeSheetUrl];
    
    return _wholeSheetUrl;
    
}

- (void) add_wholeSheetUrl {
    
    [self fb_addString:_wholeSheetUrl voffset:30 offset:56];
    
    return ;
    
}

- (NSString *) isFav {
    
    _isFav = [self fb_getString:32 origin:_isFav];
    
    return _isFav;
    
}

- (void) add_isFav {
    
    [self fb_addString:_isFav voffset:32 offset:60];
    
    return ;
    
}

- (NSString *) isBest {
    
    _isBest = [self fb_getString:34 origin:_isBest];
    
    return _isBest;
    
}

- (void) add_isBest {
    
    [self fb_addString:_isBest voffset:34 offset:64];
    
    return ;
    
}

- (NSString *) voiceUrl {
    
    _voiceUrl = [self fb_getString:36 origin:_voiceUrl];
    
    return _voiceUrl;
    
}

- (void) add_voiceUrl {
    
    [self fb_addString:_voiceUrl voffset:36 offset:68];
    
    return ;
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        bb_pos = 44;
        
        origin_size = 72+bb_pos;
        
        bb = [[FBMutableData alloc]initWithLength:origin_size];
        
        [bb setInt32:bb_pos offset:0];
        
        [bb setInt32:38 offset:bb_pos];
        
        [bb setInt16:38 offset:bb_pos-[bb getInt32:bb_pos]];
        
        [bb setInt16:72 offset:bb_pos-[bb getInt32:bb_pos]+2];
        
    }
    
    return self;
    
}

@end



@implementation QtiExamStudentSheetReq

- (NSString *) examId {
    
    _examId = [self fb_getString:4 origin:_examId];
    
    return _examId;
    
}

- (void) add_examId {
    
    [self fb_addString:_examId voffset:4 offset:4];
    
    return ;
    
}

- (NSString *) scId {
    
    _scId = [self fb_getString:6 origin:_scId];
    
    return _scId;
    
}

- (void) add_scId {
    
    [self fb_addString:_scId voffset:6 offset:8];
    
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
