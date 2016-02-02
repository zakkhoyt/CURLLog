//
//  NSURLSessionTask+CURL.h
//  RedHenBaby
//
//  Created by Zakk Hoyt on 2/1/16.
//  Copyright © 2016 Willowtree Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLSessionTask (CURL)
-(void)logCURL;
-(void)logCURLVerbose:(BOOL)verbose;
-(void)logCURLWithData:(NSData*)data;
-(void)logCURLWithDictionary:(NSDictionary*)dictionary;
-(void)logCURLWithError:(NSError*)error;


@end


