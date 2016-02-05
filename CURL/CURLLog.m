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

- (instancetype)init {
    self = [super init];
    if (self) {
        _outputType = CURLLogOutputTypePrettyPBCopy;
    }
    return self;
}


-(void)logCURLForTask:(NSURLSessionTask*)task {
    NSURLRequest *request = task.originalRequest;
    NSURLResponse *response = task.response;
    NSInteger statusCode = ((NSHTTPURLResponse*)response).statusCode;
    [self printCURLRequest:request response:response statusCode:@(statusCode) verbose:NO];
}


-(void)logCURLForTask:(NSURLSessionTask*)task payload:(id)payload {
    
    
    NSURLRequest *request = task.originalRequest;
    NSURLResponse *response = task.response;
    NSInteger statusCode = ((NSHTTPURLResponse*)response).statusCode;
    
    if([payload isKindOfClass:[NSData class]]) {
        NSData *data = payload;
        NSObject *responsePayload = [self objectForData:data];
        [self printCURLRequest:request responsePayload:responsePayload statusCode:@(statusCode) verbose:NO];
    } else if([payload isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = payload;
        [self printCURLRequest:request responsePayload:dictionary statusCode:@(statusCode) verbose:NO];
    } else if([payload isKindOfClass:[NSArray class]]) {
        NSArray *array = payload;
        [self printCURLRequest:request responsePayload:array statusCode:@(statusCode) verbose:NO];
    } else if([payload isKindOfClass:[NSString class]]) {
        NSArray *string = payload;
        [self printCURLRequest:request responsePayload:string statusCode:@(statusCode) verbose:NO];
    } else {
        [self printCURLRequest:request response:response statusCode:@(statusCode) verbose:NO];
    }
}



-(void)logCURLForTask:(NSURLSessionTask*)task error:(NSError*)error {
    NSURLRequest *request = task.originalRequest;
    NSURLResponse *response = task.response;
    NSInteger statusCode = ((NSHTTPURLResponse*)response).statusCode;
    [self printCURLRequest:request response:response error:error statusCode:@(statusCode) verbose:NO];
    
}


-(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response {
    NSInteger statusCode = ((NSHTTPURLResponse*)response).statusCode;
    [self printCURLRequest:request response:response statusCode:@(statusCode) verbose:NO];
}


-(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response payload:(id)payload {
    NSInteger statusCode = ((NSHTTPURLResponse*)response).statusCode;
    
    if([payload isKindOfClass:[NSData class]]) {
        NSData *data = payload;
        NSObject *responsePayload = [self objectForData:data];
        [self printCURLRequest:request responsePayload:responsePayload statusCode:@(statusCode) verbose:NO];
    } else if([payload isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = payload;
        [self printCURLRequest:request responsePayload:dictionary statusCode:@(statusCode) verbose:NO];
    } else if([payload isKindOfClass:[NSArray class]]) {
        NSArray *array = payload;
        [self printCURLRequest:request responsePayload:array statusCode:@(statusCode) verbose:NO];
    } else if([payload isKindOfClass:[NSString class]]) {
        NSArray *string = payload;
        [self printCURLRequest:request responsePayload:string statusCode:@(statusCode) verbose:NO];
    } else {
        [self printCURLRequest:request response:response statusCode:@(statusCode) verbose:NO];
    }
    
}

-(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response error:(NSError*)error {
    NSInteger statusCode = ((NSHTTPURLResponse*)response).statusCode;
    [self printCURLRequest:request response:response error:error statusCode:@(statusCode) verbose:NO];
    
}



#pragma mark Private

-(NSObject*)objectForData:(NSData*)data {
    // Attempt to unpack as JSON, else fall back to a UTF8 string
    NSError *jsonError = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    if(obj == nil)  {
        NSString *objString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        if(objString) {
            return objString;
        }
    } else {
        return obj;
    }
    
    return data;
}

-(NSString*)stringFromOutputType:(CURLLogOutputType)outputType {
    switch (outputType) {
        case CURLLogOutputTypeNone:
            return @"";
            break;
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

-(void)printCURLRequest:(NSURLRequest*)request
               response:(NSURLResponse*)response
             statusCode:(NSNumber*)statusCode
                verbose:(BOOL)verbose {
    
    
    NSString *firstString = nil;
    if (statusCode.integerValue >= 200 && statusCode.integerValue < 300) {
        firstString = [NSString stringWithFormat:@"\n**************** HTTP SUCCESS %@ **********************", statusCode];
    } else {
        firstString = [NSString stringWithFormat:@"\n**************** HTTP ERROR %@ **********************", statusCode];
    }
    
    
    NSLog(@"%@"
          @"\n**** REQUEST ****"
          @"\n%@ | %@"
          @"\n**** RESPONSE ****"
          @"\n%@"
          @"\n****************************************************",
          firstString,
          request.curl,
          [self stringFromOutputType:_outputType],
          response.description ? response.description : @"");
}



-(void)printCURLRequest:(NSURLRequest*)request
        responsePayload:(NSObject*)responsePayload
             statusCode:(NSNumber*)statusCode
                verbose:(BOOL)verbose {
    
    
    NSString *firstString = nil;
    if (statusCode.integerValue >= 200 && statusCode.integerValue < 300) {
        firstString = [NSString stringWithFormat:@"\n**************** HTTP SUCCESS %@ **********************", statusCode];
    } else {
        firstString = [NSString stringWithFormat:@"\n**************** HTTP ERROR %@ **********************", statusCode];
    }
    
    
    NSLog(@"%@"
          @"\n**** REQUEST ****"
          @"\n%@ | %@"
          @"\n**** RESPONSE ****"
          @"\n%@"
          @"\n****************************************************",
          firstString,
          request.curl,
          [self stringFromOutputType:_outputType],
          responsePayload);
}


-(void)printCURLRequest:(NSURLRequest*)request
               response:(NSURLResponse*)response
                  error:(NSError*)error
             statusCode:(NSNumber*)statusCode
                verbose:(BOOL)verbose {
    
    
    NSString *firstString = nil;
    if (statusCode.integerValue >= 200 && statusCode.integerValue < 300) {
        firstString = [NSString stringWithFormat:@"\n**************** HTTP SUCCESS %@ **********************", statusCode];
    } else {
        firstString = [NSString stringWithFormat:@"\n**************** HTTP ERROR %@ **********************", statusCode];
    }
    
    
    NSLog(@"%@"
          @"\n**** REQUEST ****"
          @"\n%@ | %@"
          @"\n**** ERROR ****"
          @"\n%@"
          @"\n****************************************************",
          firstString,
          request.curl,
          [self stringFromOutputType:_outputType],
          error.description);
}
@end
