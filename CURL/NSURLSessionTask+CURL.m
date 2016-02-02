//
//  NSURLSessionTask+CURL.m
//  RedHenBaby
//
//  Created by Zakk Hoyt on 2/1/16.
//  Copyright © 2016 Willowtree Apps. All rights reserved.
//

#import "NSURLSessionTask+CURL.h"
#import "NSURLRequest+curl.h"

@implementation NSURLSessionTask (CURL)


#pragma mark Private methods

-(void)logCURLVerbose:(BOOL)verbose{
    
#ifdef DEBUG
    NSInteger statusCode = ((NSHTTPURLResponse*)self.response).statusCode;
    
    NSString *firstString = nil;
    if (statusCode >= 200 && statusCode < 300) {
        firstString = [NSString stringWithFormat:@"\n**************** REST SUCCESS %ld **********************", statusCode];
    } else {
        firstString = [NSString stringWithFormat:@"\n**************** REST ERROR %ld **********************", statusCode];
    }
    
    if (verbose) {
        NSLog(@"%@"
              @"\n**** REQUEST ****"
              @"\n%@ | pbcopy"
              @"\n**** RESPONSE ****"
              @"\n%@"
              @"\n****************************************************",
              firstString,
              self.originalRequest.curl,
              self.response.description ? self.response.description : @"");
    } else {
        
        
        NSLog(@"%@"
              @"\n**** REQUEST ****"
              @"\n%@ | pbcopy"
              @"\n****************************************************",
              firstString,
              self.originalRequest.curl);
    }
#endif
    
}



#pragma mark Public methods


-(void)logCURL{
    [self logCURLVerbose:NO];
}

-(void)logCURLVerbose:(BOOL)verbose{
    
#ifdef DEBUG
    NSInteger statusCode = ((NSHTTPURLResponse*)self.response).statusCode;
    
    NSString *firstString = nil;
    if (statusCode >= 200 && statusCode < 300) {
        firstString = [NSString stringWithFormat:@"\n**************** REST SUCCESS %ld **********************", statusCode];
    } else {
        firstString = [NSString stringWithFormat:@"\n**************** REST ERROR %ld **********************", statusCode];
    }
    
    if (verbose) {
        NSLog(@"%@"
              @"\n**** REQUEST ****"
              @"\n%@ | pbcopy"
              @"\n**** RESPONSE ****"
              @"\n%@"
              @"\n****************************************************",
              firstString,
              self.originalRequest.curl,
              self.response.description ? self.response.description : @"");
    } else {
        

        NSLog(@"%@"
              @"\n**** REQUEST ****"
              @"\n%@ | pbcopy"
              @"\n****************************************************",
              firstString,
              self.originalRequest.curl);
    }
#endif

}


-(void)logCURLWithData:(NSData*)data {
#ifdef DEBUG
    NSInteger statusCode = ((NSHTTPURLResponse*)self.response).statusCode;
    NSString *firstString = nil;
    if (statusCode >= 200 && statusCode < 300) {
        firstString = [NSString stringWithFormat:@"\n**************** REST SUCCESS %ld **********************", statusCode];
    } else {
        firstString = [NSString stringWithFormat:@"\n**************** REST ERROR %ld **********************", statusCode];
    }
    
    NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@"
          @"\n**** REQUEST ****"
          @"\n%@ | pbcopy"
          @"\n**** RESPONSE ****"
          @"\n%@"
          @"\n****************************************************",
          firstString,
          self.originalRequest.curl,
          dataString);
#endif
    
}

-(void)logCURLWithDictionary:(NSDictionary*)dictionary{
#ifdef DEBUG
    NSInteger statusCode = ((NSHTTPURLResponse*)self.response).statusCode;
    NSString *firstString = nil;
    if (statusCode >= 200 && statusCode < 300) {
        firstString = [NSString stringWithFormat:@"\n**************** REST SUCCESS %ld **********************", statusCode];
    } else {
        firstString = [NSString stringWithFormat:@"\n**************** REST ERROR %ld **********************", statusCode];
    }
    
    NSString *dataString = dictionary.description;
    
    NSLog(@"%@"
          @"\n**** REQUEST ****"
          @"\n%@ | pbcopy"
          @"\n**** RESPONSE ****"
          @"\n%@"
          @"\n****************************************************",
          firstString,
          self.originalRequest.curl,
          dataString);
#endif
    
}

-(void)logCURLWithError:(NSError*)error {
#ifdef DEBUG
    
    NSInteger statusCode = ((NSHTTPURLResponse*)self.response).statusCode;
    NSString *firstString = [NSString stringWithFormat:@"\n**************** REST ERROR %ld **********************", statusCode];
    
    NSLog(@"%@"
          @"\n**** REQUEST ****"
          @"\n%@ | pbcopy"
          @"\n**** RESPONSE ****"
          @"\n%@"
          @"\n**** ERROR ****"
          @"\n%@"
          @"\n****************************************************",
          firstString,
          self.originalRequest.curl,
          self.response.description ? self.response.description : @"",
          error.localizedDescription);
    
#endif
    
}



@end
