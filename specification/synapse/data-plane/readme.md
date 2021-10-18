# Azure Synapse Analytics


> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Synapse Analytics.



---
## Getting Started
To build the SDK for Azure Synapse Analytics, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the Azure Synapse Analytics API.

``` yaml
openapi-type: data-plane
modelerfour:
  lenient-model-deduplication: true
```

``` yaml $(package-spark)
tag: package-spark-2020-12-01
```

``` yaml $(package-artifacts)
tag: package-artifacts-composite-v1
```

``` yaml $(package-access-control)
tag: package-access-control-2020-12-01
```

``` yaml $(package-vnet)
tag: package-vnet-2020-12-01
```

``` yaml $(package-monitoring)
tag: package-monitoring-2020-12-01
```

### Tag: package-metadata-2021-07-01-preview

These settings apply only when `--tag=package-metadata-2021-07-01-preview` is specified on the command line.

**ATTENTION**: Please DO NOT generate SDK based on this tag. Synapse metadata API set is not ready to be included in SDK.

``` yaml $(tag) == 'package-metadata-2021-07-01-preview'
input-file:
  - Microsoft.Synapse/preview/2021-07-01-preview/symsSync.json
```

### Tag: package-artifacts-composite-v1

These settings apply only when `--tag=package-artifacts-composite-v1` is specified on the command line.

``` yaml $(tag) == 'package-artifacts-composite-v1'
input-file:
  - Microsoft.Synapse/preview/2021-06-01-preview/kqlScripts.json
  - Microsoft.Synapse/preview/2021-06-01-preview/sparkConfigurations.json
  - Microsoft.Synapse/preview/2021-06-01-preview/entityTypes/SparkConfiguration.json
  - Microsoft.Synapse/stable/2020-12-01/artifacts.json
  - Microsoft.Synapse/stable/2020-12-01/bigDataPools.json
  - Microsoft.Synapse/stable/2020-12-01/dataflows.json
  - Microsoft.Synapse/stable/2020-12-01/datasets.json
  - Microsoft.Synapse/stable/2020-12-01/gitintegration.json
  - Microsoft.Synapse/stable/2020-12-01/integrationRuntimes.json
  - Microsoft.Synapse/stable/2020-12-01/library.json
  - Microsoft.Synapse/stable/2020-12-01/linkedServices.json
  - Microsoft.Synapse/stable/2020-12-01/notebooks.json
  - Microsoft.Synapse/stable/2020-12-01/pipelines.json
  - Microsoft.Synapse/stable/2020-12-01/sparkJobDefinitions.json
  - Microsoft.Synapse/stable/2020-12-01/sqlPools.json
  - Microsoft.Synapse/stable/2020-12-01/sqlScripts.json
  - Microsoft.Synapse/stable/2020-12-01/triggers.json
  - Microsoft.Synapse/stable/2020-12-01/workspace.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/DataFlow.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/Dataset.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/LinkedService.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/Notebook.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/Pipeline.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/SparkJobDefinition.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/SqlScript.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/Trigger.json
```

### Tag: package-artifacts-2021-06-01-preview

These settings apply only when `--tag=package-artifacts-2021-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-artifacts-2021-06-01-preview'
input-file:
  - Microsoft.Synapse/preview/2021-06-01-preview/artifacts.json
  - Microsoft.Synapse/preview/2021-06-01-preview/bigDataPools.json
  - Microsoft.Synapse/preview/2021-06-01-preview/dataflows.json
  - Microsoft.Synapse/preview/2021-06-01-preview/datasets.json
  - Microsoft.Synapse/preview/2021-06-01-preview/gitintegration.json
  - Microsoft.Synapse/preview/2021-06-01-preview/integrationRuntimes.json
  - Microsoft.Synapse/preview/2021-06-01-preview/library.json
  - Microsoft.Synapse/preview/2021-06-01-preview/linkedServices.json
  - Microsoft.Synapse/preview/2021-06-01-preview/notebooks.json
  - Microsoft.Synapse/preview/2021-06-01-preview/operations.json
  - Microsoft.Synapse/preview/2021-06-01-preview/pipelines.json
  - Microsoft.Synapse/preview/2021-06-01-preview/sparkConfigurations.json
  - Microsoft.Synapse/preview/2021-06-01-preview/sparkJobDefinitions.json
  - Microsoft.Synapse/preview/2021-06-01-preview/sqlPools.json
  - Microsoft.Synapse/preview/2021-06-01-preview/sqlScripts.json
  - Microsoft.Synapse/preview/2021-06-01-preview/triggers.json
  - Microsoft.Synapse/preview/2021-06-01-preview/workspace.json
  - Microsoft.Synapse/preview/2021-06-01-preview/entityTypes/DataFlow.json
  - Microsoft.Synapse/preview/2021-06-01-preview/entityTypes/Dataset.json
  - Microsoft.Synapse/preview/2021-06-01-preview/entityTypes/LinkedService.json
  - Microsoft.Synapse/preview/2021-06-01-preview/entityTypes/Notebook.json
  - Microsoft.Synapse/preview/2021-06-01-preview/entityTypes/Pipeline.json
  - Microsoft.Synapse/preview/2021-06-01-preview/entityTypes/SparkJobDefinition.json
  - Microsoft.Synapse/preview/2021-06-01-preview/entityTypes/SqlScript.json
  - Microsoft.Synapse/preview/2021-06-01-preview/entityTypes/Trigger.json
  - Microsoft.Synapse/preview/2021-06-01-preview/entityTypes/SparkConfiguration.json
```

