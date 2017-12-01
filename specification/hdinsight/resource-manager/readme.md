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
azure-arm: true
tag: package-2015-03-preview
```


### Tag: package-2015-03-preview

These settings apply only when `--tag=package-2015-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-03-preview'
input-file:
- Microsoft.HDInsight/2015-03-01-preview/cluster.json
- Microsoft.HDInsight/2015-03-01-preview/applications.json
- Microsoft.HDInsight/2015-03-01-preview/capabilities.json
- Microsoft.HDInsight/2015-03-01-preview/configurations.json
- Microsoft.HDInsight/2015-03-01-preview/extensions.json
- Microsoft.HDInsight/2015-03-01-preview/scriptActions.json
- Microsoft.HDInsight/2015-03-01-preview/operations.json
```


---
# Code Generation


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: hdinsight
  clear-output-folder: true
```

### Tag: package-2015-03-preview and go

These settings apply only when `--tag=package-2015-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/hdinsight/mgmt/2015-03-01-preview/hdinsight
```

## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.HDInsight
  output-folder: $(csharp-sdks-folder)/HDInsight/Management.HDInsight/Generated
  clear-output-folder: true
```
