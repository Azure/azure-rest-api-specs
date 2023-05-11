import "@typespec/rest";
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

@doc("Workload Interface")
@armResourceOperations
interface Workload
  extends TrackedResourceOperations<WorkloadResource, WorkloadProperties> {}

@doc("Endpoint Interface")
@armResourceOperations
interface Endpoint
  extends TrackedResourceOperations<EndpointResource, EndpointProperties> {}

@doc("Virtual Enclave Interface")
@armResourceOperations
interface VirtualEnclave
  extends TrackedResourceOperations<EnclaveResource, VirtualEnclaveProperties> {}

@doc("Community Interface")
@armResourceOperations
interface Community 
  extends TrackedResourceOperations<CommunityResource, CommunityProperties> {}

@doc("Catalog Interface")
@armResourceOperations
interface Catalog
  extends TrackedResourceOperations<CatalogResource, CatalogProperties> {}

@doc("Internal Connections")
@armResourceOperations
interface InternalConnections
  extends TrackedResourceOperations<InternalConnection, InternalConnectionProperties> {}
