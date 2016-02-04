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
    CURLLogOutputTypePrettyPBCopy,
    CURLLogOutputTypePretty,
    CURLLogOutputTypePBCopy,
};


@property (nonatomic) CURLLogOutputType outputType;
+ (CURLLog*)sharedInstance;

+(void)logCURLForTask:(NSURLSessionTask*)task;
+(void)logCURLForTask:(NSURLSessionTask*)task data:(NSData*)data;
+(void)logCURLForTask:(NSURLSessionTask*)task error:(NSError*)error;

+(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response;
+(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response data:(NSData*)data;
+(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response error:(NSError*)error;

@end
