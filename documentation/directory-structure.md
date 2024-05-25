| Short Link: | [aka.ms/azsdk/spec-dirs](https://aka.ms/azsdk/spec-dirs) |
|--|--|

<!-- 
Table of contents generated with VSCode Markdown All in One:
https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one 
-->

- [`specification` directory structure](#specification-directory-structure)
  - [Key concepts](#key-concepts)
  - [`specification` folder](#specification-folder)
    - [`<typeSpecSrc>` folders](#typespecsrc-folders)
    - [`resource-manager/<RPNS>` folder](#resource-managerrpns-folder)
    - [`data-plane/<namespace>` folders](#data-planenamespace-folders)
  - [Service folder structure](#service-folder-structure)
  - [`specification/common-types`](#specificationcommon-types)
  - [Naming guidelines for `specification` folder contents](#naming-guidelines-for-specification-folder-contents)
  - [About legacy, deprecated directory structure for services and service groups](#about-legacy-deprecated-directory-structure-for-services-and-service-groups)
  - [Migrating from a singular service to service group in a legacy directory structure](#migrating-from-a-singular-service-to-service-group-in-a-legacy-directory-structure)
  - [Deprecated directory structure and hand-written OpenAPI specs](#deprecated-directory-structure-and-hand-written-openapi-specs)

# `specification` directory structure

This article describes the directory structure / folder layout of the `specification` folder.
You may be also interested in following:
- [Specification index]
- [Resource Provider list]

> [!IMPORTANT]
> The structure described in this article is strictly enforced. There exist some exceptions for historical reasons.
> These exceptions are not allowed going forward.

## Key concepts

The directory structure is a reflection of a few key concepts.

Familiarize yourself with the concepts of `service`, `service group` and `uniform versioning`
as explained in the [glossary].

## `specification` folder

The `specification` folder is the root folder for all `service` specifications.

Each child of the `specification` folder corresponds to `<azureTeam>`. 
All the `service` (see [glossary]) specifications owned by that team are rooted in their `<azureTeam>` folder.

Given `<azureTeam>` folder has following structure:

- `<azureTeam>/<typeSpecSrc>` (multiple `<TypeSpecSrc>` folders are allowed)
- `<azureTeam>/resource-manager/<RPNS>` (exactly one `<RPNS>` folder is allowed)
- `<azureTeam>/data-plane/<namespace>` (multiple `<namespace>` folders are allowed)

### `<typeSpecSrc>` folders

The `<azureTeam>/<typeSpecSrc>` folders contain the TypeSpec specifications for the services owned by the team.

The content of these folders is used as input to emit OpenAPI specifications
placed within `<azureTeam>/resource-manager/<RPNS>` and `<azureTeam>/data-plane/<namespace>` folders.

> [!NOTE]
> Some services may not have `<typeSpecSrc>` folders. In such case, these services OpenAPI specs are hand-written.
> This is legacy, deprecated practice and is not allowed going forward.

You can find details on the name and contents of `<typeSpecSrc>` folders in [TypeSpec directory structure].
You can learn more about TypeSpec at [aka.ms/azsdk/typespec] and [aka.ms/typespec].

### `resource-manager/<RPNS>` folder

The `<azureTeam>/resource-manager/<RPNS>` is a folder corresponding to **Resource Provider (RP) namespace**.

An example RPNS is `Microsoft.Automation`. A list of RPs can be found in the [Resource Provider list].

This folder corresponds to a `service group` (see [glossary]) for all ARM services owned by the team.

An `<RPNS>` folder has one or more children `<service>` folders corresponding to the services belonging 
to the `service group` represented by the `<RPNS>` folder.

For example, [`specification/containerservice/resource-manager/Microsoft.ContainerService/aks`] 
is a folder for the `aks` service within the `Microsoft.ContainerService` ARM Resource Provider namespace.

> [!NOTE]
> Many Azure teams that have one ARM service instead of rooting it in `specification/<azureTeam>/resource-manager/<RPNS>/<service>` root it
> in `specification/<azureTeam>/resource-manager`. This is legacy, deprecated structure and is not allowed going forward.

In addition, the `<RPNS>` folder may contain `common-types` child folder that usually is of form `common-types/v<versionInt>/common.json` and contains types
shared across API versions. E.g. [`Microsoft.Compute/common-types`].

### `data-plane/<namespace>` folders

The set of `<azureTeam>/data-plane/<namespace>` folders is the equivalent of `<azureTeam>/resource-manager/<RPNS>` but with following distinctions:

- `<azureTeam>/data-plane` pertains to data-plane service APIs, not ARM service APIs.
- `<azureTeam>/data-plane/<namespace>` is a set of one or more folder, not only one.

## Service folder structure

As described above, ARM service folder path is:

`specification/<azureTeam>/resource-manager/<RPNS>/<service>`

while data-plane service folder path is:

`specification/<azureTeam>/data-plane/<namespace>/<service>`.

A service folder has the following elements:

- The [AutoRest config `README.md` file]. See also section about it in [uniform versioning article].
- Additional AutoRest config `README.md` files specific to given language SDK.
- The `stable` and `preview` folders if applicable.

The `stable` and `preview` folders  contain OpenAPI specs in the `stable` and `preview` [lifecycle stages][aka.ms/azsdk/api-versions]
respectively, organized in `<apiVersion>` subfolders for each service API version.

For example:
- `<azureTeam>/resource-manager/<RPNS>/<service>/stable/<apiVersion>`
- `<azureTeam>/resource-manager/<RPNS>/<service>/preview/<apiVersion-preview>`
- `<azureTeam>/data-plane/<namespace>/<service>/stable/<apiVersion>`
- `<azureTeam>/data-plane/<namespace>/<service>/preview/<apiVersion-preview>`

Each such API version folder directly contains a set of `.json` files containing OpenAPI specs emitted from TypeSpec, as well as an `examples` child folder
with `.json` files having the contents of [`x-ms-examples`] referenced from the OpenAPI specs.

Read [API versioning guidelines] to learn more.

## `specification/common-types`

The special directory of [`specification/common-types`] contains shared definitions that can be reused across all Azure team services in their
`specification` child folders.

## Naming guidelines for `specification` folder contents

- Folder names should be singular (e.g. `keyvault` not `keyvaults` ) -- this removes ambiguity for some non-english speakers.
- Generic folder names should be lower-case.
- Resource Provider Namespace (`<RPNS>`) folders can be PascalCased (e.g. `KeyVault`).
- For file names, any casing is allowed.
- When in doubt, mimic naming of the examples provided in this article.

## About legacy, deprecated directory structure for services and service groups

Many teams follow a legacy, deprecated directory structure which usually has following differences:

- If a team owns only one service, instead of rooting it in `specification/<azureTeam>/resource-manager/<RPNS>/<service>`, it is rooted in
  `specification/<azureTeam>/resource-manager`.
- If a team first owned one service and then expanded to a service group, 
  it contains mixture of both the deprecated structure (for the first service) as well as the correct structure (for the 2nd and following services).

This legacy structure is not allowed going forward.

## Migrating from a singular service to service group in a legacy directory structure

In case an Azure SDK team owns a singular service following the legacy, deprecated layout, and wants to expand to a full
service group, it can do the following:

- Keep the existing service as-is, without any changes.
- Introduce the new services using the new, correct structure.

## Deprecated directory structure and hand-written OpenAPI specs

As mentioned multiple times in this article, for historical reasons, some `specification/<azureTeam>` folders may
violate some of the constraints presented in this article. This includes violations like:

- More deeply nested subfolders than allowed.
- `README.md` placed in a wrong folder (thus incorrectly denoting it as a `service` folder).
- Lack of `<service>` directory for given service path.
- Incorrect lack of `-preview` suffix in `preview` API versions.
- Mixing of `stable` and `preview` API versions in the same folder subtree.
- Mixing of multiple API versions in given `README.md` package, including mixing of multiple API version lifecycle stages.

In addition, some `<azureTeam>` folders have OpenAPI specs that have been written manually instead of emitted from TypeSpec. 
In some cases the folders have mixture of manually-written and TypeSpec-emitted OpenAPI specs.

All of the aforementioned cases are considered legacy & deprecated, and are not allowed going forward.

[`Microsoft.Compute/common-types`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/compute/resource-manager/Microsoft.Compute/common-types/
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
[TypeSpec directory structure]: https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/typespec-structure-guidelines.md
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
