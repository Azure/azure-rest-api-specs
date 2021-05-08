# ContainerRegistry

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerRegistry.

---

## Configuration

### Basic Information

These are the global settings for the ContainerRegistry API.

``` yaml
# common
title: ContainerRegistryClient
openapi-type: data-plane
tag: package-2019-08
```
### Tag: package-2019-08

These settings apply only when `--tag=package-2019-08` is specified on the command line.

``` yaml $(tag) == 'package-2019-08'
input-file: preview/2019-08-15-preview/containerregistry.json
```

---
# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp: true
model-namespace: false
directive:
  - from: containerregistry.json
    where: $.definitions.DeletedRepository
    transform: >
      $["x-accessibility"] = "internal"

  - from: containerregistry.json
    where: $.definitions.ManifestAttributes_manifest_references
    transform: >
      $["x-accessibility"] = "internal"
```

## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
java: true
```

## TypeScript

These settings apply only when `--typescript` is specified on the command line.

``` yaml $(typescript)
typescript: true
v3: true
package-name: "@azure/container-registry"
title: GeneratedClient
description: Container Registry Client
generate-metadata: false
license-header: MICROSOFT_MIT_NO_VERSION
output-folder: ../
source-code-folder-path: ./src/generated
add-credentials: false
override-client-name: GeneratedClient
disable-async-iterators: true
hide-clients: true
use-core-v2: true
use-extension:
  "@autorest/typescript": "C:/github/autorest.typescript"
```

## Python
These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python: true
```
