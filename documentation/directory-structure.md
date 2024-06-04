| Short Link: | [aka.ms/azsdk/spec-dirs](https://aka.ms/azsdk/spec-dirs) |
|--|--|

<!-- 
Table of contents generated with VSCode Markdown All in One:
https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one 
-->

- [`specification` directory structure](#specification-directory-structure)
  - [`specification` folder](#specification-folder)
  - [`resource-manager` and `data-plane` folders](#resource-manager-and-data-plane-folders)
  - [AutoRest configuration `README.md` files](#autorest-configuration-readmemd-files)
  - [`stable` and `preview` folders](#stable-and-preview-folders)
  - [A complete example directory structure of `specification/<azureTeam>`](#a-complete-example-directory-structure-of-specificationazureteam)
  - [Naming guidelines for `specification` folder contents](#naming-guidelines-for-specification-folder-contents)
  - [`specification/common-types`](#specificationcommon-types)
  - [Advanced scenario: service group](#advanced-scenario-service-group)
    - [Service group `common-types`](#service-group-common-types)
    - [Versioning services in a service group](#versioning-services-in-a-service-group)
  - [Deprecated structure and hand-written OpenAPI specs](#deprecated-structure-and-hand-written-openapi-specs)
# `specification` directory structure


This article describes the directory structure / folder layout of the `specification` folder.
You may be also interested in following:
- [Specification index]
- [Resource Provider list]

> [!IMPORTANT]
> The structure described in this article is strictly enforced. There exist some exceptions for historical reasons.
> These exceptions are not allowed going forward.

## `specification` folder

The `specification` folder is the root folder for all service specifications.

Each child of the `specification` folder corresponds to a `service` specification for given Azure team. Here we denote such folder as `<azureTeam>`.
In advanced cases for big teams the `<azureTeam>` folder can host multiple services, known as `service group`.
Read [the relevant section](#advanced-scenario-service-group) for details.

Given `<azureTeam>` has following structure:

- `<azureTeam>/<typeSpecFolder>` (multiple folders)
- `<azureTeam>/resource-manager`
- `<azureTeam>/data-plane`

The `<azureTeam>/<typeSpecFolder>` folders contain the TypeSpec specification for the given `service` or `service group`.
You can find details on the name and contents of these folders in [TypeSpec directory structure].
You can learn more about TypeSpec at [aka.ms/azsdk/typespec] and [aka.ms/typespec].

## `resource-manager` and `data-plane` folders

The `<azureTeam>/resource-manager` contains the ARM OpenAPI specifications emitted from TypeSpec in `<azureTeam>/<typeSpecFolder>`.

The `resource-manager` folder has exactly one child folder whose name matches the **Resource Provider (RP) Namespace** (`<RPNS>`), 
such as `Microsoft.Automation` (full list of namespaces is [here][Resource Provider list]).
There is 1 to 1 correspondence between an RP and an RP namespace.
There must be **exactly one** RP namespace folder under given `resource-manager` folder.
We denote such folder as `resource-manager/<RPNS>`.

The `<azureTeam>/data-plane` contains the data-plane OpenAPI specifications emitted from TypeSpec in `<typeSpecFolder>`. 
The `data-plane` folder has no child `<RPNS>` folder. However, it can have a set of `<dataPlaneSubfolder>` folders.

## AutoRest configuration `README.md` files

Both the `<azureTeam>/resource-manager` and `<azureTeam>/data-plane` folders must contain an AutoRest configuration file, `README.md`.
Learn more about this file at [aka.ms/azsdk/autorest].

<!-- This paragraph about README contents is a bit vague. We should improve it, eventually. -->

Each `README.md` describes a single `service` and is used as an SDK package and documentation for each version of the service.
Inside the `README.md` file there are lists of paths to OpenAPI spec `.json` files making up given service version.

> [!NOTE]
> All OpenAPI specs for given service version (i.e. the list of paths in given `input-file:` block in the `README.md`) must have the same service version,
> which also means being in the same [API version lifecycle stage][aka.ms/azsdk/api-versions].

## `stable` and `preview` folders

Both `<azureTeam>/resource-manager/<RPNS>` and `<azureTeam>/data-plane/<dataPlaneSubfolder>` folders, in addition to containing `README.md`, also can contain
`stable` and `preview` folders. These folders contain OpenAPI specs in the `stable` and `preview` [lifecycle stages][aka.ms/azsdk/api-versions]
respectively, organized in `<apiVersion>` subfolders for each service API version. For example, `<azureTeam>/resource-manager/<RPNS>/stable/<apiVersion>` or
`<azureTeam>/data-plane/<dataPlaneSubfolder>/preview/<apiVersion-preview>`.

Each such API version folder directly contains a set of `.json` files containing OpenAPI specs emitted from TypeSpec, as well as an `examples` child folder
with `.json` files having the contents of [`x-ms-examples`] referenced from the OpenAPI specs.

## A complete example directory structure of `specification/<azureTeam>`

Putting everything together discussed, the directory structure of a singular `specification/<azureTeam>/` is as follows:

``` yaml
/<typeSpecFolder>1/...
/<typeSpecFolder>2/... # multiple '<typeSpecFolder>' folders

/resource-manager/README.md
/resource-manager/<RPNS>/stable/<apiVersion1>/*.json
/resource-manager/<RPNS>/stable/<apiVersion1>/examples/*.json
                               /<apiVersion2>/ ... # multiple '<apiVersion>' folders
/resource-manager/<RPNS>/preview/<apiVersion3-preview>/*.json
/resource-manager/<RPNS>/preview/<apiVersion3-preview>/examples/*.json
                                /<apiVersion4-preview>/ ... # multiple '<apiVersion-preview>' folders

/data-plane/README.md
/data-plane/<dataPlaneSubfolder1>/stable/<apiVersion5>/*.json
/data-plane/<dataPlaneSubfolder1>/stable/<apiVersion5>/examples/*.json
                                        /<apiVersion6>/ ... # multiple '<apiVersion>' folders
/data-plane/<dataPlaneSubfolder1>/preview/<apiVersion7-preview>/*.json
/data-plane/<dataPlaneSubfolder1>/preview/<apiVersion7-preview>/examples/*.json
                                         /<apiVersion8-preview>/ ... # multiple '<apiVersion-preview>' folders
           /<dataPlaneSubfolder2>/ ... # multiple '<dataPlaneSubfolder>' folders

```

As a specific example of the above, consider [`specification/confidentialledger`] `<azureTeam>` which has the following structure:

``` yaml

# ===== <typeSpecFolder>s

/Microsoft.CodeTransparency/
/Microsoft.ManagedCcf/

# ===== data-plane

/data-plane/README.md

# ----- <dataPlaneSubfolder>: Microsoft.CodeTransparency

/data-plane/Microsoft.CodeTransparency/preview/2024-01-11-preview
/data-plane/Microsoft.CodeTransparency/preview/2024-01-11-preview/examples

# ----- <dataPlaneSubfolder>: Microsoft.ConfidentialLedger

/data-plane/Microsoft.ConfidentialLedger/stable
/data-plane/Microsoft.ConfidentialLedger/stable/2022-05-13
/data-plane/Microsoft.ConfidentialLedger/stable/2022-05-13/examples

/data-plane/Microsoft.ConfidentialLedger/preview
/data-plane/Microsoft.ConfidentialLedger/preview/2023-01-18-preview
/data-plane/Microsoft.ConfidentialLedger/preview/2023-01-18-preview/examples
# ... more previews here

# ----- <dataPlaneSubfolder>: Microsoft.ManagedCcf

/data-plane/Microsoft.ManagedCcf/preview/2023-06-01-preview
/data-plane/Microsoft.ManagedCcf/preview/2023-06-01-preview/examples

# ===== resource-manager

/resource-manager/README.md

# ----- resource-manager RP Namespace (<RPNS>): Microsoft.ConfidentialLedger

/resource-manager/Microsoft.ConfidentialLedger/stable/2022-05-13
/resource-manager/Microsoft.ConfidentialLedger/stable/2022-05-13/examples

/resource-manager/Microsoft.ConfidentialLedger/preview/2023-06-28-preview
/resource-manager/Microsoft.ConfidentialLedger/preview/2023-06-28-preview/examples
# ... more previews here
/resource-manager/Microsoft.ConfidentialLedger/preview/2020-12-01-preview
/resource-manager/Microsoft.ConfidentialLedger/preview/2020-12-01-preview/examples

```

For another example, see [`specification/eventgrid`].

## Naming guidelines for `specification` folder contents

- Folder names should be singular (e.g. `keyvault` not `keyvaults` ) -- this removes ambiguity for some non-english speakers.
- Generic folder names should be lower-case.
- Resource Provider Namespace (`<RPNS>`) folders can be PascalCased (e.g. `KeyVault`).
- For file names, any casing is allowed.
- When in doubt, mimic naming of the examples provided in this article.

## `specification/common-types`

The special directory of [`specification/common-types`] contains shared definitions that can be reused across all Azure team services in their
`specification` child folders.

## Advanced scenario: service group

In case of big Azure teams, their `specification/<azureTeam>` hosts multiple services, together known as `service group`.
The main difference between one service and a service group is how they are presented to Azure customers:
One service has one SDK package and one documentation portal, while a service group has separate SDK package for each service and separate documentation.

For example, [`specification/containerservice`] is a `service group` for both `aks` and `fleet` services.

The doc for `aks` is [Azure Kubernetes Service]. It points to aks REST reference e.g. for [API version `2024-01-01`][aks REST reference 2024-01-01],
which corresponds to [`specification/containerservice/resource-manager/Microsoft.ContainerService/aks/stable/2024-01-01`].

The doc for `fleet` is [Azure Kubernetes Fleet Manager]. It point to fleet REST reference, e.g. for [API version `2023-10-15`][fleet REST reference 2023-10-15],
which corresponds to [`specification/containerservice/resource-manager/Microsoft.ContainerService/fleet/stable/2023-10-15`].

Using our example, note the most important directory structure difference of a `service group` scenario as compared to singular `service`:

- The `resource-manager/Microsoft.ContainerService` folder has multiple child service folders which contain `stable` and `preview` folders for each service,
  instead of directly containing `stable` and `preview` folders.
- Each of the `aks` and `fleet` subfolders have their own `README.md` file, instead of there being one `README.md` in the `resource-manager` folder.
  As a result, the SDKs of these services are separate.

### Service group `common-types`

A service group can also introduce its own set of `common-types` which are too general to be shared across all Azure teams but common enough to be
shared across all services in given service group. For an example, see [`Microsoft.Compute/common-types`].

### Versioning services in a service group

The versioning policy for API and SDK packages applies independently to each service in the service group.
This means that each service in the service group must obey the same versioning rules as it were a singular service.
However, multiple separate services can have different versioning cycles, including different SDK packages. Refer to the aforementioned `aks` and `fleet`
services for examples of different versioning cycles in a service group.

## Deprecated structure and hand-written OpenAPI specs

As mentioned at the beginning of this article, for historical reasons, some `specification/<azureTeam>` folders may
violate some of the constraints presented in this article. This includes violations like:

- More deeply nested subfolders than allowed.
- Incorrect lack of `-preview` suffix in `preview` API versions.
- Mixing of `stable` and `preview` API versions in the same folder subtree.
- Mixing of multiple API versions in given `README.md` package, including mixing of multiple API version lifecycle stages.

In addition, some `<azureTeam>` folders have OpenAPI specs that have been written manually instead of emitted from TypeSpec. 
In some cases the folders have mixture of manually-written and TypeSpec-emitted OpenAPI specs.

All of the aforementioned cases are considered legacy and are not allowed going forward.

[`Microsoft.Compute/common-types`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/compute/resource-manager/Microsoft.Compute/common-types/
[`specification/common-types`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/common-types
[`specification/confidentialledger`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/confidentialledger
[`specification/containerservice/resource-manager/Microsoft.ContainerService/aks/stable/2024-01-01`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/aks/stable/2024-01-01
[`specification/containerservice/resource-manager/Microsoft.ContainerService/fleet/stable/2023-10-15`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/fleet/stable/2023-10-15
[`specification/containerservice`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice
[`specification/eventgrid`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/eventgrid
[`x-ms-examples`]: https://azure.github.io/autorest/extensions/#x-ms-examples
[aka.ms/azsdk/api-versions]: https://aka.ms/azsdk/api-versions
[aka.ms/azsdk/autorest]: https://aka.ms/azsdk/autorest
[aka.ms/azsdk/typespec]: https://aka.ms/azsdk/typespec
[aka.ms/typespec]: https://aka.ms/typespec
[aks REST reference 2024-01-01]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/aks/stable/2024-01-01
[Azure Kubernetes Fleet Manager]: https://learn.microsoft.com/en-us/azure/kubernetes-fleet/
[Azure Kubernetes Service]: https://learn.microsoft.com/en-us/azure/aks/
[fleet REST reference 2023-10-15]:  https://learn.microsoft.com/en-us/rest/api/fleet/operation-groups?view=rest-fleet-2023-10-15
[Resource Provider list]: https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-services-resource-providers#match-resource-provider-to-service
[Specification index]: https://azure.github.io/azure-sdk/releases/latest/all/specs.html
[TypeSpec directory structure]: https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/typespec-structure-guidelines.md
