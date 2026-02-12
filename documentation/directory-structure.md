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
    - [Data-plane services: `data-plane` folders](#data-plane-services-data-planeservice-folders)
  - [Service folder structure](#service-folder-structure)
    - [Contents of a service folder](#contents-of-a-service-folder)
    - [`<apiVersion>` folders](#apiVersion-folders)
  - [`specification/common-types`](#specificationcommon-types)
  - [Naming guidelines for `specification` folder contents](#naming-guidelines-for-specification-folder-contents)
  - [Legacy and deprecated patterns](#legacy-and-deprecated-patterns)
  - [Current migration efforts](#current-migration-efforts)
  - [Existing violations and historical context](#existing-violations-and-historical-context)

# Azure REST API Specification Directory Structure

This article provides a comprehensive guide to the recommended directory structure and folder layout for Azure REST API specifications within the `specification` folder. The structure outlined here is designed to support both ARM (Azure Resource Manager) and data-plane services while maintaining compatibility with both TypeSpec-based and OpenAPI-based API development workflows.

> [!IMPORTANT]
> The structure described in this article is the **recommended standard** for all new Azure services. While some existing services may follow legacy patterns for historical reasons, all new services must adopt this structure. We are actively working on migrating legacy patterns to align with these guidelines.

## Key concepts and terminology

To better understand the directory structure, it's essential to familiarize yourself with these key concepts as defined in the [glossary]:

- **Service**: A customer-facing Azure service (e.g., Azure Key Vault, Azure Container Registry)
- **Organization**: The Azure team or group responsible for one or more services
- **Resource Provider Namespace (RPNS)**: The ARM namespace for resource management operations (e.g., `Microsoft.KeyVault`)
- **API Version**: All Azure services use the YYYY-MM-DD(-preview) format for consistent versioning.

## Overview of the folder structure

The `specification` folder follows a hierarchical organization designed to accommodate both ARM and data-plane services. The structure ensures clear separation between different service types while maintaining consistency across all Azure service specifications.

```
specification/
└── <organization>/
    ├── cspell.yaml                     # Spell-check configuration
    ├── resource-manager/               # ARM services
    │   └── <RPNS>/                    # Resource Provider Namespace
    │       ├── <service1>/             # Individual service
    │       └── <service2>/             # Individual service
    └── data-plane/                    # Data-plane services
        ├── <service1>/                 # Individual service
        └── <service2>/                 # Individual service
```

**Organization structure:**

Each organization folder contains up to two main directories:

- **One `resource-manager/<RPNS>/` folder** for ARM services (where `<RPNS>` is the Resource Provider Namespace) containing **one or more** `<service>` folders
- **One `data-plane/` folder** for non-ARM APIs containing **one or more** `<service>` folders

**Important notes:**
- Organizations may have only ARM services, only data-plane services, or both
- The presence of both directories is not mandatory - it depends on the services offered by the organization

### ARM services: `resource-manager/<RPNS>` folder

The `<organization>/resource-manager/<RPNS>` folder corresponds to an ARM **Resource Provider (RP) namespace**. This namespace defines the scope of resource management operations for the organization's ARM services.

**Example structure:**
- RPNS example: `Microsoft.Automation`
- Full path: `specification/containerservice/resource-manager/Microsoft.ContainerService/aks`
- Service: `aks` service within the `Microsoft.ContainerService` ARM Resource Provider namespace

For a complete list of Resource Providers, see the [Resource Provider list].

> [!NOTE]
> **Legacy pattern to avoid**: Many Azure teams with a single ARM service historically placed it directly in `specification/<organization>/resource-manager/` instead of following the proper `specification/<organization>/resource-manager/<RPNS>/<service>` structure. This legacy pattern is deprecated and strongly discouraged for new services.

### Data-plane services: `data-plane` folders

The `<organization>/data-plane` folder contains data-plane service APIs, which differ from ARM services in several key ways:

**Key characteristics:**
- Contains data-plane service APIs (not ARM service APIs)
- No Resource Provider Namespace (`<RPNS>`) concept applies
- Each service gets its own folder directly under `data-plane/`
- Simpler structure: `<organization>/data-plane/<service>`

Each `<organization>/data-plane` folder contains one or more `<service>` folders corresponding to the data-plane services owned by the organization.

> [!NOTE]
> **Legacy patterns to avoid**: Some organizations historically used additional grouping folders like `<organization>/data-plane/<groupingDir>/<service>` or prefixed service names with `Azure.<SomeService>` or `Microsoft.<SomeService>`. These legacy patterns are deprecated and strongly discouraged for new services.

## Service folder structure

Every service folder follows a consistent structure regardless of whether it's an ARM or data-plane service. This consistency simplifies navigation and tooling across all Azure services.

**Standard service folder paths:**
- **ARM services**: `specification/<organization>/resource-manager/<RPNS>/<service>`
- **Data-plane services**: `specification/<organization>/data-plane/<service>`

### Contents of a service folder

Each service folder contains a standardized set of files and directories organized by their purpose and the development approach used (TypeSpec vs. OpenAPI).

A service folder contains the following elements:

**TypeSpec files** (for TypeSpec-based services):
- `main.tsp` - Main TypeSpec entry point for the service
- `tspconfig.yaml` - TypeSpec compilation configuration with OpenAPI/SDK emitter options
- Additional `*.tsp` files - Supporting TypeSpec files for the service
- `examples/<apiVersion>/` - TypeSpec examples organized by API version

**README and configuration files**:
- `readme.md` - Central file that groups APIs into different tags for tooling purposes
- `readme.lang.md` - Language-specific README files for SDK generation (deprecated when TypeSpec is used)

**Generated OpenAPI specifications**:
- `stable/<apiVersion>/` - Contains stable API version specifications
- `preview/<apiVersion>/` - Contains preview API version specifications

The `stable` and `preview` folders contain OpenAPI specifications in their respective [lifecycle stages][aka.ms/azsdk/api-versions], organized in `<apiVersion>` subfolders for each service API version.

### `<apiVersion>` folders

API version folders reflect the actual service API version, following Azure's standard `YYYY-MM-DD(-preview)` format for consistent versioning across all services.

**Folder structure by service type:**

**ARM services**:
- `<organization>/resource-manager/<RPNS>/<service>/stable/<YYYY-MM-DD>`
- `<organization>/resource-manager/<RPNS>/<service>/preview/<YYYY-MM-DD-preview>`

**Data-plane services**:
- `<organization>/data-plane/<service>/stable/<YYYY-MM-DD>`
- `<organization>/data-plane/<service>/preview/<YYYY-MM-DD-preview>`

**Contents of each API version folder:**
- `.json` files containing OpenAPI specifications (typically emitted from TypeSpec)
- `examples/` subfolder containing `.json` files with [`x-ms-examples`] content referenced from the OpenAPI specifications

> [!NOTE]
> **TypeSpec examples organization**: The `examples/` folder under the `<service>` directory contains TypeSpec examples and serves as a superset of all API version examples. The TypeSpec team is actively working on new designs to reduce redundancy in example organization.

For detailed information about API versioning practices, see the [API versioning guidelines].

## `specification/common-types`

The [`specification/common-types`] directory serves a special purpose in the repository structure, containing shared definitions that can be reused across all Azure service specifications.

**Purpose and usage:**
- Contains common models, types, and operations used across multiple Azure services
- Enables consistency and reduces duplication across service specifications
- Provides standardized definitions for common Azure patterns

**Important limitations:**
When you need to share definitions beyond those available in [`specification/common-types`], you must duplicate them in each service's own folder. This requirement ensures that each service maintains independent control over the versioning lifecycle of shared definitions.

**Best practice for managing shared definitions:**
To minimize the maintenance burden of duplicate copies, service teams can implement a shared ownership pattern:

1. **Designate an owner service** - The service that creates or updates the shared models becomes the owner.
2. **Create a `sharable/` folder** - The owner service creates this folder to make definitions available for copying.
3. **Use `copyFrom*Sharable` folders** - Other services create these folders to indicate copied content that should not be edited directly.

**Example structure:**

```diff
specification/compute/resource-manager/Microsoft.Compute/
├── ComputeRP
+│   ├── sharable/
│   ├── *.tsp
│   ├── main.tsp
│   ├── tspconfig.yaml
│   ├── readme.md
│   ├── preview/
│   └── stable/
├── RecommenderRP
+    ├── copyFromComputeSharable
    ├── *.tsp
    ├── main.tsp
    ├── tspconfig.yaml
    ├── readme.md
    ├── preview/
    └── stable/
```

## Naming guidelines for `specification` folder contents

Consistent naming conventions across the repository improve readability and reduce ambiguity. Follow these guidelines when creating new folders and files:

**Folder naming rules:**
- Use singular forms (e.g., `keyvault` not `keyvaults`) to eliminate ambiguity for non-English speakers
- Generic folder names should be lowercase
- Resource Provider Namespace (`<RPNS>`) folders may use PascalCase (e.g., `KeyVault`)

**File naming rules:**
- Any casing is acceptable for file names
- Follow the patterns established in existing examples when unsure

**Best practice:** When in doubt about naming conventions, refer to the examples provided throughout this document.

## Legacy and deprecated patterns

Due to the evolutionary nature of the Azure REST API specifications repository, many existing services follow deprecated directory structures that do not conform to the current recommended guidelines. Understanding these legacy patterns is important for maintenance and migration efforts.

> [!IMPORTANT]
> **All new services must follow the recommended structure** outlined in this document. Existing services are being migrated over time to align with the current standards.

### Summary of deprecated patterns

The following patterns exist in the repository for historical reasons but are **strongly discouraged** for new services:

#### ARM services - deprecated patterns:
- **Single service without RPNS folder**: Placing a single ARM service directly in `specification/<organization>/resource-manager/` instead of `specification/<organization>/resource-manager/<RPNS>/<service>`
- **Mixed directory structures**: When teams expand from one to multiple services, mixing the old flat structure (for the original service) with the correct nested structure (for new services)
- **Multiple RPNS subfolders**: Having multiple `<RPNS>` subfolders under `resource-manager/` folder

#### Data-plane services - deprecated patterns:
- **Additional grouping folders**: Using extra nesting like `<organization>/data-plane/<groupingDir>/<service>` instead of `<organization>/data-plane/<service>`
- **Service name prefixes**: Prefixing service names with `Azure.<SomeService>` or RPNS `Microsoft.<SomeService>` or similar patterns
- **RPNS-style folders**: Using Resource Provider-style folder names under `data-plane/`

**General deprecated patterns:**
- **Incorrect folder nesting**: Deeper nesting than the recommended structure allows
- **Misplaced README files**: Placing `readme.md` files in incorrect folders or incorrectly identifying them as service folders
- **Missing service directories**: Absence of proper `<service>` directory structure
- **Incorrect API version format**: Using formats other than YYYY-MM-DD(-preview) for API versioning
- **API version naming issues**: Missing `-preview` suffix in preview API versions
- **Mixed API versions**: Combining `stable` and `preview` API versions in the same folder subtree
- **Mixed lifecycle stages**: Combining multiple API version lifecycle stages in the same `readme.md` configuration

## Current migration efforts

We are actively working to finish the entire repository migration to align with the new directory structure guidelines by March 2026. This comprehensive migration effort aims to eliminate inconsistencies between legacy patterns and the recommended structure.

### Migration objectives

**What we're standardizing:**
- **Consistent service patterns**: Ensuring uniform folder structure regardless of whether a team has one or multiple services
- **Eliminating mixed structures**: Converting teams that use a combination of old and new patterns to the recommended structure
- **Simplifying tooling**: Reducing complexity in engineering systems by implementing a single, consistent structure
- **Improving discoverability**: Making it easier to find and navigate service specifications across the repository

### Guidelines for service teams

Refer to [Widget] as an example of the suggested folder structure and if any concerns,

**For new services:**
- Always use the recommended structure described in this document

**For existing services:**
- When folder migration PRs are merged, they may conflict with ongoing PRs. Follow the [Conflict Resolve Guide] to handle these conflicts.

## Contact Us

If you have any questions regarding folder structure and Azure Service Versioning Guideline, you can reach out by:
- [TypeSpec Discussion] Channel.
- Email to azversioning@service.microsoft.com


> [!WARNING]
> **All violations described above are considered legacy and deprecated.** They are strongly discouraged for any new development and will be addressed through the ongoing migration efforts.

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
[uniform versioning guideline]: https://github.com/Azure/azure-rest-api-specs/wiki/Azure-Service-Versioning-Guideline
[Conflict Resolve Guide]: https://github.com/Azure/azure-rest-api-specs/wiki/Resolving-Folder-Migration-Conflicts:-A-Guide-for-PR-Authors
[Widget]: https://github.com/Azure/azure-rest-api-specs/blob/main/specification/widget
[TypeSpec Discussion]: https://teams.microsoft.com/l/channel/19%3A906c1efbbec54dc8949ac736633e6bdf%40thread.skype/TypeSpec%20Discussion?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47