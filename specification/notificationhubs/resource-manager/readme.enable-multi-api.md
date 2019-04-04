# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.NotificationHubs/stable/2017-04-01/notificationhubs.json
  - Microsoft.NotificationHubs/stable/2016-03-01/notificationhubs.json
  - Microsoft.NotificationHubs/stable/2014-09-01/notificationhubs.json
require: $(this-folder)/../../../../profiles/readme.md
```
