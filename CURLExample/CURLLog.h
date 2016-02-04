//
//  CURLLog.h
//  CURLExample
//
//  Created by Zakk Hoyt on 2/4/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//
//  This class will print CURL representations of your web calls along with the response. The response is intended for text type responses (json, xml, strings)


#import <Foundation/Foundation.h>

@interface CURLLog : NSObject

typedef NS_ENUM(NSUInteger, CURLLogOutputType) {
    CURLLogOutputTypeNone,
    CURLLogOutputTypePrettyPBCopy,
    CURLLogOutputTypePretty,
    CURLLogOutputTypePBCopy,
};


@property (nonatomic) CURLLogOutputType outputType;
+ (CURLLog*)sharedInstance;

-(void)logCURLForTask:(NSURLSessionTask*)task;
-(void)logCURLForTask:(NSURLSessionTask*)task payload:(id)payload;
-(void)logCURLForTask:(NSURLSessionTask*)task error:(NSError*)error;

-(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response;
-(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response payload:(id)payload;
-(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response error:(NSError*)error;

@end
