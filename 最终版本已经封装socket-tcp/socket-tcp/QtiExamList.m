//
//  QtiExamList.m
//  WorkAssistant
//
//  Created by  壹件事 on 2017/7/5.
//  Copyright © 2017年  壹件事. All rights reserved.
//

#import "QtiExamList.h"

@implementation MediaData

- (NSString *) title {
    
    _title = [self fb_getString:4 origin:_title];
    
    return _title;
    
}

- (void) add_title {
    
    [self fb_addString:_title voffset:4 offset:4];
    
    return ;
    
}

- (NSString *) mediaUrl {
    
    _mediaUrl = [self fb_getString:6 origin:_mediaUrl];
    
    return _mediaUrl;
    
}

- (void) add_mediaUrl {
    
    [self fb_addString:_mediaUrl voffset:6 offset:8];
    
    return ;
    
}

- (NSString *) coverUrl {
    
    _coverUrl = [self fb_getString:8 origin:_coverUrl];
    
    return _coverUrl;
    
}

- (void) add_coverUrl {
    
    [self fb_addString:_coverUrl voffset:8 offset:12];
    
    return ;
    
}

- (NSString *) duration {
    
    _duration = [self fb_getString:10 origin:_duration];
    
    return _duration;
    
}

- (void) add_duration {
    
    [self fb_addString:_duration voffset:10 offset:16];
    
    return ;
    
}

- (NSString *) convertState {
    
    _convertState = [self fb_getString:12 origin:_convertState];
    
    return _convertState;
    
}

