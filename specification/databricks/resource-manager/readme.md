# Databricks

> see https://aka.ms/autorest

This is the AutoRest configuration file for Databricks.

---

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: package-2024-09-01-preview
  - tag: package-2024-05-01
  - tag: package-2023-09-15-preview
  - tag: package-2023-02-01
  - tag: package-2022-04-01-preview
  - tag: package-2021-04-01-preview
  - tag: package-2018-04-01
  - tag: package-2023-05-01
```

### Tag: package-2024-09-01-preview and java

These settings apply only when `--tag=package-2024-09-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2024-09-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databricks.v2024_09_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/databricks/mgmt-v2024_09_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2024-05-01 and java

These settings apply only when `--tag=package-2024-05-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2024-05-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databricks.v2024_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databricks/mgmt-v2024_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-09-15-preview and java

These settings apply only when `--tag=package-2023-09-15-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2023-09-15-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databricks.v2023_09_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/databricks/mgmt-v2023_09_15_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-05-01 and java

These settings apply only when `--tag=package-2023-05-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2023-05-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databricks.v2023_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databricks/mgmt-v2023_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2023-02-01 and java

These settings apply only when `--tag=package-2023-02-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2023-02-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databricks.v2023_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databricks/mgmt-v2023_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2022-04-01-preview and java

These settings apply only when `--tag=package-2022-04-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2022-04-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databricks.v2022_04_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/databricks/mgmt-v2022_04_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-04-01-preview and java

These settings apply only when `--tag=package-2021-04-01-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2021-04-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databricks.v2021_04_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/databricks/mgmt-v2021_04_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-04-01 and java

These settings apply only when `--tag=package-2018-04-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2018-04-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.databricks.v2018_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/databricks/mgmt-v2018_04_01
regenerate-manager: true
generate-interface: true
```

## Getting Started

To build the SDK for Databricks, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Databricks API.

```yaml
title: AzureDatabricksManagementClient
description: The Microsoft Azure management APIs allow end users to operate on Azure Databricks Workspace / Access Connector resources.
openapi-type: arm
tag: package-2024-09-01-preview
```

### Tag: package-2018-04-01

These settings apply only when `--tag=package-2018-04-01` is specified on the command line.

```yaml $(tag) == 'package-2018-04-01'
input-file:
  - Microsoft.Databricks/stable/2018-04-01/databricks.json
  - Microsoft.Databricks/stable/2018-04-01/vnetpeering.json
```

### Tag: package-2021-04-01-preview

These settings apply only when `--tag=package-2021-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-04-01-preview'
input-file:
  - Microsoft.Databricks/preview/2021-04-01-preview/databricks.json
  - Microsoft.Databricks/preview/2021-04-01-preview/vnetpeering.json
```

### Tag: package-2022-04-01-preview

These settings apply only when `--tag=package-2022-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-04-01-preview'
input-file:
  - Microsoft.Databricks/preview/2022-04-01-preview/databricks.json
  - Microsoft.Databricks/preview/2022-04-01-preview/vnetpeering.json
  - Microsoft.Databricks/preview/2022-04-01-preview/accessconnector.json
```

### Tag: package-2023-02-01

These settings apply only when `--tag=package-2023-02-01` is specified on the command line.

```yaml $(tag) == 'package-2023-02-01'
input-file:
  - Microsoft.Databricks/stable/2023-02-01/databricks.json
  - Microsoft.Databricks/stable/2023-02-01/vnetpeering.json
  - Microsoft.Databricks/preview/2022-10-01-preview/accessconnector.json
```

### Tag: package-2023-05-01

These settings apply only when `--tag=package-2023-05-01` is specified on the command line.

```yaml $(tag) == 'package-2023-05-01'
input-file:
  - Microsoft.Databricks/stable/2023-02-01/databricks.json
  - Microsoft.Databricks/stable/2023-02-01/vnetpeering.json
  - Microsoft.Databricks/stable/2023-05-01/accessconnector.json
```

### Tag: package-2023-09-15-preview

These settings apply only when `--tag=package-2023-09-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-09-15-preview'
input-file:
  - Microsoft.Databricks/preview/2023-09-15-preview/databricks.json
  - Microsoft.Databricks/preview/2023-09-15-preview/vnetpeering.json
  - Microsoft.Databricks/stable/2023-05-01/accessconnector.json
```

### Tag: package-2024-05-01

These settings apply only when `--tag=package-2024-05-01` is specified on the command line.

```yaml $(tag) == 'package-2024-05-01'
input-file:
  - Microsoft.Databricks/stable/2024-05-01/databricks.json
  - Microsoft.Databricks/stable/2024-05-01/vnetpeering.json
  - Microsoft.Databricks/stable/2024-05-01/accessconnector.json
```

### Tag: package-2024-09-01-preview

These settings apply only when `--tag=package-2024-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-09-01-preview'
input-file:
  - Microsoft.Databricks/preview/2024-09-01-preview/databricks.json
  - Microsoft.Databricks/preview/2024-09-01-preview/vnetpeering.json
  - Microsoft.Databricks/preview/2024-09-01-preview/accessconnector.json
```


---

# Suppressions

```yaml
directive:
  - suppress: R3016
    from: databricks.json
    where: $.definitions.Encryption.properties.KeyName
    reason: Response from service is not camel case
  - suppress: RequiredReadOnlySystemData
    reason: We do not yet support system data. Currently our system support system data inside property field.
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)
