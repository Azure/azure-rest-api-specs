import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./resourcetypes/community/community.tsp";
import "./resourcetypes/virtualEnclave/virtualenclave.tsp";
import "./resourcetypes/workload/workload.tsp";
import "./resourcetypes/catalog/catalog.tsp";
import "./resourcetypes/endpoint/endpoint.tsp";
import "./resourcetypes/internalConnection/internalConnection.tsp";
import "./resourcetypes/externalConnection/externalConnection.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft Mission",
  version: "2023-02-01-preview"
})
@Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Community Model Resource")
model CommunityResource is TrackedResource<CommunityProperties>{
  @key("communityName")
  @segment("communities")
  @path
  @doc("The name of the communityResource Resource")
  name: string;
}

@doc("Virtual Enclave Model Resource")
model EnclaveResource is TrackedResource<VirtualEnclaveProperties> {
  @key("virtualEnclaveName")
  @segment("virtualEnclaves")
  @doc("The name of the enclaveResource Resource")
  @path
  name: string;
}

@doc("Workload Model Resource")
@parentResource(EnclaveResource)
model WorkloadResource is TrackedResource<WorkloadProperties> {
  @key("workloadName")
  @segment("workloads")
  @path
  @doc("The name of the workloadResource Resource")
  name: string;
}

@doc("Catalog Model Resource")
model CatalogResource is TrackedResource<CatalogProperties> {
  @key("catalogName")
  @segment("catalogs")
  @doc("The name of the catalogResource Resource")
  @path
  name: string;
}

@doc("Endpoint Model Resource")
@parentResource(EnclaveResource)
model EndpointResource is TrackedResource<EndpointProperties> {
  @key("endpointName")
  @segment("endpoints")
  @path
  @doc("The name of the endpointResource Resource")
  name: string;
}

@doc("Describes an Internal Connection.")
model InternalConnection is TrackedResource<InternalConnectionProperties> {
  @key("internalConnectionName")
  @segment("internalConnections")
  @doc("The name of the internal connection.")
  @path
  name: string;
}

@doc("Describes an External Connection.")
model ExternalConnection is TrackedResource<ExternalConnectionProperties> {
  @key("externalConnectionName")
  @segment("externalConnections")
  @doc("The name of the external connection.")
  @path
  name: string;
}

@doc("Workload Interface")
@armResourceOperations
interface Workload {
    get is ArmResourceRead<WorkloadResource>;
    createOrUpdate is ArmResourceCreateOrUpdateAsync<WorkloadResource>;
    update is ArmResourcePatchAsync<WorkloadResource, WorkloadProperties>;
    delete is ArmResourceDeleteAsync<WorkloadResource>;
    listByParent is ArmResourceListByParent<WorkloadResource>;
    listBySubscription is ArmListBySubscription<WorkloadResource>;
  }

@doc("Endpoint Interface")
@armResourceOperations
interface Endpoint {
    get is ArmResourceRead<EndpointResource>;
    createOrUpdate is ArmResourceCreateOrUpdateAsync<EndpointResource>;
    update is ArmResourcePatchAsync<EndpointResource, EndpointProperties>;
    delete is ArmResourceDeleteAsync<EndpointResource>;
    listByParent is ArmResourceListByParent<EndpointResource>;
    listBySubscription is ArmListBySubscription<EndpointResource>;
  }

@doc("Virtual Enclave Interface")
@armResourceOperations
interface VirtualEnclave {
    get is ArmResourceRead<EnclaveResource>;
    createOrUpdate is ArmResourceCreateOrUpdateAsync<EnclaveResource>;
    update is ArmResourcePatchAsync<EnclaveResource, VirtualEnclaveProperties>;
    delete is ArmResourceDeleteAsync<EnclaveResource>;
    listByParent is ArmResourceListByParent<EnclaveResource>;
    listBySubscription is ArmListBySubscription<EnclaveResource>;
  }

@doc("Community Interface")
@armResourceOperations
interface Community {
    get is ArmResourceRead<CommunityResource>;
    createOrUpdate is ArmResourceCreateOrUpdateAsync<CommunityResource>;
    update is ArmResourcePatchAsync<CommunityResource, CommunityProperties>;
    delete is ArmResourceDeleteAsync<CommunityResource>;
    listByParent is ArmResourceListByParent<CommunityResource>;
    listBySubscription is ArmListBySubscription<CommunityResource>;
  }

@doc("Catalog Interface")
@armResourceOperations
interface Catalog {
    get is ArmResourceRead<CatalogResource>;
    createOrUpdate is ArmResourceCreateOrUpdateAsync<CatalogResource>;
    update is ArmResourcePatchAsync<CatalogResource, CatalogProperties>;
    delete is ArmResourceDeleteAsync<CatalogResource>;
    listByParent is ArmResourceListByParent<CatalogResource>;
    listBySubscription is ArmListBySubscription<CatalogResource>;
  }

@doc("Internal Connections")
@armResourceOperations
interface InternalConnections {
    get is ArmResourceRead<InternalConnection>;
    createOrUpdate is ArmResourceCreateOrUpdateAsync<InternalConnection>;
    update is ArmResourcePatchAsync<InternalConnection, InternalConnectionProperties>;
    delete is ArmResourceDeleteAsync<InternalConnection>;
    listByParent is ArmResourceListByParent<InternalConnection>;
    listBySubscription is ArmListBySubscription<InternalConnection>;
  }

@doc("External Connections")
@armResourceOperations
interface ExternalConnections {
    get is ArmResourceRead<ExternalConnection>;
    createOrUpdate is ArmResourceCreateOrUpdateAsync<ExternalConnection>;
    update is ArmResourcePatchAsync<ExternalConnection, ExternalConnectionProperties>;
    delete is ArmResourceDeleteAsync<ExternalConnection>;
    listByParent is ArmResourceListByParent<ExternalConnection>;
    listBySubscription is ArmListBySubscription<ExternalConnection>;
  }