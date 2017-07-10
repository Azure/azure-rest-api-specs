# Consumption
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Consumption.



---
## Getting Started 
To build the SDK for Consumption, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Consumption API.

``` yaml
openapi-type: arm
tag: package-2017-04-preview
```


### Tag: package-2017-04-preview

These settings apply only when `--tag=package-2017-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-04-preview'
input-file:
- Microsoft.Consumption/2017-04-24-preview/consumption.json
```


---
## Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

