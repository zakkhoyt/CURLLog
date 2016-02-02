//
//  ViewController.m
//  CURLExample
//
//  Created by Zakk Hoyt on 2/2/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

#import "ViewController.h"
#import "NSURLSessionTask+CURL.h"

@interface ViewController ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _session = [NSURLSession sharedSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(id)sender {
    [self getArticles];
}

static NSString *ZHNYTKey = @"3b224e328771da446ab6c6c5a23c427b:13:73834071";

-(void)getArticles{
    
    // Build our GET URL
    NSString *urlString = [NSString stringWithFormat:@"http://api.nytimes.com/svc/search/v2/articlesearch.json"
                           @"?q=new+york+times"
                           @"&page=%lu"
                           @"&sort=newest"
                           @"&api-key=%@",
                           (unsigned long)1,
                           ZHNYTKey];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Must use __block go get variable to stick around for the block call
    __block NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    __block NSURLSessionDataTask *articlesTask = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error != nil) {
            [articlesTask logCURL];
        } else {
            [articlesTask logCURLWithData:data];
        }
    }];
    

    [articlesTask resume];
}

@end
