# Specification directory Structure

<!-- 
Table of contents generated with VSCode Markdown All in One:
https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one 
-->

- [Specification directory Structure](#specification-directory-structure)
  - [`specification` folder](#specification-folder)
  - [Resource provider (`rp`) folder](#resource-provider-rp-folder)
    - [TypeSpec sources](#typespec-sources)
  - [`resource-manager` and `data-plane` folders](#resource-manager-and-data-plane-folders)
  - [Resource provider namespace (`rpnamespace`) folders](#resource-provider-namespace-rpnamespace-folders)
  - [Resource provider namespace (`rpnamespace`) folders layout](#resource-provider-namespace-rpnamespace-folders-layout)
  - [API version (`api_version`) folders layout](#api-version-api_version-folders-layout)
    - [`examples` folder](#examples-folder)
  - [Naming guidelines for `specification` folder contents](#naming-guidelines-for-specification-folder-contents)
  - [Example layout of a `specification` folder](#example-layout-of-a-specification-folder)
  - [Folder Structure for service groups](#folder-structure-for-service-groups)
  - [common-types](#common-types)
  - [FAQ](#faq)
    - [Should my service team have one or multiple resource provider folders?](#should-my-service-team-have-one-or-multiple-resource-provider-folders)

This article described the directory structure / folder layout of the `specification` folder.

The layout described in this article is strictly enforced. There exist
some exceptions for historical reasons. These exceptions are not allowed going forward.

## `specification` folder

The `specification` folder is the root folder for all TypeSpec and OpenAPI specs 
and related documents. Each child of `specification` corresponds to a `resource provider`.
There is a special case of a `service group`: see [Folder Structure for service groups](#folder-structure-for-service-groups).

## Resource provider (`rp`) folder

Each child folder of the `specification` folder is a root of given `resource provider`.

Example resource providers root folders:

- [`specification/containerservice`]
- [`specification/confidentialledger`]

Given resource provider `rp` has following structure,
for multiple values of `rpnamespace` (`rpnamespace` stands for **resource provider namespace**; see [relevant section](#resource-provider-namespace-rpnamespace-folders)):

- `specification/rp/rpnamespace`
- `specification/rp/data-plane/rpnamespace`
- `specification/rp/resource-manager/rpnamespace`

### TypeSpec sources

The `specification/rp/rpnamespace` directories contain TypeSpec sources.  
To learn about TypeSpec, see [aka.ms/azsdk/typespec] and [aka.ms/typespec].  
To learn these directories structure, see [TypeSpec directory structure] article.  
The rest of this article pertains to the `specification` directory structure 
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

## API version (`api_version`) folders layout

`api_version` within given `rpnamespace/stable` or `rpnamespace/preview` is a versioned set of OpenAPI specs. `stable` and `preview` correspond to the lifecycle stages of the API versions within. Learn more about API versions, their directory layout and their lifecycle stages at [aka.ms/azsdk/pr-api-versions].

Each `api_version` folder is a direct child of the `preview` or `stable` folder. This folder contains the REST OpenAPI Specs `.json` files, and the `examples` folder.

### `examples` folder

Each `api_version/examples` folder contains [`x-ms-examples`] files.

## Naming guidelines for `specification` folder contents

- Folder names should be singular (e.g. `keyvault` not `keyvaults` ) -- this removes ambiguity for some non-english speakers.
- Generic folder names should be lower-case.
- Namespace (`rpnamespace`) folders can be PascalCased (e.g. `KeyVault`).
- Files are whatever case you think is good for your soul.

## Example layout of a `specification` folder

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
|            |   \---preview
|            |       \---2017-04-24-preview
|            |           \---examples
|            \---readme.md
```

In the example above:

`rp` folders are `automation`, `batch`, `playfab`.  
TypeSpec folders are `specification/playfab/Playfab`.  
`rpnamespace` names present are: `Microsoft.Automation` (in `automation` rp), `Microsoft.Batch` (in `batch` rp) and `Microsoft.Playfab` (in `playfab` rp).

## Folder Structure for service groups

In some existing cases the `specification/rp` folder is not a root of one resource provider,
but of a **service group**. A service group combines multiple resource providers,
from multiple teams, in one `specification/rp` folder. In this situation the layout
constraints described in this article are partially violated, e.g. given `rpnamespace` instead
of having `stable` and `preview` as direct children, has extra layer of "sub-service" name, like `rpnamespace/compute`. This scenario is not allowed going forward and existing teams will migrate away from it, eventually.

Examples of an existing services groups: 
- [`specification/compute`]
- [`specification/workloads`]


## common-types

Specification files and AutoRest configuration files in one resource provider folder are better to refer to files in the same resource provider folder. Entity type definition that can be shared cross resource providers or services should to be placed and maintained either under the folder [**common-types**](https://github.com/Azure/azure-rest-api-specs#common-types) under specification, or under **common-types** folder of service group folder structure. The former supports the entity type sharing cross rp folders, while the latter supports the entity type sharing cross components or services under the same rp folder.

Refer to [Resource-Management](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/common-types/resource-management) common types for example.

## FAQ

### Should my service team have one or multiple resource provider folders?

Should given service team add multiple `specification/rp` folders, or just one?
It depends on the following considerations:
    
- An rp folder leads to a separate SDK package. Is it expected to have separate SDK packages for different services?
- Service in one folder share the same versioning cycle. Can service in one folder share the same version label, and upgrade together in the future?
- Specification files and AutoRest configuration files in one rp folder are better to refer to files in the same rp folder. Note: Entity type definition that needs to be referred cross rp folders should be placed and maintained under the folder [**common-types**](https://github.com/Azure/azure-rest-api-specs#common-types).
- For more considerations, you may consult the reviewer in API design review. To initiate the review, Please submit an [Azure SDK intake questionnaire](https://aka.ms/sdk-apex).


[`specification/containerservice`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice
[`specification/confidentialledger`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/confidentialledger
[aka.ms/azsdk/typespec]: https://aka.ms/azsdk/typespec
[aka.ms/typespec]: https://aka.ms/typespec
[TypeSpec directory structure]: https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/typespec-structure-guidelines.md
[RP Onboarding]: https://armwiki.azurewebsites.net/rp_onboarding/process/onboarding.html#0-on-boarding-meeting

[aka.ms/azsdk/pr-api-versions]: https://aka.ms/azsdk/pr-api-versions
[`x-ms-examples`]: https://azure.github.io/autorest/extensions/#x-ms-examples

[`specification/workloads`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/workloads/resource-manager/Microsoft.Workloads

[`specification/compute`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/compute/resource-manager/Microsoft.Compute
