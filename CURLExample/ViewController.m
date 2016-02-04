//
//  ViewController.m
//  CURLExample
//
//  Created by Zakk Hoyt on 2/2/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//
//  An example of how to use CURLLog with NSURLSession and NSURLConnection classes
//

#import "ViewController.h"
#import "CURLLog.h"

@interface ViewController ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _session = [NSURLSession sharedSession];
}


#pragma mark IBAction

- (IBAction)connectionErrorButtonAction:(id)sender {
    NSURL *url = [NSURL URLWithString:[self badURLString]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        handleURLConnectionCallback(request, response, data, connectionError);
    }];
}

- (IBAction)connectionSuccessButtonAction:(id)sender {
    NSURL *url = [NSURL URLWithString:[self goodURLString]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        handleURLConnectionCallback(request, response, data, connectionError);
    }];

}


- (IBAction)sessionErrorButtonAction:(id)sender {
    NSURL *url = [NSURL URLWithString:[self badURLString]];
    
    // Must use __block go get variable to stick around for the block call
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    __block NSURLSessionDataTask *articlesTask = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        handleURLSessionCallback(articlesTask, data, response, error);
    }];
    
    
    [articlesTask resume];
}


- (IBAction)sessionSuccessButtonAction:(id)sender {
    NSURL *url = [NSURL URLWithString:[self goodURLString]];
    
    // Must use __block go get variable to stick around for the block call
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    __block NSURLSessionDataTask *articlesTask = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        handleURLSessionCallback(articlesTask, data, response, error);
    }];
    
    
    [articlesTask resume];
}


#pragma mark Helpers
void handleURLConnectionCallback(NSURLRequest * _Nullable request, NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
    if (connectionError != nil) {
        [CURLLog logCURLRequest:request response:response error:connectionError];
    } else {
        [CURLLog logCURLRequest:request response:response data:data];
    }
}

void handleURLSessionCallback(NSURLSessionTask * _Nullable task,  NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if(error != nil) {
        [CURLLog logCURLForTask:task error:error];
    } else {
        [CURLLog logCURLForTask:task data:data];
    }
}


static NSString *ZHNYTKey = @"3b224e328771da446ab6c6c5a23c427b:13:73834071";
-(NSString*)goodURLString {
    return [NSString stringWithFormat:@"http://api.nytimes.com/svc/search/v2/articlesearch.json"
            @"?q=new+york+times"
            @"&page=%lu"
            @"&sort=newest"
            @"&api-key=%@",
            (unsigned long)1,
            ZHNYTKey];
}

-(NSString*)badURLString {
    return [NSString stringWithFormat:@"http://api._TYPO_nytimes.com/svc/search/v2/articlesearch.json"
            @"?q=new+york+times"
            @"&page=%lu"
            @"&sort=newest"
            @"&api-key=%@",
            (unsigned long)1,
            ZHNYTKey];
}


@end


