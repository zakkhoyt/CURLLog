### CURLLog - A tool to simplify web API development.

Converts NSURLSessionTasks and NSURLConnections to curl commands and print them to the console. This tool can accelerate development and debugging of API services and allows you to see what's actually going on. 

For example logging a request to get the weather:

```
2016-02-04 12:52:47.000 CURLExample[24182:590796] 
**************** HTTP SUCCESS 200 **********************
**** REQUEST ****
curl -X GET "http://api.openweathermap.org/data/2.5/weather?lat=37.78&lon=-122.41&APPID=4199a667b2597ff5b28f33ec06d6a31b" | python -m json.tool | pbcopy
**** RESPONSE ****
{
    base = "cmc stations";
    clouds =     {
        all = 0;
    };
    cod = 200;
    coord =     {
        lat = "37.77";
        lon = "-122.42";
    };
    dt = 1454617809;
    id = 5391959;
    main =     {
        "grnd_level" = "1035.51";
        humidity = 85;
        pressure = "1035.51";
        "sea_level" = "1043.98";
        temp = "285.82";
        "temp_max" = "285.82";
        "temp_min" = "285.82";
    };
    name = "San Francisco";
    sys =     {
        country = US;
        message = "0.008500000000000001";
        sunrise = 1454598632;
        sunset = 1454636235;
    };
    weather =     (
                {
            description = "Sky is Clear";
            icon = 01d;
            id = 800;
            main = Clear;
        }
    );
    wind =     {
        deg = "61.5011";
        speed = "2.76";
    };
}
****************************************************
```

Notice that the logged curl command from above:

```
curl -X GET "http://api.openweathermap.org/data/2.5/weather?lat=37.78&lon=-122.41&APPID=4199a667b2597ff5b28f33ec06d6a31b"
```

You can paste this into terminal to rerun the command. You can also modify the request after you paste it. 

For convenience the curl command is piped into some other commands to copy pretty json to your clipboard. This pipe command can be modified by setting the outputType variable on CURLLog.sharedInstance.

```
curl -X GET "http://api.openweathermap.org/data/2.5/weather?lat=37.78&lon=-122.41&APPID=4199a667b2597ff5b28f33ec06d6a31b" | python -m json.tool | pbcopy
```

#### Usage

First import the header file:

```
#import "CURLLog.h"
```

To log request and response together, call one of the provided methods on CURLLog.sharedInstance in the completion block. 

##### Obj-C

```
NSURL *url = [NSURL URLWithString:<your url string>];
NSURLRequest *request = [NSURLRequest requestWithURL:url];

// Must use __block qualifier so that the task variable is still alive when we use it inside the completion handler.
__block NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if(error != nil) {
        [[CURLLog sharedInstance] logCURLForTask:task error:error];
    } else {
        [[CURLLog sharedInstance] logCURLForTask:task payload:data];
    }
}];

[task resume];
```

##### Swift
```
let request = NSURLRequest(URL: url)

var task: NSURLSessionTask? = nil

task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, request: NSURLResponse?, error: NSError?) -> Void in
    if let error = error {
        CURLLog.sharedInstance().logCURLForTask(task, error: error)
    } else {
        CURLLog.sharedInstance().logCURLForTask(task, payload: data)
    }
})

task?.resume()

```

If you aren't concerned with the response then you can log outside of the completion handler (no __block required here).

##### Obj-C

```
NSURL *url = [NSURL URLWithString:<your url string>];
NSURLRequest *request = [NSURLRequest requestWithURL:url];

NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    // handle your business...
}];

[[CURLLog sharedInstance] logCURLForTask:task];

[task resume];

```

##### Swift

```
let request = NSURLRequest(URL: url)

var task: NSURLSessionTask? = nil

task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, request: NSURLResponse?, error: NSError?) -> Void in
    // Handle your business...
})

CURLLog.sharedInstance().logCURLForTask(task)

task?.resume()

```

#### Example project

Clone this repo and open CURLExample.xcodeproj which include a Swift example and Obj-C example. 


