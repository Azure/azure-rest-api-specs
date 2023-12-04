# Azure REST API Specifications

## Description

This repository is the canonical source for REST API specifications for Microsoft Azure. You can learn more about it [here](https://eng.ms/docs/products/azure-developer-experience/design/api-specs-pr/api-repos).

## Getting started

If you're a Microsoft employee looking for information about all of the repositories and steps for Azure SDK Libraries Releases, go to the [aka.ms/azsdk/join](https://aka.ms/azsdk/join).

External Contributors can read [Getting Started with OpenAPI Specifications](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Getting%20started%20with%20OpenAPI%20specifications.md).

<!-- Please check the [announcements page](https://github.com/Azure/azure-rest-api-specs/wiki/Announcements) for any new updates since your last visit.-->

### Terminology

- **Offerings**, **Skus**, and **Features** - These are distinct entities represented in Eco Manager and Service Tree.  While the Offering/Sku/Feature entities and hierarchy represent the externally marketed product, **service/components** entities in service tree represent corresponding engineering entities that together power these external products.  Refer to [Product Taxonomy](https://dev.azure.com/msazure/AzureWiki/_wiki/wikis/AzureWiki.wiki/40783/Service-Tree-Product-Taxonomy) for details.

- **Resource Provider** - When a service onboards new functionality onto ARM, it is required to complete [Resource Provider Registration](https://armwiki.azurewebsites.net/rp_onboarding/ResourceProviderRegistration.html).  For existing **Resource Provider to Service Mapping**, refer to [Match resource provider to service](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-services-resource-providers#match-resource-provider-to-service)*

## Directory Structure

The structure of the directory should strictly follow these rules:

1. **Profile**: The profile folder contains the profiles' definition files. The profile definition targets for hybrid applications that could run on Azure Stack general availability versions and Azure Cloud.

2. **Specification**: This folder is the root folder for all Specs (Management Plane and Data Plane) related documents.

3. **{RP-Name} Folders** - each resource provider should have at least one separate folder.
    > If multiple folders are required? It depends on the following considerations:
    >
    > - An RP folder leads to a separate SDK package. Is it expected to have separate SDK packages for different service/component entities?
    > - Service/component entities in one folder share the same versioning cycle. Can service/component entities in one folder share the same version label, and upgrade together in the future?
    > - Specification files and AutoRest configuration files in one RP folder are better to refer to files in the same RP folder. Note: Entity type definition that needs to be referred cross RP folders should be placed and maintained under the folder [**common-types**](https://github.com/Azure/azure-rest-api-specs#common-types).
    > - For more considerations, you may consult the reviewer in API design review. To initiate the review, Please submit an [Azure SDK intake questionnaire](https://aka.ms/sdk-apex).

    RP folders may contain resource manager or data plane TypeSpec "specs". TypeSpec is a language for describing cloud service APIs and generating other API description languages, client and service code, documentation, and other assets. Explore more by visiting the tutorial in the TypeSpec repo: [TypeSpec tutorial](http://aka.ms/cadlTutorial). You can also ask questions for providing feedback in the internal Teams channel [TypeSpec Discussion](https://teams.microsoft.com/l/channel/19%3a906c1efbbec54dc8949ac736633e6bdf%40thread.skype/Cadl%2520Discussion%2520%25F0%259F%2590%25AE?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47).

    For more information about the structure of TypeSpec files in the repo see [TypeSpec repo structure](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/typespec-structure-guidelines.md).
   
5. **'resource-manager' and 'data-plane' Folders**: the RPs can put specs in one of two categories: `resource-manager` (for ARM resources) and `data-plane` (for everything else). There should be an AutoRest configuration file (`readme.md`) for the RP inside both of these folders when present.

6. **'Microsoft.{ARMNamespace}' Folders**: the folders are only required under the 'resource-manager' folder, which means only management-plane API specs require to have ARM Namespace in the file path. For ARM Namespace and ARM onboarding, please refer to the ARM wiki of [RP Onboarding](https://armwiki.azurewebsites.net/rp_onboarding/process/onboarding.html#0-on-boarding-meeting).

7. **'preview' and 'stable' Folders**: This maps to the service/component lifecycle stage: Preview and GA. For example, if a service is in Preview stage, no matter Private Preview or Public Preview, the API specs of the service should be placed in the `preview` folder. If the service is GAed, but a component is in preview, then the API version contains the preview component entity should be placed in the `preview` folder as well.  The `stable` folder should contain API versions of a GAed service and all GAed components.

    > How's the Azure Breaking Change Policy apply to API specs in `preview` and `stable` folders? In fact, it is more relevant to if the repo is public or private.
    > - API specs with components or resource types in Private Preview, or Limited Public Preview (behind [AFEC](https://armwiki.azurewebsites.net/rp_onboarding/afec/FeatureExposureControl.html) or managing visible subscriptions) are better to launch PR review in the private repository, aka., [azure-rest-api-specs-pr](https://github.com/Azure/azure-rest-api-specs-pr). And these API specs are free of breaking changes.
    >
    > - On the other hand, everything public in the main branch of the public repository, aka., [azure-rest-api-specs](https://github.com/Azure/azure-rest-api-specs), no matter in the `preview` folder or in the `stable` folder, should be treated as contract with Azure customers, must follow [Azure Breaking Changes Policy](http://aka.ms/AzBreakingChangesPolicy).

8. **API Versions Folders**: this folder is the direct child of the `preview` or `stable` folder. This folder contains the REST API Specs, and the `examples` folder.

9. **'examples' Folders**: the example folder will contain the x-ms-examples files. it will reside under the APIs or Resources' version folders as different APIs or Resource types version can have different examples.

> Note:  some general guidance for folder names, and file names under `specification`:
>
> - Folder names should be singular (ie, 'profile' not 'profiles' ) -- this removes ambiguity for some non-english speakers.
> - Generic folder names should be lower-case
> - Namespace folders can be PascalCased (ie, "KeyVault")
> - Files are whatever case you think is good for your soul.


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

### Folder Structure for Service Group

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

### common-types

Specification files and AutoRest configuration files in one RP folder are better to refer to files in the same RP folder. Entity type definition that can be shared cross resource providers or services should to be placed and maintained either under the folder [**common-types**](https://github.com/Azure/azure-rest-api-specs#common-types) under specification, or under **common-types** folder of service group folder structure. The former supports the entity type sharing cross rp folders, while the latter supports the entity type sharing cross components or services under the same rp folder.

Refer to [Resource-Management](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/common-types/resource-management) common types for example.

## Next steps

The next step in the process after a spec is completed is to generate SDKs and API reference documentation. If you're a Microsoft employee, go to the [Azure SDK - Internal Wiki](https://aka.ms/jointhesdk) for more information.

External Contributors can read [Getting Started with OpenAPI Specifications](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Getting%20started%20with%20OpenAPI%20specifications.md).

---
_This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments._

test pr 5
