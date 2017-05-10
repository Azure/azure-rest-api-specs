# Redis
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Redis.



---
## Getting Started 
To build the SDK for Redis, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Redis API.

``` yaml
# common 
title: Redis
description: Redis Client
api-version: 2016-04-01

```


# API Version: 2016-04-01

These settings apply only when `--api-version=2016-04-01` is specified on the command line.

``` yaml $(api-version) == '2016-04-01'
input-file:
- Microsoft.Cache/2016-04-01/redis.json

```
 
# API Version: 2015-08-01

These settings apply only when `--api-version=2015-08-01` is specified on the command line.

``` yaml $(api-version) == '2015-08-01'
input-file:
- Microsoft.Cache/2015-08-01/redis.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

