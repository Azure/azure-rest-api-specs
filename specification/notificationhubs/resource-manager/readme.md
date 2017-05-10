# NotificationHubs
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for NotificationHubs.



---
## Getting Started 
To build the SDK for NotificationHubs, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the NotificationHubs API.

``` yaml
# common 
title: Notification Hubs
description: Notification Hubs Client
api-version: 2017-04-01

```


# API Version: 2017-04-01

These settings apply only when `--api-version=2017-04-01` is specified on the command line.

``` yaml $(api-version) == '2017-04-01'
input-file:
- Microsoft.NotificationHubs/2017-04-01/notificationhubs.json

```
 
# API Version: 2016-03-01

These settings apply only when `--api-version=2016-03-01` is specified on the command line.

``` yaml $(api-version) == '2016-03-01'
input-file:
- Microsoft.NotificationHubs/2016-03-01/notificationhubs.json

```
 
# API Version: 2014-09-01

These settings apply only when `--api-version=2014-09-01` is specified on the command line.

``` yaml $(api-version) == '2014-09-01'
input-file:
- Microsoft.NotificationHubs/2014-09-01/notificationhubs.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

