# HDInsight

> see https://aka.ms/autorest

This is the AutoRest configuration file for HDInsight.



---
## Getting Started
To build the SDK for HDInsight, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration


### Basic Information
These are the global settings for the HDInsight API.

``` yaml
title: HDInsightManagementClient
description: HDInsight Management Client
openapi-type: arm
openapi-subtype: rpaas
azure-arm: true
tag: package-2020-11-preview
```

### Tag: package-2020-11-preview

These settings apply only when `--tag=package-2020-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-11-preview'
input-file:
- Microsoft.HDInsight/preview/2020-11-01-preview/hdinsight.json
```

### Tag: package-2021-09-preview

These settings apply only when `--tag=package-2021-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-09-preview'
input-file:
- Microsoft.HDInsight/preview/2021-09-15-preview/hdinsight.json
```

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)
