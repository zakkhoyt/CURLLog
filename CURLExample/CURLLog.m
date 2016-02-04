//
//  CURLLog.m
//  CURLExample
//
//  Created by Zakk Hoyt on 2/4/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

#import "CURLLog.h"
#import "NSURLRequest+CURL.h"

@interface CURLLog ()

@end

@implementation CURLLog

+ (CURLLog*)sharedInstance
{
    static CURLLog *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [CURLLog new];
    });
    
    return instance;
}



+(void)logCURLForTask:(NSURLSessionTask*)task {
    NSURLRequest *request = task.originalRequest;
    NSURLResponse *response = task.response;
    NSInteger statusCode = ((NSHTTPURLResponse*)response).statusCode;
    [CURLLog printCURLRequest:request response:response statusCode:@(statusCode) verbose:NO];
}

+(void)logCURLForTask:(NSURLSessionTask*)task data:(NSData*)data{
    
    NSURLRequest *request = task.originalRequest;
    NSURLResponse *response = task.response;
    NSInteger statusCode = ((NSHTTPURLResponse*)response).statusCode;
    NSObject *responsePayload = [CURLLog objectForData:data];
    [CURLLog printCURLRequest:request responsePayload:responsePayload statusCode:@(statusCode) verbose:NO];
}

+(void)logCURLForTask:(NSURLSessionTask*)task error:(NSError*)error {
    NSURLRequest *request = task.originalRequest;
    NSURLResponse *response = task.response;
    NSInteger statusCode = ((NSHTTPURLResponse*)response).statusCode;
    [CURLLog printCURLRequest:request response:response error:error statusCode:@(statusCode) verbose:NO];
    
}


+(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response {
    NSInteger statusCode = ((NSHTTPURLResponse*)response).statusCode;
    [CURLLog printCURLRequest:request response:response statusCode:@(statusCode) verbose:NO];
}

+(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response data:(NSData*)data {
    NSInteger statusCode = ((NSHTTPURLResponse*)response).statusCode;
    NSObject *responsePayload = [CURLLog objectForData:data];
    [CURLLog printCURLRequest:request responsePayload:responsePayload statusCode:@(statusCode) verbose:NO];
    
}
+(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response error:(NSError*)error {
    NSInteger statusCode = ((NSHTTPURLResponse*)response).statusCode;
    [CURLLog printCURLRequest:request response:response error:error statusCode:@(statusCode) verbose:NO];
    
}



#pragma mark Private

+(NSObject*)objectForData:(NSData*)data {
    // Attempt to unpack as JSON, else fall back to a UTF8 string
    NSError *jsonError = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    if(obj == nil)  {
        NSString *objString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        return objString;
    } else {
        return obj;
    }
}

+(NSString*)stringFromOutputType:(CURLLogOutputType)outputType {
    switch (outputType) {
        case CURLLogOutputTypePretty:
            return @"python -m json.tool";
            break;
        case CURLLogOutputTypePBCopy:
            return @"pbcopy";
            break;
        case CURLLogOutputTypePrettyPBCopy:
        default:
            return @"python -m json.tool | pbcopy";
            break;
    }
}

+(void)printCURLRequest:(NSURLRequest*)request
               response:(NSURLResponse*)response
             statusCode:(NSNumber*)statusCode
                verbose:(BOOL)verbose {
    
    
    NSString *firstString = nil;
    if (statusCode.integerValue >= 200 && statusCode.integerValue < 300) {
        firstString = [NSString stringWithFormat:@"\n**************** REST SUCCESS %@ **********************", statusCode];
    } else {
        firstString = [NSString stringWithFormat:@"\n**************** REST ERROR %@ **********************", statusCode];
    }
    

    NSLog(@"%@"
          @"\n**** REQUEST ****"
          @"\n%@ | pbcopy"
          @"\n**** RESPONSE ****"
          @"\n%@"
          @"\n****************************************************",
          firstString,
          request.curl,
          response.description ? response.description : @"");
}



+(void)printCURLRequest:(NSURLRequest*)request
         responsePayload:(NSObject*)responsePayload
             statusCode:(NSNumber*)statusCode
                verbose:(BOOL)verbose {
    
    
    NSString *firstString = nil;
    if (statusCode.integerValue >= 200 && statusCode.integerValue < 300) {
        firstString = [NSString stringWithFormat:@"\n**************** REST SUCCESS %@ **********************", statusCode];
    } else {
        firstString = [NSString stringWithFormat:@"\n**************** REST ERROR %@ **********************", statusCode];
    }
    
    
    NSLog(@"%@"
          @"\n**** REQUEST ****"
          @"\n%@ | pbcopy"
          @"\n**** RESPONSE ****"
          @"\n%@"
          @"\n****************************************************",
          firstString,
          request.curl,
          responsePayload);
}


+(void)printCURLRequest:(NSURLRequest*)request
               response:(NSURLResponse*)response
                  error:(NSError*)error
             statusCode:(NSNumber*)statusCode
                verbose:(BOOL)verbose {
    
    
    NSString *firstString = nil;
    if (statusCode.integerValue >= 200 && statusCode.integerValue < 300) {
        firstString = [NSString stringWithFormat:@"\n**************** REST SUCCESS %@ **********************", statusCode];
    } else {
        firstString = [NSString stringWithFormat:@"\n**************** REST ERROR %@ **********************", statusCode];
    }
    
    
    NSLog(@"%@"
          @"\n**** REQUEST ****"
          @"\n%@ | pbcopy"
          @"\n**** ERROR ****"
          @"\n%@"
          @"\n****************************************************",
          firstString,
          request.curl,
          error.description);
}
@end