### Tag: package-vnet-2021-06-01-preview

These settings apply only when `--tag=package-vnet-2021-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-vnet-2021-06-01-preview'
input-file:
  - Microsoft.Synapse/preview/2021-06-01-preview/managedPrivateEndpoints.json
```

### Tag: package-kql-script-2021-06-preview

These settings apply only when `--tag=package-kql-script-2021-06-preview` is specified on the command line.

**ATTENTION**: Please DO NOT generate SDK based on this tag. KQL script API set is not ready to be widely used.

``` yaml $(tag) == 'package-kql-script-2021-06-preview'
input-file:
  - Microsoft.Synapse/preview/2021-06-01-preview/kqlScripts.json
```

### Tag: package-artifacts-2020-12-01

These settings apply only when `--tag=package-artifacts-2020-12-01` is specified on the command line.

``` yaml $(tag) == 'package-artifacts-2020-12-01'
input-file:
  - Microsoft.Synapse/stable/2020-12-01/artifacts.json
  - Microsoft.Synapse/stable/2020-12-01/bigDataPools.json
  - Microsoft.Synapse/stable/2020-12-01/dataflows.json
  - Microsoft.Synapse/stable/2020-12-01/datasets.json
  - Microsoft.Synapse/stable/2020-12-01/gitintegration.json
  - Microsoft.Synapse/stable/2020-12-01/integrationRuntimes.json
  - Microsoft.Synapse/stable/2020-12-01/library.json
  - Microsoft.Synapse/stable/2020-12-01/linkedServices.json
  - Microsoft.Synapse/stable/2020-12-01/notebooks.json
  - Microsoft.Synapse/stable/2020-12-01/operations.json
  - Microsoft.Synapse/stable/2020-12-01/pipelines.json
  - Microsoft.Synapse/stable/2020-12-01/sparkJobDefinitions.json
  - Microsoft.Synapse/stable/2020-12-01/sqlPools.json
  - Microsoft.Synapse/stable/2020-12-01/sqlScripts.json
  - Microsoft.Synapse/stable/2020-12-01/triggers.json
  - Microsoft.Synapse/stable/2020-12-01/workspace.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/DataFlow.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/Dataset.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/LinkedService.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/Notebook.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/Pipeline.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/SparkJobDefinition.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/SqlScript.json
  - Microsoft.Synapse/stable/2020-12-01/entityTypes/Trigger.json
```

### Tag: package-monitoring-2020-12-01

These settings apply only when `--tag=package-monitoring-2020-12-01` is specified on the command line.

``` yaml $(tag) == 'package-monitoring-2020-12-01'
input-file:
  - Microsoft.Synapse/stable/2020-12-01/monitoring.json
```

### Tag: package-access-control-2020-12-01

These settings apply only when `--tag=package-access-control-2020-12-01` is specified on the command line.

``` yaml $(tag) == 'package-access-control-2020-12-01'
input-file:
  - Microsoft.Synapse/stable/2020-12-01/checkAccessSynapseRbac.json
  - Microsoft.Synapse/stable/2020-12-01/roleAssignments.json
  - Microsoft.Synapse/stable/2020-12-01/roleDefinitions.json
```

### Tag: package-vnet-2020-12-01

These settings apply only when `--tag=package-vnet-2020-12-01` is specified on the command line.

``` yaml $(tag) == 'package-vnet-2020-12-01'
input-file:
  - Microsoft.Synapse/stable/2020-12-01/managedPrivateEndpoints.json
```

### Tag: package-spark-2020-12-01

These settings apply only when `--tag=package-spark-2020-12-01` is specified on the command line.

``` yaml $(tag) == 'package-spark-2020-12-01'
input-file:
  - Microsoft.Synapse/stable/2020-12-01/sparkJob.json
```

### Tag: package-spark-2019-11-01-preview

These settings apply only when `--tag=package-spark-2019-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-spark-2019-11-01-preview'
input-file:
- Microsoft.Synapse/preview/2019-11-01-preview/sparkJob.json
```

### Tag: package-artifacts-2019-06-01-preview

