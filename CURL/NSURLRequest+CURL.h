//
//  NSURLRequest+AFCurlRequest.h
//  AFCurlRequest
//
//  Created by Alan Francis on 21/12/2012.
//  Copyright (c) 2012 Alan Francis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (CURL)
- (NSString*)curl;
- (NSString*)curlVerbose:(BOOL)verbose;
@end
