# Glossary

This article defines some of the terms used in the articles under `documentation` directory.

## Resource type

In case of ARM, a `service` is a collection of `resource types` or `resource type groups` that version uniformly in perpetuity.

## Organization

A `organization` is a set of services that group together, those services normally share a common ARM **Resource Provider (RP) namespace**, `RPNS`.

Each `service` in given `organization` must [**version uniformly**][Azure Service Versioning Guide] but each `service`
within a `organization` can have their own version lifecycle.

A `organization` has a path of form:

`specification/<organization>`


## Resource Provider Namespace (RPNS)

The resource provider namespace is the service ARM API resource provider namespace. In the folder structure guideline, A `RPNS` has a path form of 

`specification/<organization>/resource-manager/<RPNS>`


## Service

An Azure service is a set of operations that version uniformly (in perpetuity). See [Azure Service Versioning Guide] for more details.

In specs repository, an ARM service has a path of form:

`specification/<organization>/resource-manager/<RPNS>/<service>`

A data-plane service has a path of form:

`specification/<organization>/data-plane/<service>`

> [!NOTE]
> Some existing services follow different directory structure layouts.
> All such layouts are legacy, deprecated, and strongly discouraged going forward.

For example, [`specification/containerservice/resource-manager/Microsoft.ContainerService/aks`]
is a folder for the `aks` service within the `Microsoft.ContainerService` ARM Resource Provider namespace.

You can learn more about how a `service` maps to its directory in the [directory structure article].


## Additional Resources

[Azure Service Versioning Guide]: https://github.com/Azure/azure-rest-api-specs/wiki/Azure-Service-Versioning-Guideline
[`aks`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/aks
[`fleet`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/fleet
[`specification/containerservice/resource-manager/Microsoft.ContainerService/aks`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService/aks
[`specification/containerservice/resource-manager/Microsoft.ContainerService`]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/containerservice/resource-manager/Microsoft.ContainerService
[Azure Kubernetes Service]: https://learn.microsoft.com/en-us/azure/aks/
[directory structure article]: ./directory-structure.md
