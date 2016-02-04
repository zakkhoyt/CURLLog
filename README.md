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

You can simply copy/paste this into terminal to rerun the command. For convenience the curl command is piped into some other commands to copy pretty json to your clipboard. This can be modified by setting the outputType variable on CURLLog.sharedInstance.

```
curl -X GET "http://api.openweathermap.org/data/2.5/weather?lat=37.78&lon=-122.41&APPID=4199a667b2597ff5b28f33ec06d6a31b" | python -m json.tool | pbcopy
```

#### Usage

First import the header file:

```
CURLLog.h
```

Next call one of the provided methods on CURLLog.sharedInstance. 

For success with a return payload call:

```
[[CURLLog sharedInstance] logCURLForTask:task payload:data];
```

For an error call:

```
[[CURLLog sharedInstance] logCURLForTask:task error:error];
```

#### Example project

Clone this repo and open CURLExample.xcodeproj