- (void) add_convertState {
    
    [self fb_addString:_convertState voffset:12 offset:20];
    
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

@implementation QtiExamList

@end

#pragma mark - QtiExamListReq

@implementation QtiExamListReq

- (NSString *) examId {
    
    _examId = [self fb_getString:4 origin:_examId];
    
    return _examId;
    
}

- (void) add_examId {
    
    [self fb_addString:_examId voffset:4 offset:4];
    
    return ;
    
}

- (NSString *) examName {
    
    _examName = [self fb_getString:6 origin:_examName];
    
    return _examName;
    
}

- (void) add_examName {
    
    [self fb_addString:_examName voffset:6 offset:8];
    
    return ;
    
}

- (NSString *) creatorId {
    
    _creatorId = [self fb_getString:8 origin:_creatorId];
    
    return _creatorId;
    
}

- (void) add_creatorId {
    
    [self fb_addString:_creatorId voffset:8 offset:12];
    
    return ;
    
}

- (NSString *) examType {
    
    _examType = [self fb_getString:10 origin:_examType];
    
    return _examType;
    
}

- (void) add_examType {
    
    [self fb_addString:_examType voffset:10 offset:16];
    
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

- (NSString *) gradeType {
    
    _gradeType = [self fb_getString:14 origin:_gradeType];
    
    return _gradeType;
    
}

- (void) add_gradeType {
    
    [self fb_addString:_gradeType voffset:14 offset:24];
    
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

- (NSString *) subjectType {
    
    _subjectType = [self fb_getString:18 origin:_subjectType];
    
    return _subjectType;
    
}

- (void) add_subjectType {
    
    [self fb_addString:_subjectType voffset:18 offset:32];
    
    return ;
    
}

- (NSString *) isFinished {
    
    _isFinished = [self fb_getString:20 origin:_isFinished];
    
    return _isFinished;
    
}

- (void) add_isFinished {
    
    [self fb_addString:_isFinished voffset:20 offset:36];
    
    return ;
    
}

- (NSString *) scId {
    
    _scId = [self fb_getString:22 origin:_scId];
    
    return _scId;
    
}

- (void) add_scId {
    
    [self fb_addString:_scId voffset:22 offset:40];
    
    return ;
    
}

- (NSString *) scIdStr {
    
    _scIdStr = [self fb_getString:24 origin:_scIdStr];
    
    return _scIdStr;
    
}

- (void) add_scIdStr {
    
    [self fb_addString:_scIdStr voffset:24 offset:44];
    
    return ;
    
}

- (NSString *) useCard {
    
    _useCard = [self fb_getString:26 origin:_useCard];
    
    return _useCard;
    
}

- (void) add_useCard {
    
    [self fb_addString:_useCard voffset:26 offset:48];
    
    return ;
    
}

- (NSString *) grade {
    
    _grade = [self fb_getString:28 origin:_grade];
    
    return _grade;
    
}

- (void) add_grade {
    
    [self fb_addString:_grade voffset:28 offset:52];
    
    return ;
    
}

- (NSString *) chapter {
    
    _chapter = [self fb_getString:30 origin:_chapter];
    
    return _chapter;
    
}

- (void) add_chapter {
    
    [self fb_addString:_chapter voffset:30 offset:56];
    
    return ;
    
}

- (NSString *) section {
    
    _section = [self fb_getString:32 origin:_section];
    
    return _section;
    
}

- (void) add_section {
    
    [self fb_addString:_section voffset:32 offset:60];
    
    return ;
    
}

- (NSString *) state {
    
    _state = [self fb_getString:34 origin:_state];
    
    return _state;
    
}

- (void) add_state {
    
    [self fb_addString:_state voffset:34 offset:64];
    
    return ;
    
}

- (NSString *) examStateStr {
    
    _examStateStr = [self fb_getString:36 origin:_examStateStr];
    
    return _examStateStr;
    
}

- (void) add_examStateStr {
    
    [self fb_addString:_examStateStr voffset:36 offset:68];
    
    return ;
    
}

- (NSString *) paperId {
    
    _paperId = [self fb_getString:38 origin:_paperId];
    
    return _paperId;
    
}

- (void) add_paperId {
    
    [self fb_addString:_paperId voffset:38 offset:72];
    
    return ;
    
}

- (NSString *) timeType {
    
    _timeType = [self fb_getString:40 origin:_timeType];
    
    return _timeType;
    
}

- (void) add_timeType {
    
    [self fb_addString:_timeType voffset:40 offset:76];
    
    return ;
    
}

- (NSString *) startTime {
    
    _startTime = [self fb_getString:42 origin:_startTime];
    
    return _startTime;
    
}

- (void) add_startTime {
    
    [self fb_addString:_startTime voffset:42 offset:80];
    
    return ;
    
}

- (NSString *) endTime {
    
    _endTime = [self fb_getString:44 origin:_endTime];
    
    return _endTime;
    
}

- (void) add_endTime {
    
    [self fb_addString:_endTime voffset:44 offset:84];
    
    return ;
    
}

- (NSString *) reverse {
    
    _reverse = [self fb_getString:46 origin:_reverse];
    
    return _reverse;
    
}

- (void) add_reverse {
    
    [self fb_addString:_reverse voffset:46 offset:88];
    
    return ;
    
}

- (NSString *) start {
    
    _start = [self fb_getString:48 origin:_start];
    
    return _start;
    
}

- (void) add_start {
    
    [self fb_addString:_start voffset:48 offset:92];
    
    return ;
    
}

- (NSString *) end {
    
    _end = [self fb_getString:50 origin:_end];
    
    return _end;
    
}

- (void) add_end {
    
    [self fb_addString:_end voffset:50 offset:96];
    
    return ;
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        bb_pos = 58;
        
        origin_size = 100+bb_pos;
        
        bb = [[FBMutableData alloc]initWithLength:origin_size];
        
        [bb setInt32:bb_pos offset:0];
        
        [bb setInt32:52 offset:bb_pos];
        
        [bb setInt16:52 offset:bb_pos-[bb getInt32:bb_pos]];
        
        [bb setInt16:100 offset:bb_pos-[bb getInt32:bb_pos]+2];
        
    }
    
    return self;
    
}

//- (NSString *)description
//{
//    NSString *retStr = [NSString stringWithFormat:@"examId=%@&examName=%@&creatorId=%@&examType=%@&year=%@&gradeType=%@&classType=%@&subjectType=%@&isFinished=%@&scId=%@&scIdStr=%@&useCard=%@&grade=%@&chapter=%@&section=%@&state=%@&examStateStr=%@&paperId=%@&timeType=%@&startTime=%@&endTime=%@&reverse=%@&start=%@&end=%@",self.examId?:@"",self.examName?:@"",self.creatorId?:@"",self.examType?:@"",self.year?:@"",self.gradeType?:@"",self.classType?:@"",self.subjectType?:@"",self.isFinished?:@"",self.scId?:@"",self.scIdStr?:@"",self.useCard?:@"",self.grade?:@"",self.chapter?:@"",self.section?:@"",self.state?:@"",self.examStateStr?:@"",self.paperId?:@"",self.timeType?:@"",self.startTime?:@"",self.endTime?:@"",self.reverse?:@"",self.start?:@"",self.end?:@""];
//    return retStr;
//}

@end

#pragma mark - QtiExamData

@implementation QtiExamData

- (NSString *) examId {
    
    _examId = [self fb_getString:4 origin:_examId];
    
    return _examId;
    
}

- (void) add_examId {
    
    [self fb_addString:_examId voffset:4 offset:4];
    
    return ;
    
}

- (NSString *) examName {
    
    _examName = [self fb_getString:6 origin:_examName];
    
    return _examName;
    
}

- (void) add_examName {
    
    [self fb_addString:_examName voffset:6 offset:8];
    
    return ;
    
}

- (NSString *) creatorId {
    
    _creatorId = [self fb_getString:8 origin:_creatorId];
    
    return _creatorId;
    
}

- (void) add_creatorId {
    
    [self fb_addString:_creatorId voffset:8 offset:12];
    
    return ;
    
}

- (NSString *) creatorName {
    
    _creatorName = [self fb_getString:10 origin:_creatorName];
    
    return _creatorName;
    
}

- (void) add_creatorName {
    
    [self fb_addString:_creatorName voffset:10 offset:16];
    
    return ;
    
}

- (NSString *) body {
    
    _body = [self fb_getString:12 origin:_body];
    
    return _body;
    
}

- (void) add_body {
    
    [self fb_addString:_body voffset:12 offset:20];
    
    return ;
    
}

- (NSString *) examType {
    
    _examType = [self fb_getString:14 origin:_examType];
    
    return _examType;
    
}

- (void) add_examType {
    
    [self fb_addString:_examType voffset:14 offset:24];
    
    return ;
    
}

- (NSString *) year {
    
    _year = [self fb_getString:16 origin:_year];
    
    return _year;
    
}

- (void) add_year {
    
    [self fb_addString:_year voffset:16 offset:28];
    
    return ;
    
}

- (NSString *) gradeType {
    
    _gradeType = [self fb_getString:18 origin:_gradeType];
    
    return _gradeType;
    
}

- (void) add_gradeType {
    
    [self fb_addString:_gradeType voffset:18 offset:32];
    
    return ;
    
}

- (NSString *) classType {
    
    _classType = [self fb_getString:20 origin:_classType];
    
    return _classType;
    
}

- (void) add_classType {
    
    [self fb_addString:_classType voffset:20 offset:36];
    
    return ;
    
}

- (NSString *) subjectType {
    
    _subjectType = [self fb_getString:22 origin:_subjectType];
    
    return _subjectType;
    
}

- (void) add_subjectType {
    
    [self fb_addString:_subjectType voffset:22 offset:40];
    
    return ;
    
}

- (NSString *) isFinished {
    
    _isFinished = [self fb_getString:24 origin:_isFinished];
    
    return _isFinished;
    
}

- (void) add_isFinished {
    
    [self fb_addString:_isFinished voffset:24 offset:44];
    
    return ;
    
}

- (NSString *) useCard {
    
    _useCard = [self fb_getString:26 origin:_useCard];
    
    return _useCard;
    
}

- (void) add_useCard {
    
    [self fb_addString:_useCard voffset:26 offset:48];
    
    return ;
    
}

- (NSString *) progress {
    
    _progress = [self fb_getString:28 origin:_progress];
    
    return _progress;
    
}

- (void) add_progress {
    
    [self fb_addString:_progress voffset:28 offset:52];
    
    return ;
    
}

- (NSString *) grade {
    
    _grade = [self fb_getString:30 origin:_grade];
    
    return _grade;
    
}

- (void) add_grade {
    
    [self fb_addString:_grade voffset:30 offset:56];
    
    return ;
    
}

- (NSString *) chapterId {
    
    _chapterId = [self fb_getString:32 origin:_chapterId];
    
    return _chapterId;
    
}

- (void) add_chapterId {
    
    [self fb_addString:_chapterId voffset:32 offset:60];
    
    return ;
    
}

- (NSString *) sectionId {
    
    _sectionId = [self fb_getString:34 origin:_sectionId];
    
    return _sectionId;
    
}

- (void) add_sectionId {
    
    [self fb_addString:_sectionId voffset:34 offset:64];
    
    return ;
    
}

- (NSString *) chapterName {
    
    _chapterName = [self fb_getString:36 origin:_chapterName];
    
    return _chapterName;
    
}

- (void) add_chapterName {
    
    [self fb_addString:_chapterName voffset:36 offset:68];
    
    return ;
    
}

- (NSString *) sectionName {
    
    _sectionName = [self fb_getString:38 origin:_sectionName];
    
    return _sectionName;
    
}

- (void) add_sectionName {
    
    [self fb_addString:_sectionName voffset:38 offset:72];
    
    return ;
    
}

- (NSString *) knowledge {
    
    _knowledge = [self fb_getString:40 origin:_knowledge];
    
    return _knowledge;
    
}

- (void) add_knowledge {
    
    [self fb_addString:_knowledge voffset:40 offset:76];
    
    return ;
    
}

- (NSString *) state {
    
    _state = [self fb_getString:42 origin:_state];
    
    return _state;
    
}

- (void) add_state {
    
    [self fb_addString:_state voffset:42 offset:80];
    
    return ;
    
}

- (NSString *) examState {
    
    _examState = [self fb_getString:44 origin:_examState];
    
    return _examState;
    
}

- (void) add_examState {
    
    [self fb_addString:_examState voffset:44 offset:84];
    
    return ;
    
}

- (NSString *) paperIdStr {
    
    _paperIdStr = [self fb_getString:46 origin:_paperIdStr];
    
    return _paperIdStr;
    
}

- (void) add_paperIdStr {
    
    [self fb_addString:_paperIdStr voffset:46 offset:88];
    
    return ;
    
}

- (NSString *) startTime {
    
    _startTime = [self fb_getString:48 origin:_startTime];
    
    return _startTime;
    
}

- (void) add_startTime {
    
    [self fb_addString:_startTime voffset:48 offset:92];
    
    return ;
    
}

- (NSString *) endTime {
    
    _endTime = [self fb_getString:50 origin:_endTime];
    
    return _endTime;
    
}

- (void) add_endTime {
    
    [self fb_addString:_endTime voffset:50 offset:96];
    
    return ;
    
}

- (NSString *) createTime {
    
    _createTime = [self fb_getString:52 origin:_createTime];
    
    return _createTime;
    
}

- (void) add_createTime {
    
    [self fb_addString:_createTime voffset:52 offset:100];
    
    return ;
    
}

- (FBMutableArray<MediaData *> *) media {
    
    _media = [self fb_getTables:54 origin:_media className:[MediaData class]];
    
    return _media;
    
}

- (void) add_media {
    
    [self fb_addTables:_media voffset:54 offset:104];
    
    return ;
    
}

- (NSString *) questionRandom {
    
    _questionRandom = [self fb_getString:56 origin:_questionRandom];
    
    return _questionRandom;
    
}

- (void) add_questionRandom {
    
    [self fb_addString:_questionRandom voffset:56 offset:108];
    
    return ;
    
}

- (NSString *) choiseRandom {
    
    _choiseRandom = [self fb_getString:58 origin:_choiseRandom];
    
    return _choiseRandom;
    
}

- (void) add_choiseRandom {
    
    [self fb_addString:_choiseRandom voffset:58 offset:112];
    
    return ;
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        bb_pos = 66;
        
        origin_size = 116+bb_pos;
        
        bb = [[FBMutableData alloc]initWithLength:origin_size];
        
        [bb setInt32:bb_pos offset:0];
        
        [bb setInt32:60 offset:bb_pos];
        
        [bb setInt16:60 offset:bb_pos-[bb getInt32:bb_pos]];
        
        [bb setInt16:116 offset:bb_pos-[bb getInt32:bb_pos]+2];
        
    }
    
    return self;
    
}

@end

#pragma mark - QtiExamListRep

@implementation QtiExamListRep

- (FBMutableArray<QtiExamData *> *) data {
    
    _data = [self fb_getTables:4 origin:_data className:[QtiExamData class]];
    
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
