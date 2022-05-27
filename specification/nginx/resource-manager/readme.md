# Nginx

> see https://aka.ms/autorest

This is the AutoRest configuration file for Nginx.



---
## Getting Started
To build the SDK for Nginx, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Nginx API.

``` yaml
title: NginxManagementClient
openapi-type: arm
openapi-subtype: rpaas
tag: package-2021-05-01-preview
```

### Tag: package-2021-05-01-preview

These settings apply only when `--tag=package-2021-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-05-01-preview'
input-file:
- NGINX.NGINXPLUS/preview/2021-05-01-preview/swagger.json
```
