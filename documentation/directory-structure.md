| Short Link: | [aka.ms/azsdk/spec-dirs](https://aka.ms/azsdk/spec-dirs) |
|--|--|

<!-- 
Table of contents generated with VSCode Markdown All in One:
https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one 
-->

- [`specification` directory structure](#specification-directory-structure)
  - [Key concepts and terminology](#key-concepts-and-terminology)
  - [Overview of the folder structure](#overview-of-the-folder-structure)
    - [ARM services: `resource-manager/<RPNS>` folder](#arm-services-resource-managerrpns-folder)
    - [Data-plane services: `data-plane/<service>` folders](#data-plane-services-data-planeservice-folders)
  - [Service folder structure](#service-folder-structure)
    - [Contents of a service folder](#contents-of-a-service-folder)
    - [API version folders](#api-version-folders)
  - [`specification/common-types`](#specificationcommon-types)
  - [Naming guidelines for `specification` folder contents](#naming-guidelines-for-specification-folder-contents)
  - [About legacy, deprecated directory structure for services and service groups](#about-legacy-deprecated-directory-structure-for-services-and-service-groups)
  - [Migrating from a singular service to service group in a legacy directory structure](#migrating-from-a-singular-service-to-service-group-in-a-legacy-directory-structure)
  - [Deprecated directory structure and hand-written OpenAPI specs](#deprecated-directory-structure-and-hand-written-openapi-specs)

# `specification` directory structure

This article describes the recommended directory structure and folder layout for Azure REST API specifications in the `specification` folder. This structure supports both ARM (Azure Resource Manager) and data-plane services, and is designed to work seamlessly with TypeSpec-based API development.

> [!IMPORTANT]
> The structure described in this article is the **recommended standard** for all new services. While some existing services may follow legacy patterns for historical reasons, all new services should adopt this structure. We are actively working on migrating legacy patterns to align with these guidelines.

## Key concepts and terminology

Before diving into the folder structure, familiarize yourself with these key concepts as defined in the [glossary]:

- **Service**: A customer-facing Azure service (e.g., Azure Key Vault, Azure Container Registry)
- **Organization**: The Azure team or group responsible for one or more services
- **Resource Provider Namespace (RPNS)**: The ARM namespace for resource management operations (e.g., `Microsoft.KeyVault`)
- **API versioning**: Following [uniform versioning] principles for consistent service evolution

Additional resources:
- [Specification index] - Complete list of all specifications
- [Resource Provider list] - Official list of ARM Resource Providers

## Overview of the folder structure

The `specification` folder is organized hierarchically to support both ARM and data-plane services. Here's the high-level structure:

```
specification/
└── <organization>/
    ├── cspell.yaml                     # Spell-check configuration
    ├── resource-manager/               # ARM services
    │   └── <RPNS>/                    # Resource Provider Namespace
    │       └── <service>/             # Individual service
    └── data-plane/                    # Data-plane services
        └── <service>/                 # Individual service
```

Each organization folder contains:
- **One** `resource-manager/<RPNS>/` folder for ARM services (where `<RPNS>` is the Resource Provider Namespace)
- **One** `data-plane/` folder that can contain multiple service folders for data-plane services

### ARM services: `resource-manager/<RPNS>` folder

The `<organization>/resource-manager/<RPNS>` folder corresponds to an ARM **Resource Provider (RP) namespace**.

An example RPNS is `Microsoft.Automation`. A list of RPs can be found in the [Resource Provider list].

This folder contains one or more `<service>` folders corresponding to the ARM services owned by the team.

For example, [`specification/containerservice/resource-manager/Microsoft.ContainerService/aks`] is a folder for the `aks` service within the `Microsoft.ContainerService` ARM Resource Provider namespace.

> [!NOTE]
> Many Azure teams that have one ARM service place it directly in `specification/<organization>/resource-manager/` instead of `specification/<organization>/resource-manager/<RPNS>/<service>`. This is a legacy, deprecated structure and is strongly discouraged going forward.

**Shared definitions**: If there are models or operations definitions (other than those in [`specification/common-types`]) that need to be shared across different services, they must be duplicated in each service's own folder. This is because each service must control its own versioning lifecycle of those shared definitions.

### Data-plane services: `data-plane/<service>` folders

The `<organization>/data-plane` folder contains data-plane service APIs, with the following distinctions from ARM services:

- Pertains to data-plane service APIs, not ARM service APIs
- Has no concept of Resource Provider Namespace (`<RPNS>`)
- Each service gets its own folder directly under `data-plane/`

Each `<organization>/data-plane` folder contains one or more `<service>` folders corresponding to the data-plane services owned by the team.

> [!NOTE]
> Some organizations use additional grouping folders like `<organization>/data-plane/<groupingDir>/<service>` or prefix service names with `Azure.<SomeService>`. These are legacy, deprecated structures and are strongly discouraged going forward.

## Service folder structure

Each service folder follows a consistent structure regardless of whether it's ARM or data-plane:

- **ARM services**: `specification/<organization>/resource-manager/<RPNS>/<service>`
- **Data-plane services**: `specification/<organization>/data-plane/<service>`

### Contents of a service folder

A service folder contains the following elements:

**TypeSpec files** (for TypeSpec-based services):
- `main.tsp` - TypeSpec entry point
- `tspconfig.yaml` - TypeSpec compilation configuration (includes OpenAPI/SDK emitter options)
- Additional `*.tsp` files for the service
- `examples/<apiVersion>/` - TypeSpec examples organized by API version

**Configuration files**:
- `readme.md` - [AutoRest configuration file][AutoRest config `readme.md` file] (see [uniform versioning article])
- Additional language-specific `readme.md` files for SDK generation

**Generated OpenAPI specs**:
- `stable/` and `preview/` folders containing API version subfolders

The `stable` and `preview` folders  contain OpenAPI specs in the `stable` and `preview` [lifecycle stages][aka.ms/azsdk/api-versions]
respectively, organized in `<apiVersion>` subfolders for each service API version.

### API version folders

The `stable` and `preview` folders contain OpenAPI specs in the respective [lifecycle stages][aka.ms/azsdk/api-versions], organized in `<apiVersion>` subfolders:

**ARM services**:
- `<organization>/resource-manager/<RPNS>/<service>/stable/<apiVersion>`
- `<organization>/resource-manager/<RPNS>/<service>/preview/<apiVersion-preview>`

**Data-plane services**:
- `<organization>/data-plane/<service>/stable/<apiVersion>`
- `<organization>/data-plane/<service>/preview/<apiVersion-preview>`

Each such API version folder directly contains a set of `.json` files containing OpenAPI specs emitted from TypeSpec,
as well as an `examples` child folder with `.json` files having the contents of [`x-ms-examples`] referenced
from the OpenAPI specs.

**Notes**: The examples folder under `<service>` folder is the TypeSpec examples, it's a super set of all apiVersion examples. TypeSpec has a plan to reduce the redundance and are trying to figure out some new design for TypeSpec based examples. 

Read [API versioning guidelines] to learn more.
from the OpenAPI specs.

**Notes: the examples folder under `<service>` folder is the TypeSpec examples, it's a super set of all apiVersion examples. TypeSpec has a plan to reduce the redundance and are trying to figure out some new design for TypeSpec based examples. 

Read [API versioning guidelines] to learn more.

## `specification/common-types`

The special directory of [`specification/common-types`] contains shared definitions that can be reused across all
Azure team services in their `specification` child folders.

## Naming guidelines for `specification` folder contents

- Folder names should be singular (e.g. `keyvault` not `keyvaults` ) -- this removes ambiguity for some non-english speakers.
- Generic folder names should be lower-case.
- Resource Provider Namespace (`<RPNS>`) folders can be PascalCased (e.g. `KeyVault`).
- For file names, any casing is allowed.
- When in doubt, mimic naming of the examples provided in this article.

## Legacy Patterns

### deprecated directory structure for TypeSpec


### deprecated directory structure for services and service groups

Many teams follow a legacy, deprecated directory structure which usually has following differences:

- If a team owns only one service, instead of rooting it in `specification/<organization>/resource-manager/<RPNS>/<service>`,
  it is rooted in`specification/<organization>/resource-manager`.
- If a team first owned one service and then expanded to multiple services, 
  it contains mixture of both the deprecated structure (for the first service) as well as the correct structure
  (for the 2nd and following services).

This legacy structure is strongly discouraged going forward.

## Folder Migration

We are currently working on the folder structure migration work, which is to make sure there's no differences between a singular service and multiple services in a legacy director structure so that when the service team introduces the new services, they can easily extend and be parallel in the same folder with existing services.

## Deprecated directory structure and hand-written OpenAPI specs

As mentioned multiple times in this article, for historical reasons, some `specification/<organization>` folders may
violate some of the constraints presented in this article. This includes violations like:

- More deeply nested subfolders than allowed.
- `README.md` placed in a wrong folder (thus incorrectly denoting it as a `service` folder).
- Lack of `<service>` directory for given service path.
- Incorrect lack of `-preview` suffix in `preview` API versions.
- Multiple `<RPNS>` subfolders of `resource-manager` folder.
- Mixing of `stable` and `preview` API versions in the same folder subtree.
- Mixing of multiple API versions in given `README.md` package, including mixing of multiple API version lifecycle stages.

All of the aforementioned cases are considered legacy & deprecated, and are strongly discouraged going forward.

[`specification/common-types`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/common-types
[`specification/containerservice/resource-manager/Microsoft.ContainerService/aks`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/aks
[`x-ms-examples`]: https://azure.github.io/autorest/extensions/#x-ms-examples
[aka.ms/azsdk/api-versions]: https://aka.ms/azsdk/api-versions
[aka.ms/azsdk/typespec]: https://aka.ms/azsdk/typespec
[aka.ms/typespec]: https://aka.ms/typespec
[API versioning guidelines]: https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#api-versioning
[AutoRest config `README.md` file]: https://aka.ms/azsdk/autorest
[glossary]: ./glossary.md
[Resource Provider list]: https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-services-resource-providers#match-resource-provider-to-service
[Specification index]: https://azure.github.io/azure-sdk/releases/latest/all/specs.html
[uniform versioning article]: ./uniform-versioning.md

<!-- Unused references -->
[`specification/confidentialledger`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/confidentialledger
[`specification/containerservice/resource-manager/Microsoft.ContainerService/aks/stable/2024-01-01`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/aks/stable/2024-01-01
[`specification/containerservice/resource-manager/Microsoft.ContainerService/fleet/stable/2023-10-15`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/fleet/stable/2023-10-15
[`specification/containerservice`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice
[`specification/eventgrid`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/eventgrid
[aka.ms/azsdk/autorest]: https://aka.ms/azsdk/autorest
[aks REST reference 2024-01-01]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/aks/stable/2024-01-01
[Azure Kubernetes Fleet Manager]: https://learn.microsoft.com/en-us/azure/kubernetes-fleet/
[fleet REST reference 2023-10-15]:  https://learn.microsoft.com/en-us/rest/api/fleet/operation-groups?view=rest-fleet-2023-10-15
