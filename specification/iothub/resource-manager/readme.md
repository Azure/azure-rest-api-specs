# IotHub
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for IotHub.



---
## Getting Started 
To build the SDK for IotHub, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the IotHub API.

``` yaml
openapi-type: arm
tag: package-2017-01
```


### Tag: package-2017-01

These settings apply only when `--tag=package-2017-01` is specified on the command line.

``` yaml $(tag) == 'package-2017-01'
input-file:
- Microsoft.Devices/2017-01-19/iothub.json
```
 
### Tag: package-2016-02

These settings apply only when `--tag=package-2016-02` is specified on the command line.

``` yaml $(tag) == 'package-2016-02'
input-file:
- Microsoft.Devices/2016-02-03/iothub.json
```


---
## Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

