import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/service.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Inventory;

@added(Versions.v2024_11_01_preview)
@tenantResource
model Service is ProxyResource<ServiceProperties> {
  ...ResourceNameParameter<
    Service,
    KeyName = "serviceId",
    NamePattern = "[a-zA-Z0-9]+[-]*"
  >;
}

@added(Versions.v2024_11_01_preview)
@armResourceOperations
interface Services {
  get is ArmResourceRead<Service>;
  list is ArmResourceListByParent<Service>;
}

@added(Versions.v2024_11_01_preview)
@parentResource(Service)
model LinkedSubscription is ProxyResource<LinkedSubscriptionProperties> {
  ...ResourceNameParameter<
    LinkedSubscription,
    KeyName = "linkedSubscriptionId",
    NamePattern = "[a-zA-Z0-9]+[-]*"
  >;
}

@added(Versions.v2024_11_01_preview)
@armResourceOperations
interface LinkedSubscriptions {
  get is ArmResourceRead<LinkedSubscription>;
  list is ArmResourceListByParent<LinkedSubscription>;
}

@added(Versions.v2024_11_01_preview)
@parentResource(Service)
model ArmNamespace is ProxyResource<ArmNamespaceProperties> {
  ...ResourceNameParameter<
    ArmNamespace,
    KeyName = "namespace",
    NamePattern = "[a-zA-Z0-9]+[-]*"
  >;
}

@added(Versions.v2024_11_01_preview)
@armResourceOperations
interface ArmNamespaces {
  get is ArmResourceRead<ArmNamespace>;
  list is ArmResourceListByParent<ArmNamespace>;
}

@added(Versions.v2024_11_01_preview)
@parentResource(ArmNamespace)
model ResourceType is ProxyResource<ResourceTypeProperties> {
  ...ResourceNameParameter<
    ResourceType,
    KeyName = "resourceType",
    NamePattern = "[a-zA-Z0-9]+[-]*"
  >;
}

@added(Versions.v2024_11_01_preview)
@armResourceOperations
interface ResourceTypes {
  get is ArmResourceRead<ResourceType>;
  list is ArmResourceListByParent<ResourceType>;
}

@added(Versions.v2024_11_01_preview)
@parentResource(Service)
model IcmTenant is ProxyResource<IcmTenantProperties> {
  ...ResourceNameParameter<
    IcmTenant,
    KeyName = "tenantId",
    NamePattern = "[a-zA-Z0-9]+[-]*"
  >;
}

@added(Versions.v2024_11_01_preview)
@armResourceOperations
interface IcmTenants {
  get is ArmResourceRead<IcmTenant>;
  list is ArmResourceListByParent<IcmTenant>;
}

@added(Versions.v2024_11_01_preview)
@parentResource(IcmTenant)
model IcmTeam is ProxyResource<IcmTeamProperties> {
  ...ResourceNameParameter<
    IcmTeam,
    KeyName = "teamName",
    NamePattern = "[a-zA-Z0-9]+[-]*"
  >;
}

@added(Versions.v2024_11_01_preview)
@armResourceOperations
interface IcmTeams {
  get is ArmResourceRead<IcmTeam>;
  list is ArmResourceListByParent<IcmTeam>;
}

@added(Versions.v2024_11_01_preview)
@parentResource(Service)
model LinkedEntraApplication
  is ProxyResource<LinkedEntraApplicationProperties> {
  ...ResourceNameParameter<
    LinkedEntraApplication,
    KeyName = "appId",
    NamePattern = "[a-zA-Z0-9]+[-]*"
  >;
}

@added(Versions.v2024_11_01_preview)
@armResourceOperations
interface LinkedEntraApplications {
  get is ArmResourceRead<LinkedEntraApplication>;
  list is ArmResourceListByParent<LinkedEntraApplication>;
}

@added(Versions.v2024_11_01_preview)
@parentResource(Service)
model ServiceHierarchy is ProxyResource<ServiceHierarchyProperties> {
  ...ResourceNameParameter<
    ServiceHierarchy,
    KeyName = "serviceHierarchy",
    NamePattern = "[a-zA-Z0-9]+[-]*"
  >;
}

@added(Versions.v2024_11_01_preview)
@armResourceOperations
interface ServiceHierarchies {
  get is ArmResourceRead<ServiceHierarchy>;
  list is ArmResourceListByParent<ServiceHierarchy>;
}

@added(Versions.v2024_11_01_preview)
@parentResource(ServiceHierarchy)
model ServiceInstance is ProxyResource<ServiceInstanceProperties> {
  ...ResourceNameParameter<
    ServiceInstance,
    KeyName = "instanceName",
    NamePattern = "[a-zA-Z0-9]+[-]*"
  >;
}

@added(Versions.v2024_11_01_preview)
@armResourceOperations
interface ServiceInstances {
  get is ArmResourceRead<ServiceInstance>;
  list is ArmResourceListByParent<ServiceInstance>;
}
