# KeyVault
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for KeyVault.



---
## Getting Started 
To build the SDK for KeyVault, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the KeyVault API.

``` yaml
# common 
title: Key Vault
description: Key Vault Client
tag: 2016-10-01

```


# Tag: 2016-10-01

These settings apply only when `--tag=2016-10-01` is specified on the command line.

``` yaml $(tag) == '2016-10-01'
input-file:
- Microsoft.KeyVault/2016-10-01/keyvault.json

```


# Tag: 2015-06-01

These settings apply only when `--tag=2015-06-01` is specified on the command line.

``` yaml $(tag) == '2015-06-01'
input-file:
- Microsoft.KeyVault/2015-06-01/keyvault.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

