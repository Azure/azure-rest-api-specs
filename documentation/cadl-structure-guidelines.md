- [Repository Guidelines for Cadl Specs](#repository-guidelines-for-cadl-specs)
  - [Purpose](#purpose)
  - [Repository](#repository)
  - [Structure Overview](#structure-overview)
  - [Service Folders](#service-folders)
    - [Packages](#packages)
    - [Structure](#structure)
  - [Service Family Libraries](#service-family-libraries)
  - [Sample Project](#sample-project)
- [Spec Versioning](#spec-versioning)
    - [Service Folder](#service-folder)
    - [Working in Feature Branches](#working-in-feature-branches)
    - [Publishing Specs](#publishing-specs)

# Repository Guidelines for Cadl Specs

## Purpose

We need to formulate a strategy for checking in actual Cadl service specs for Azure. Service teams need to know where
and how to check these in and tooling needs to know how to find and consume them. While OpenAPI specs traditionally have been just spec
documents, Cadl "specs" could include service-specific functions, decorators and so forth that elevate them to the level of a
library, and to maximize the benefits of Cadl, this approach needs to be supported as a first-class citizen.

## Repository

Cadl can co-exist with Swagger within the existing `azure-rest-api-specs` repository. This approach will make it easier to generate Swagger artifacts without needing to sync between repos at the downside of having to live with any baggage associated with the repo as it ages. There are currently over 1,000 issues and 500 open PRs in this repo.

## Structure Overview

This proposal strives to align with [Azure SDK Repo Structure Guidelines](https://azure.github.io/azure-sdk/policies_repostructure.html).

We eliminate the distinction between data-plane and resource-manager, treating all packages as siblings under the service family folder. This is what the SDKs do today. The legacy `data-plane` and `resource-manager` folders where Swagger specs live will remain.

A given Cadl folder could represent any of the following scenarios:

- an SDK and service spec (simplest, common for small services)
- a service spec only
- an SDK spec that aggregates many small service specs (one SDK to many microservices)
- an SDK spec that extracts a portion of a large service spec (many SDKs to a single large service)
- a shared library that represents neither a service spec nor an SDK

Examples below:

```
-> specification
   -> confidentialledger
      -> ConfidentialLedger               (data-plane SDK + service)
      -> data-plane                       (swagger)
      -> resource-manager                 (swagger)
   -> compute
      -> Compute.Management               (mgmt SDK + service)
      -> Compute.Management.Shared        (shared)
      -> Compute.CloudService.Management  (service)
      -> Compute.Diagnostic.Management    (service)
      -> Compute.Disk.Management          (service)
      -> Compute.Gallery.Management       (service)
      -> Compute.Skus.Management          (service)
      -> data-plane                       (swagger)
      -> resource-manager                 (swagger)
   -> keyvault
      -> KeyVault.Certificates            (data-plane SDK + service)
      -> KeyVault.Keys                    (data-plane SDK + service)
      -> KeyVault.Secrets                 (data-plane SDK + service)
      -> KeyVault.Management              (mgmt SDK + service)
      -> data-plane                       (swagger)
      -> resource-manager                 (swagger)
```

## Service Folders

The service folder contains the entire Cadl library specification for a service, which could include custom linter rules, methods, etc.

The folder name should correspond to the RP-name, but dropping the leading "Azure" or "Microsoft" prefix. Two additional naming conventions should be following:

- `Management` at the end of the service RP-name indicates a management (resource manager) libarary.
- `Shared` at the end of the name indicates a shared library. If a management library has a shared component (unlikely), `Shared` should follow `Management`.

### Packages

All services and service family libraries are modeled as Cadl packages, since you must install supporting librarie for proper tooling support. Per this proposal, all packages defined in the repo would be **unpublished**. Only packages in `cadl-azure` would be published. We will annotate the packages with `"private": true` in the `package.json` file to prevent publishing these to npm.

All packages defined in this repo would use the `@cadl-api-spec` scope and use a lowercased, dashed form of the service namespace (ex: `@cadl-api-spec/azure-storage-blob`).

### Structure

Each package should have the following minimum structure:

- `cadl-project.yaml`
- `package.json`
- `main.cadl` file
- Supporting `*.cadl` files
- `examples/` folder for example JSON files

Authors may use folders as desired for organizing cadl files.

Additionally, packages which wish to define custom linter rules or otherwise use TypeScript must place any `*.ts` files under a `src/` folder. Within the `src/` folder, the author may use as many subfolders as desired for organizing code.

To distinguish between folders which define a service, an SDK, or both, one can look to the `cadl-project.yaml` and/or the `package.json`.

- SDKs will take dependencies on the `@azure-tools/cadl-dpg` library, as well as SDK-specific emitters such as `@azure-tools/cadl-python` and configure their options within `cadl-project.yaml` but the emitter version should not be configured within `cadl-project.yaml`, and it should be configured globally in SDK repo instead.
- SDKs _may_ have a sidecar file to customize how the SDK is shaped. Folders that describe service definitions only will not have a sidecar file. _Note: the absence of a sidecar does not mean that a folder does not describe an SDK, but the presence of one means it is an SDK._
- Services will take a dependency on `@azure-tools/autorest` and configure the emitter in `cadl-project.yaml`.

## Service Family Libraries

The service family library concept allows a family of services to share common models, linter rules, templates, etc.

Service libraries can reference unpublished service _family_ libraries via relative path import in `*.cadl`:

```cadl
import "../Contoso.WidgetManager.Shared";
```

While this would permit services from importing any service library described in the specs repo, as a matter of policy we should probably avoid that and have tooling to detect this scenario. Service family libraries **should** use versioning decorators and spec packages should reference them as versioned dependencies. Tooling would need to ensure that changes to service family libraries does not result in unexpected changes to any service version. One way to do this would be to diff the projection of the service versions on the `main` branch against the projection of the service versions that result from the change.

We treat the shared library as a sibling with other packages within the service family. This is similar to what we currently do for services that have a "Shared" package and would allow an arbitrary number of shared packages. A shared library folder should not contain `cadl-project.yaml` and `package.json` as it's not requried to be released. See [Sample Project](#sample-project) for reference.

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
## Sample Project

Here's a [cadl-sample-project](./cadl-sample-project) to demonstrate the files and folders supposed to be included when check in to this `azure-rest-api-specs` repository.

# Spec Versioning

Cadl has a versioning library which allows a single spec to represent multiple versions through projections. Service teams have GA service versions as well as public and private Preview service versions. The versioning library is currently optimized for the kinds of changes allowed between GA service releases: long-lived, stable, backward compatible changes. Preview versions are shorter-lived and often have wildly breaking changes from one version to the next, for which the versioning library is not optimized.

### Service Folder

The service folder contains the Cadl files for the service package. Services transitioning to Cadl may simply begin by modeling their versioned Cadl from their latest stable Swagger. Existing services DO NOT need to model past service versions unless a business rationale exists. Future versions should be added to the spec using the necessary versioning decorators. The inital version in the spec need not feature version annotations since it is considered the baseline (i.e. it makes no implications about prior versions since it does not know about them).

### Working in Feature Branches

Feature branches enable diffing the proposed change directly against the main branch. Feature branches should be used for either GA or preview API version development. On the feature branch, the service team should directly modify the cadl within the service folder as this works well with GitHub's diffing strategy.

### Publishing Specs

The purest approach to publish a spec is to merge the PR that modifies the Cadl spec in the service folder. This is the simplest experience for projecting the Cadl and generating artifacts, including server-side codegen.

In the event that a major break makes it infeasible to continue using a spec with version annotations, the spec could be reset to some base version (likely the breaking one) and continue versioning from there. The commit hash or tag that represented the spec prior to the reset would need to be tracked in order to regenerate older versions of the spec. At this point, if an update was needed to an older version of the spec no longer represented on the latest commit on `main`, we would need a servicing branch and update the hash pointers to the commit on that servicing branch.

This option is only suitable for _public_ previews. Private previews should live solely in a branch (in either the public or private repo) until/unless they become a public preview.
