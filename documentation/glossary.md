# Glossary

This article defines some of the terms used in the articles under `documentation` directory.

## Resource type

In case of ARM, a `service` is a collection of `resource types` or `resource type groups`.

## Service
 
A `service` is a set of operation endpoints (typically HTTP REST API endpoints) that [**version uniformly**][uniform versioning article].

A `service` corresponds to a cohesive, uniformly versioned experience for the customer with HTTP REST API surface,
documentation portal and language SDKs. For example, [Azure Kubernetes Service].

In this repository, an ARM service has a path of form:

`specification/<azureTeamName>/resource-manager/<RPNS>/<service>`

where `<RPNS>` stands for ARM **Resource Provider (RP) namespace**.

A data-plane service has a path of form:

`specification/<azureTeamName>/data-plane/<namespace>/<service>`

> [!NOTE]
> Some existing services follow different directory structure layouts.
> All such layouts are legacy, deprecated, and not allowed going forward.

For example, [`specification/containerservice/resource-manager/Microsoft.ContainerService/aks`] 
is a folder for the `aks` service within the `Microsoft.ContainerService` ARM Resource Provider namespace.

You can learn more about how a `service` maps to its directory in the [directory structure article].

## Service group

A `service group` is a set of services that share a common ARM **Resource Provider (RP) namespace**, `RPNS`.

A `service group` has a path of form:

`specification/<azureTeamName>/resource-manager/<RPNS>`

as such, it corresponds to ARM Resource Provider Namespace.

Example service group:

[`specification/containerservice/resource-manager/Microsoft.ContainerService`]

which is composed of two services, [`aks`] and [`fleet`].

> [!NOTE]
> Previously `service group` was erroneously used in reference to services like `aks`. This is incorrect.

You can learn more about how a `service group` maps to its directory in the [directory structure article].

## Uniform versioning

See [uniform versioning article].

[`aks`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/aks
[`fleet`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/fleet
[`specification/containerservice/resource-manager/Microsoft.ContainerService/aks`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/aks
[`specification/containerservice/resource-manager/Microsoft.ContainerService`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService
[Azure Kubernetes Service]: https://learn.microsoft.com/en-us/azure/aks/
[directory structure article]: ./directory-structure.md
[uniform versioning article]: ./uniform-versioning.md
