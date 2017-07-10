# MediaServices
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for MediaServices.



---
## Getting Started 
To build the SDK for MediaServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the MediaServices API.

``` yaml
openapi-type: arm
tag: package-2015-10
```


### Tag: package-2015-10

These settings apply only when `--tag=package-2015-10` is specified on the command line.

``` yaml $(tag) == 'package-2015-10'
input-file:
- Microsoft.Media/2015-10-01/media.json
```


---
## Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