These settings apply only when `--tag=package-artifacts-2019-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-artifacts-2019-06-01-preview'
input-file:
- Microsoft.Synapse/preview/2019-06-01-preview/artifacts.json
- Microsoft.Synapse/preview/2019-06-01-preview/workspace.json
- Microsoft.Synapse/preview/2019-06-01-preview/sqlPools.json
- Microsoft.Synapse/preview/2019-06-01-preview/bigDataPools.json
- Microsoft.Synapse/preview/2019-06-01-preview/integrationRuntimes.json
- Microsoft.Synapse/preview/2019-06-01-preview/library.json
- Microsoft.Synapse/preview/2019-06-01-preview/entityTypes/DataFlow.json
- Microsoft.Synapse/preview/2019-06-01-preview/entityTypes/Dataset.json
- Microsoft.Synapse/preview/2019-06-01-preview/entityTypes/LinkedService.json
- Microsoft.Synapse/preview/2019-06-01-preview/entityTypes/Notebook.json
- Microsoft.Synapse/preview/2019-06-01-preview/entityTypes/Pipeline.json
- Microsoft.Synapse/preview/2019-06-01-preview/entityTypes/SparkJobDefinition.json
- Microsoft.Synapse/preview/2019-06-01-preview/entityTypes/SqlScript.json
- Microsoft.Synapse/preview/2019-06-01-preview/entityTypes/Trigger.json
- Microsoft.Synapse/preview/2019-06-01-preview/gitintegration.json
```

### Tag: package-access-control-2020-02-01-preview

These settings apply only when `--tag=package-access-control-2020-02-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-access-control-2020-02-01-preview'
input-file:
- Microsoft.Synapse/preview/2020-02-01-preview/roles.json
- Microsoft.Synapse/preview/2020-02-01-preview/roleAssignments.json
```

### Tag: package-access-control-2020-08-01-preview

These settings apply only when `--tag=package-access-control-2020-08-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-access-control-2020-08-01-preview'
input-file:
- Microsoft.Synapse/preview/2020-08-01-preview/checkAccessSynapseRbac.json
- Microsoft.Synapse/preview/2020-08-01-preview/roleDefinitions.json
- Microsoft.Synapse/preview/2020-08-01-preview/roleAssignments.json
```

### Tag: package-vnet-2019-06-01-preview

These settings apply only when `--tag=package-vnet-2019-06-01-preview` is specified on the command line

``` yaml $(tag) == 'package-vnet-2019-06-01-preview'
input-file:
- Microsoft.Synapse/preview/2019-06-01-preview/managedPrivateEndpoints.json
```

### Tag: package-monitoring-2019-11-01-preview

These settings apply only when `--tag=package-monitoring-2019-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-monitoring-2019-11-01-preview'
input-file:
- Microsoft.Synapse/preview/2019-11-01-preview/monitoring.json
```

## Suppression
``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: This would require a breaking change, and need to be consistent with the response from RP side.
    from: sparkJob.json
    where:
      - $.definitions.SparkStatementCollection.properties.total_statements
      - $.definitions.SparkStatementOutput.properties.execution_count

  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: These properties need to keep the same with jupyter Notebook. Rp can't change these proeprties.
    from: Notebook.json
    where:
      - $.definitions.NotebookCellOutputItem.properties.execution_count
      - $.definitions.NotebookCellOutputItem.properties.output_type
      - $.definitions.NotebookCell.properties.cell_type
      - $.definitions.NotebookLanguageInfo.properties.codemirror_mode
      - $.definitions.NotebookKernelSpec.properties.display_name
      - $.definitions.NotebookMetadata.properties.language_info
      - $.definitions.Notebook.properties.nbformat_minor

  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: This would require a breaking change, and need to be consistent with the response from RP side.
    from: checkAccessSynapseRbac.json
    where:
      - $.definitions.CheckPrincipalAccessResponse.properties.AccessDecisions
```

---
# Code Generation

## Swagger to SDK

Swagger to SDK has been intentionally disabled for this spec.

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Synapse
  output-folder: $(csharp-sdks-folder)/synapse/Microsoft.Azure.Synapse/src/Generated
  clear-output-folder: true
batch:
  - package-spark: true
  - package-artifacts: true
  - package-access-control: true
```

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Multi-API/Profile support for AutoRest v3 generators

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

``` yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/Microsoft.Synapse/preview/2019-06-01-preview/workspace.json
  - $(this-folder)/Microsoft.Synapse/preview/2019-06-01-preview/sqlPools.json
  - $(this-folder)/Microsoft.Synapse/preview/2019-06-01-preview/bigDataPools.json
  - $(this-folder)/Microsoft.Synapse/preview/2019-06-01-preview/integrationRuntimes.json
  - $(this-folder)/Microsoft.Synapse/preview/2019-11-01-preview/sparkJob.json
  - $(this-folder)/Microsoft.Synapse/preview/2019-06-01-preview/artifacts.json
  - $(this-folder)/Microsoft.Synapse/preview/2020-02-01-preview/roles.json
  - $(this-folder)/Microsoft.Synapse/preview/2020-02-01-preview/roleAssignments.json
  - $(this-folder)/Microsoft.Synapse/preview/2019-06-01-preview/managedPrivateEndpoints.json
  - $(this-folder)/Microsoft.Synapse/preview/2019-11-01-preview/monitoring.json
  - $(this-folder)/Microsoft.Synapse/preview/2019-06-01-preview/gitintegration.json
  - $(this-folder)/Microsoft.Synapse/preview/2019-06-01-preview/library.json

```

If there are files that should not be in the `all-api-versions` set,
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file:
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```
