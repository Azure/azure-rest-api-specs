# Auto Generate Rest Client with AutoRest
> see https://aka.ms/autorest

**Warnings: DO NOT manually edit auto-generated files**.


## Getting Started

To build the SDKs for Rest APIs, simply install AutoRest via `npm` (`npm install -g autorest`), move command prompt to 'AzureMlRestAPISwaggers' folder, and run:
> `autorest readme.md`

To see additional help and options, run:
> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

## Revert the auto generated changes for [\_restclient\\_\_init__.py](_restclient\__init__.py) and [\_restclient\version.py.](_restclient\version.py.)
We want to keep the version number as the same as SDK, not the swagger file version, so revert the autogen changes to [\_restclient\\_\_init__.py](_restclient\__init__.py) and [\_restclient\version.py.](_restclient\version.py.)

## Edit Swagger Specification File for Update
- These input files are listed in swagger_files_new folder. Edit these files for updating client definition.
- You can learn [how to write this specification](https://github.com/Azure/autorest/blob/master/docs/developer/guide/defining-clients-swagger.md)

## Inputs
We want a single client to be created from the following OpenAPI definition files:

``` yaml
azure-arm: false
openapi-type: data-plane
azure-validator: true
tag: package-2019-09-30
```

### Tag: package-2019-09-30

These settings apply only when `--tag=package-2019-09-30` is specified on the command line.

```yaml $(tag) == 'package-2019-09-30'
input-file:
  - Microsoft.MachineLearningServices\preview\2019-09-30\artifact.json
  - Microsoft.MachineLearningServices\preview\2019-09-30\datastore.json
  - Microsoft.MachineLearningServices\preview\2019-09-30\execution.json
  - Microsoft.MachineLearningServices\preview\2019-09-30\hyperdrive.json
  - Microsoft.MachineLearningServices\preview\2019-09-30\modelManagement.json
  - Microsoft.MachineLearningServices\preview\2019-09-30\runHistory.json
```
### Tag: package-2019-08-01

These settings apply only when `--tag=package-2019-08-01` is specified on the command line.

```yaml $(tag) == 'package-2019-08-01'
input-file:
  - Microsoft.MachineLearningServices\preview\2019-08-01\execution.json
  - Microsoft.MachineLearningServices\preview\2019-08-01\modelManagement.json
  - Microsoft.MachineLearningServices\preview\2019-08-01\runHistory.json
  - Microsoft.MachineLearningServices\preview\2019-08-01\datastore.json
  - Microsoft.MachineLearningServices\preview\2019-08-01\artifact.json
  - Microsoft.MachineLearningServices\preview\2019-08-01\hyperdrive.json
```

Since the info sections of the OpenAPI definition files differ, we choose a new title for the overall client:
```yaml
title: Azure Machine Learning Service
description: These APIs allow end users to manage Azure Machine Learning Services.
```

## Suppression
``` yaml
directive:
  - suppress: AvoidNestedProperties
    reason: Client defined properties dictionaries should not be flattened.
  - suppress: GuidUsage
    reason: Existing properties; cannot change without breaking API
  - suppress: DeleteMustNotHaveRequestBody
    reason: Existing API for batch deletion
  - suppress: LROStatusCodesReturnTypeSchema
    reason: Not a Long Running Operation
  - from: hyperdrive.json
    suppress: DefinitionsPropertiesNamesCamelCase
    reason: Existing service; would be a breaking change
```

## Generation
```yaml
#csharp:
#    add-credentials: true
#    namespace: Azure.MachineLearning.Services.Generated
#    license-header: MICROSOFT_MIT
#    base-folder: dotnet\Client
#    output-folder: Generated

```

## Temporary output folder to save output-artifact and source maps files. Please do not check in these files.

``` yaml
output-folder: swagger_generation_log
```

### Fully resolved OpenAPI definition

To support tools unable to process multiple OpenAPI definitions or definitions with external references (`$ref: "<URI to another OpenAPI definition>#/definitions/SomeModel"`), AutoRest allows exporting a single, fully resolved OpenAPI definition without any external references that tools should be able to consume.

``` yaml
output-artifact:
  - swagger-document.norm.json
```

### Source maps

AutoRest tries to create source maps for output artifacts. These will relate the artifact with the original input files which may be helpful for tools created around AutoRest.
For example, AutoRest uses the source map internally in order to relate validation messages back to the original files.

``` yaml
output-artifact:
  - swagger-document.norm.json.map
```
