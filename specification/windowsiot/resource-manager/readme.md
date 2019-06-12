# Services
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Services.



---
## Getting Started 
To build the SDK for Services, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Services API.

``` yaml
openapi-type: arm
tag: package-2018-02
```

### Tag: package-2018-02

These settings apply only when `--tag=package-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-2018-02'
input-file:
- Microsoft.WindowsIoT/preview/2018-02-16-preview/WindowsIotServices.json
```

---
# Code Generation
