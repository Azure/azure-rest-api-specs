# DNS
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.



---
## Getting Started 
To build the SDK for DNS, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the DNS API.

``` yaml
# common 
title: DNS
description: DNS Client
tag: 2016-04-01

```


# Tag: 2016-04-01

These settings apply only when `--tag=2016-04-01` is specified on the command line.

``` yaml $(tag) == '2016-04-01'
input-file:
- Microsoft.Network/2016-04-01/dns.json

```
 
# Tag: 2015-05-04-preview

These settings apply only when `--tag=2015-05-04-preview` is specified on the command line.

``` yaml $(tag) == '2015-05-04-preview'
input-file:
- Microsoft.Network/2015-05-04-preview/dns.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

