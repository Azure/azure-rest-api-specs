# Data Factory V2

> see https://aka.ms/autorest

This is the AutoRest configuration file for Data Factory V2.



---
## Getting Started
To build the SDK for Data Factory V2, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration


### Basic Information
These are the global settings for the Data Factory V2 API.

``` yaml
title: DataFactoryManagementClient
description: The Azure Data Factory V2 management API provides a RESTful set of web services that interact with Azure Data Factory V2 services.
openapi-type: arm
tag: package-2018-06
```

### Tag: package-2018-06

These settings apply only when `--tag=package-2018-06` is specified on the command line.

``` yaml $(tag) == 'package-2018-06'
input-file:
- Microsoft.DataFactory/stable/2018-06-01/datafactory.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/DataFlow.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/Dataset.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/IntegrationRuntime.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/LinkedService.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/ManagedPrivateEndpoint.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/Pipeline.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/Trigger.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/ChangeDataCapture.json
suppressions:
  - code: PropertiesTypeObjectNoDefinition
    reason: ADF parameterization feature is widely adopted and requires object type for most of the swagger properties.
  - code: AvoidAdditionalProperties
    reason: ADF feature is widely adopted and requires additionalProperties for most of the swagger properties.
  - code: MissingTypeObject
    reason: ADF feature is widely adopted and requires MissingTypeObject for most of the swagger properties.
  - code: IntegerTypeMustHaveFormat
    reason: ADF feature is widely adopted and requires IntegerTypeMustHaveFormat for most of the swagger properties.
  - code: RequiredPropertiesMissingInResourceModel
    reason: ADF feature is widely adopted and requires RequiredPropertiesMissingInResourceModel for most of the swagger properties.
  - code: BodyTopLevelProperties
    reason: ADF feature is widely adopted and requires BodyTopLevelProperties for most of the swagger properties.
  - code: TrackedResourcePatchOperation
    reason: ADF feature is widely adopted and requires TrackedResourcePatchOperation for most of the swagger properties.
  - code: XmsEnumValidation
    reason: ADF feature is widely adopted and requires XmsEnumValidation for most of the swagger properties.
  - code: NestedResourcesMustHaveListOperation
    reason: ADF feature is widely adopted and requires NestedResourcesMustHaveListOperation for most of the swagger properties.
```

### Tag: package-2017-09-preview

These settings apply only when `--tag=package-2017-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-09-preview'
input-file:
- Microsoft.DataFactory/preview/2017-09-01-preview/datafactory.json
```

---
# Code Generation

