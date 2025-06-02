- [Guidelines for TypeSpec project repositories](#guidelines-for-typespec-project-repositories)
  - [Objective](#objective)
  - [Overview](#overview)
  - [Service folder structure](#service-folder-structure)
  - [Libraries for service groups](#libraries-for-service-groups)
- [Specification versioning](#specification-versioning)
  - [Organizing services in folders](#organizing-services-in-folders)
  - [Utilizing feature branches](#utilizing-feature-branches)
  - [Publishing specifications](#publishing-specifications)

# Guidelines for TypeSpec project repositories

## Objective

This document provides guidelines for managing TypeSpec projects for Azure. It offers direction to service teams about where and how to check in these projects, and to tooling teams on how to locate and use them. TypeSpec "specs" may include service-specific functions, decorators, and more, raising them to the level of a library. These are supported as first-class citizens.

## Overview

The structure of TypeSpec project repositories starts with the [specification](https://aka.ms/azsdk/spec-dirs) folder, serving as the root for all service specifications. Each child folder, denoted as `<azureTeam>`, corresponds to a service specification for a specific Azure team. In more complex scenarios, such as larger teams, the `<azureTeam>` folder can host multiple services, forming what is known as a service group.

The `<azureTeam>` folder can include multiple `<typeSpecSrc>` folders, each containing the TypeSpec specification for a given service or service group.

A given TypeSpec project folder can represent various scenarios:

- An SDK and service spec (common for small services)
- Only a service spec
- An SDK spec that aggregates many service specs (one SDK to many microservices)
- An SDK spec that extracts a part of a large service spec (many SDKs to a single large service)
- A shared library that doesn't represent a service spec or an SDK

For more information about TypeSpec, visit [aka.ms/azsdk/typespec](aka.ms/azsdk/typespec) and [aka.ms/typespec](aka.ms/typespec).

Here are some examples of TypeSpec project repository structures:
```
-> specification
   -> confidentialledger
      -> ConfidentialLedger               (data-plane SDK + service)
      -> data-plane                       (OpenAPI)
      -> resource-manager                 (OpenAPI)
   -> compute
      -> Compute.Management               (management SDK + service)
      -> Compute.Management.Shared        (shared)
      -> Compute.CloudService.Management  (service)
      -> Compute.Diagnostic.Management    (service)
      -> Compute.Disk.Management          (service)
      -> Compute.Gallery.Management       (service)
      -> Compute.Skus.Management          (service)
      -> data-plane                       (OpenAPI)
      -> resource-manager                 (OpenAPI)
   -> keyvault
      -> KeyVault.Certificates            (data-plane SDK + service)
      -> KeyVault.Keys                    (data-plane SDK + service)
      -> KeyVault.Secrets                 (data-plane SDK + service)
      -> KeyVault.Management              (management SDK + service)
      -> data-plane                       (OpenAPI)
      -> resource-manager                 (OpenAPI)
```
## Service folder structure

The service folder contains the complete TypeSpec library specification for a service, which may include custom linter rules, methods, etc. The folder name should correspond to the RP-name, without the leading "Azure" or "Microsoft" prefix. Additional naming conventions include:

- Folder names should be singular and lower-case.
- Resource Provider Namespace (`<RPNS>`) folders can be PascalCased.
- `Management` at the end of the service RP-name indicates a management (resource manager) library.
- `Shared` at the end of the name indicates a shared library. If a management library has a shared component (unlikely), `Shared` should follow `Management`.

All services and service group libraries are modeled as TypeSpec packages. All packages defined in the repo are **unpublished**. Only packages from the `typespec-azure` repo are published.

Each service folder should minimally include:

- `tspconfig.yaml`
- `main.tsp` file
- Supporting `*.tsp` files
- `examples/` folder containing example JSON files

Authors are free to use additional folders for organizing `tsp` files as needed.

To differentiate between folders defining a service, an SDK, or both, refer to the `tspconfig.yaml`. This file should only contain SDK configuration data for projects intending to generate SDKs. Use the [sample project](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml) as a template.

Services should **not** have a `package.json` directly in the TypeSpec project directory. Instead, they should use the `package.json` in the root directory of the repo for installing any required dependencies. This root-level `package.json` should only depend on the `@azure-tools/typespec-autorest` and `@azure-tools/typespec-apiview` emitters.

SDK language-specific emitters won't have direct dependencies in the spec repo. Instead, they will come from the language SDK repo itself for generation. For more information, see the example [emitter-package.json](https://github.com/Azure/azure-sdk-for-net/blob/main/eng/emitter-package.json).

Services aiming to generate an SDK need to provide emitter configuration for all the SDK emitters in
 the `tspconfig.yaml` file. See the following samples for more details:

- [management plane sample](https://aka.ms/azsdk/tspconfig-sample-mpg)
- [data plane sample](https://aka.ms/azsdk/tspconfig-sample-dpg)

## Libraries for service groups

The service group library concept allows a group of services to share common models, linter rules, templates, etc. Service libraries can reference unpublished service _group_ libraries via relative path import in `*.tsp`.
```
import "../Contoso.WidgetManager.Shared";
```
Service group libraries **should** use versioning decorators and spec packages should reference them as versioned dependencies. Service group libraries **should not** have a `tspconfig.yaml` file as they are not intended to generate SDKs.

A shared library is considered to be on the same level as other packages within the service family, similar to how we currently handle services with a "Shared" package. This approach allows for an unlimited number of shared packages. See the [Sample Project](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml) for reference.

```
-> specification
   -> contosowidgetmanager
      -> Contoso.WidgetManager            (data-plane)
      -> Contoso.WidgetManager.Management (management)
      -> Contoso.WidgetManager.Shared     (shared)
```

Here's an example of how Cognitive Services might use multiple shared libraries:

```
-> specification
   -> cognitiveservices
      -> Language.TextAnalytics  (data-plane)
      -> Language.QnA            (data-plane)
      -> Language.Shared         (shared)
      -> Vision.ComputerVision   (data-plane)
      -> Vision.CustomVision     (data-plane)
      -> Vision.Shared           (shared)
```
# Specification versioning

TypeSpec incorporates a versioning library that enables a single specification to represent multiple versions via projections. This allows service teams to manage General Availability (GA) service versions as well as both public and private preview service versions. 

The versioning library is particularly effective for handling changes between GA service releases, which are typically long-lasting, stable, and backward compatible. However, it's less optimized for preview versions, which tend to have a shorter lifespan and often involve significant breaking changes from one version to another.

## Organizing services in folders

The service folder houses the TypeSpec files for the service package. As services transition to TypeSpec, they can begin by modeling their versioned TypeSpec based on their most recent stable OpenAPI. Existing services **DO NOT** need to recreate past service versions unless there's a business necessity. 

Upcoming versions should be incorporated into the specification using the appropriate versioning decorators. The first version in the specification doesn't require version annotations since it's considered the baseline, meaning it doesn't make assumptions about previous versions as it's not aware of them.

## Utilizing feature branches

Feature branches enable the comparison of a proposed change directly against the main branch. They should be used for both GA and preview API version development. Within the feature branch, the service team should modify the TypeSpec in the service folder directly, as this aligns well with GitHub's diffing strategy.

## Publishing specifications

The simplest method to publish a specification is to merge the Pull Request (PR) that alters the TypeSpec in the service folder. This offers the easiest experience for projecting the TypeSpec and generating artifacts, including server-side code generation.

If a major break renders a specification with version annotations unusable, the specification could be reset to a base version (likely the breaking one) and versioning could continue from there. The commit hash or tag that represented the specification prior to the reset would need to be tracked to regenerate older versions of the specification. If an older version of the specification needed an update but was no longer represented on the latest commit on `main`, a servicing branch would be needed to update the hash pointers to the commit on that servicing branch.

This option is only appropriate for _public_ previews. Private previews should remain exclusively in a branch (either in the public or private repository) until they become a public preview.
