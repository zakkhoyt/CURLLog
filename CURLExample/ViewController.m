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
        [[CURLLog sharedInstance] logCURLRequest:request response:response error:connectionError];
    } else {
        [[CURLLog sharedInstance] logCURLRequest:request response:response payload:data];
    }
}

void handleURLSessionCallback(NSURLSessionTask * _Nullable task,  NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if(error != nil) {
        [[CURLLog sharedInstance] logCURLForTask:task error:error];
    } else {
        [[CURLLog sharedInstance] logCURLForTask:task payload:data];
    }
}



static NSString *ZHWeatherKey = @"4199a667b2597ff5b28f33ec06d6a31b";

-(NSString*)goodURLString {
    return [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=37.78&lon=-122.41&APPID=%@", ZHWeatherKey];
}

-(NSString*)badURLString {
    return [NSString stringWithFormat:@"http://api.op_TYPO__enweathermap.org/data/2.5/weather?lat=37.78&lon=-122.41&APPID=%@", ZHWeatherKey];}


@end


