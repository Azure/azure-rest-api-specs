# Commerce
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Commerce.



---
## Getting Started 
To build the SDK for Commerce, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Commerce API.

``` yaml
openapi-type: arm
tag: package-2015-06-preview
```


### Tag: package-2015-06-preview

These settings apply only when `--tag=package-2015-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-06-preview'
input-file:
- Microsoft.Commerce/2015-06-01-preview/commerce.json
```


---
## Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

