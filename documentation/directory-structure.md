# Directory Structure

- [Directory Structure](#directory-structure)
  - [specification](#specification)
  - [resource provider](#resource-provider)
  - [`resource-manager` and `data-plane` folders](#resource-manager-and-data-plane-folders)
  - [Resource provider namespace (`rpnamespace`) folders](#resource-provider-namespace-rpnamespace-folders)
  - [Resource provider namespace (`rpnamespace`) folders layout](#resource-provider-namespace-rpnamespace-folders-layout)
  - [API version (`api_version`) folders layout](#api-version-api_version-folders-layout)
    - [`examples` folder](#examples-folder)
  - [General folder naming guidance for contents of `specification` folder](#general-folder-naming-guidance-for-contents-of-specification-folder)
  - [Folder Structure for Service Group](#folder-structure-for-service-group)
  - [common-types](#common-types)
  - [FAQ](#faq)
    - [Are multiple RP folders required?](#are-multiple-rp-folders-required)


The the directory structure (aka folder layout) of this repository should strictly follow these rules:

## specification

The `specification` folder is the root folder for all TypeSpec and OpenAPI specs 
and related documents. Each child of `specification` corresponds to a `resource provider`.

## resource provider

Each child folder of a `specification` folder is a root of given `resource provider`.

Example resource provider families root folders:

- [`specification/containerservice`]
- [`specification/confidentialledger`]

Given resource provider `rp` has following structure,
for multiple values of `rpnamespace` (`rpnamespace` stands for **resource provider namespace**, see relevant section):

- `specification/rp/rpnamespace`
- `specification/rp/data-plane/rpnamespace`
- `specification/rp/resource-manager/rpnamespace`

The `specification/rp/rpnamespace` directories contain TypeSpec sources.  
To learn about TypeSpec, see [aka.ms/azsdk/typespec] and [aka.ms/typespec].  
To learn these directories structure, see [TypeSpec directory structure] article.  
The rest of this article pertains to the `specficiation` directory structure 
**excluding** the contents of `specification/rp/rpnamespace`.


## `resource-manager` and `data-plane` folders

The OpenAPI specs in `specification/rp/resource-manager` pertain to ARM resources while
the OpenAPI specs in `specification/rp/data-plane` pertain to everything else.

There should be an AutoRest configuration file (`readme.md`) at the root of each
of these directories when present.

If TypeSpec sources are present, OpenAPI specs in the `resource-manager`
and `data-plane` folders are generated from TypeSpec sources.

## Resource provider namespace (`rpnamespace`) folders

Each `rpnamespace` folder (whether in `specification/rp`, in `specification/rp/data-plane` or `specification/rp/resource-manager`) corresponds to a resource provider namespace. 

Its name is of form `Microsoft.<ARMNamespace>`. Strictly speaking specs in `data-plane`
folder are not required to be organized by `rpnamespace`.

For ARM Namespace and ARM onboarding, please refer to the ARM wiki of [RP Onboarding].

## Resource provider namespace (`rpnamespace`) folders layout

Each `rpnamespace` folder within `resource-manager` and `data-plane` may contain the following, for multiple values of `api_version`:

`rpnamespace/stable/api_version`  
`rpnamespace/preview/api_version`

If the contents of `data-plane` folder are not organized by `rpnamespace`, we treat
the `data-plane` folder itself as the "default namespace" for the purposes of describing
the required layout.

Here `api_version` is an versioned set of OpenAPI specs. `stable` and `preview` correspond to the lifecycle stages of the API versions within. Learn more about API version and their lifecycle
stages at [aka.ms/azsdk/pr-api-versions].

## API version (`api_version`) folders layout

Each `api_version` folder is the direct child of the `preview` or `stable` folder. This folder contains the REST OpenAPI Specs `.json` files, and the `examples` folder.

### `examples` folder

Each `api_version/examples` folder contains the `x-ms-examples` files.

## General folder naming guidance for contents of `specification` folder

- Folder names should be singular (e.g. `keyvault` not `keyvaults` ) -- this removes ambiguity for some non-english speakers.
- Generic folder names should be lower-case
- Namespace (`rpnamespace`) folders can be PascalCased (e.g. `KeyVault`)
- Files are whatever case you think is good for your soul.

The structure should appear like so:
```bash
.
\---specification
|    +---automation
|    |   \---resource-manager
|    |       +---Microsoft.Automation
|    |       |   \---stable
|    |       |       \---2015-10-31
|    |       |           \---examples
|    |       \---readme.md
|    +---batch
|    |   +---data-plane
|    |   |   +---stable
|    |   |   |   +---2016-07-01
|    |   |   |   |   \---examples
|    |   |   |   \---2017-01-01
|    |   |   |       \---examples
|    |   |   +---preview
|    |   |   |   \---2017-05-01-preview
|    |   |   |       \---examples
|    |   |   \---readme.md
|    |   \---resource-manager
|    |       +---Microsoft.Batch
|    |       |   \---stable
|    |       |       +---2015-12-01
|    |       |       |   \---examples
|    |       |       +---2017-01-01
|    |       |       |   \---examples
|    |       |       \---2017-05-01
|    |       |           \---examples
|    |       \---readme.md
|    \---playfab
|        +---Playfab
|        |   \---tspconfig.yaml
|        |   \---main.tsp
|        \--resource-manager
|            +---Microsoft.Playfab
|            |   +---stable
|            |   |   \---2017-02-27-preview
|            |   |       \---examples
|            |   \---preview
|            |       \---2017-04-24-preview
|            |           \---examples
|            \---readme.md
```

## Folder Structure for Service Group

If you are working on API specification of a service group, then you may choose to build a folder structure as below. This folder structure brings more flexibility in multiple service teams collaboration, especially supporting:

- To collect API definition of multiple components/services with different versioning cycle in one rp folder
- To share some common entity types among services or components under the same rp folder.

In the following folder structure sample, there is only 'resource-manager' folder. There could be a similar folder structure under 'data-plane' folder, while the sub-component/sub-service folders may not be the same.

Ensure to consult [API Spec Review](https://aka.ms/azsdk/support/specreview-channel) for the first time creating the folder structure or if you want to change current folder structure.

```bash
.
\---specification
|    +---compute
|    |   \---resource-manager
|    |      +---Microsoft.Compute
|    |      |     +---compute
|    |      |     |   \---stable
|    |      |     |        \---2021-11-01
|    |      |     |              +---compute.json
|    |      |     |              +---runCommands.json
|    |      |     |              \---examples
|    |      |     +---sku
|    |      |     |   \---stable
|    |      |     |         \---2021-07-01
|    |      |     |              +---skus.json
|    |      |     |              \---examples
|    |      |     +---disk
|    |      |     |  \---stable
|    |      |     |          \---2021-12-01
|    |      |     |              +---disk.json
|    |      |     |              \---examples
|    |      |     +---gallery
|    |      |     |   \---stable
|    |      |     |         \---2021-10-01
|    |      |     |              +---gallery.json
|    |      |     |              \---examples
|    |      |     +---sharedgallery
|    |      |     |   \---stable
|    |      |     |        \---2021-07-01
|    |      |     |            +---sharedGallery.json
|    |      |     |            +---communityGallery.json
|    |      |     |            \---examples
|    |      |     +---cloudService
|    |      |     |   \---stable
|    |      |     |        \---2021-03-01
|    |      |     |            +---cloudService.json
|    |      |     |            \---examples
|    |      |     \---common-types
|    |      |         \---v1
|    |      |              \---entity-types.json
|    |      |
|    |       \---readme.md
```

If the AutoRest configuration file (aka. the readme.md) is placed out of sub-service/sub-component folders, then there will be only one SDK package that holds all sub-services/sub-components. If the file is placed in each sub-service/sub-component folder, then there will be separate SDK packages of each sub-service/sub-component.  Ensure to consult [Azure SDK ArchBoard](https://aka.ms/azsdk/onboarding/archboardschedule) for SDK packaging strategy when consolidating AutoRest configuration file for SDK generation.

## common-types

Specification files and AutoRest configuration files in one RP folder are better to refer to files in the same RP folder. Entity type definition that can be shared cross resource providers or services should to be placed and maintained either under the folder [**common-types**](https://github.com/Azure/azure-rest-api-specs#common-types) under specification, or under **common-types** folder of service group folder structure. The former supports the entity type sharing cross rp folders, while the latter supports the entity type sharing cross components or services under the same rp folder.

Refer to [Resource-Management](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/common-types/resource-management) common types for example.

## FAQ

### Are multiple RP folders required?

If multiple folders are required? It depends on the following considerations:
    
- An RP folder leads to a separate SDK package. Is it expected to have separate SDK packages for different service/component entities?
- Service/component entities in one folder share the same versioning cycle. Can service/component entities in one folder share the same version label, and upgrade together in the future?
- Specification files and AutoRest configuration files in one RP folder are better to refer to files in the same RP folder. Note: Entity type definition that needs to be referred cross RP folders should be placed and maintained under the folder [**common-types**](https://github.com/Azure/azure-rest-api-specs#common-types).
- For more considerations, you may consult the reviewer in API design review. To initiate the review, Please submit an [Azure SDK intake questionnaire](https://aka.ms/sdk-apex).


[`specification/containerservice`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice
[`specification/confidentialledger`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/confidentialledger
[aka.ms/azsdk/typespec]: https://aka.ms/azsdk/typespec
[aka.ms/typespec]: https://aka.ms/typespec
[TypeSpec directory structure]: https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/typespec-structure-guidelines.md
[RP Onboarding]: https://armwiki.azurewebsites.net/rp_onboarding/process/onboarding.html#0-on-boarding-meeting

[aka.ms/azsdk/pr-api-versions]: https://aka.ms/azsdk/pr-api-versions
