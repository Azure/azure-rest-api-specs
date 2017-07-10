# MySql
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Sql.



---
## Getting Started 
To build the SDK for MySql, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Sql API.

``` yaml
# common
title: MySqlManagementClient
description: The Azure MySql Database management API provides a RESTful set of web services that interact with Azure MySql Database services to manage your databases. The API enables you to create, retrieve, update, and delete databases.
openapi-type: arm
tag: package-2017-04-preview

```


# Tag: package-2017-04-preview

These settings apply only when `--tag=package-2017-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-04-preview'
input-file:
- Microsoft.DBforMySQL/2017-04-30-preview/mysql.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```
