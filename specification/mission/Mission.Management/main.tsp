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
import "./resourcetypes/postActions/checkaddressspaceavailability.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service({
  title: "Microsoft Mission",
})
@versioned(Microsoft.Mission.Versions)
@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Supported API versions for the Microsoft.Mission resource provider.")
enum Versions {
  @doc("The 2023-02-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_02_01_preview: "2023-02-01-preview",

  @doc("The 2023-08-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_08_01_preview: "2023-08-01-preview",
}

/** Compliant create or update template */
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "This is a valid template"
@autoRoute
@doc("Create a {name}", TResource)
@OpenAPI.extension("x-ms-long-running-operation", true)
@OpenAPI.extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "azure-async-operation",
  }
)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdate2Async<
  TResource extends Azure.ResourceManager.Foundations.ArmResource,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  resource: TResource,
): ArmUpdatedResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

@doc("Arm resource update successful")
model ArmUpdatedResponse<TResource extends Azure.ResourceManager.Foundations.ArmResource>
  is ArmResponse<TResource>;

@doc("Community Model Resource")
model CommunityResource is TrackedResource<CommunityProperties> {
  @key("communityName")
  @segment("communities")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @path
  @doc("The name of the communityResource Resource")
  name: string;
}

@doc("Virtual Enclave Model Resource")
model EnclaveResource is TrackedResource<VirtualEnclaveProperties> {
  @key("virtualEnclaveName")
  @segment("virtualEnclaves")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the enclaveResource Resource")
  @path
  name: string;
}

@doc("Workload Model Resource")
@parentResource(EnclaveResource)
model WorkloadResource is TrackedResource<WorkloadProperties> {
  @key("workloadName")
  @segment("workloads")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @path
  @doc("The name of the workloadResource Resource")
  name: string;
}

@doc("Catalog Model Resource")
model CatalogResource is TrackedResource<CatalogProperties> {
  @key("catalogName")
  @segment("catalogs")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the catalogResource Resource")
  @path
  name: string;
}

@doc("Endpoint Model Resource")
@parentResource(EnclaveResource)
model EndpointResource is TrackedResource<EndpointProperties> {
  @key("endpointName")
  @segment("endpoints")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @path
  @doc("The name of the endpointResource Resource")
  name: string;
}

@doc("Describes an Internal Connection.")
model InternalConnection is TrackedResource<InternalConnectionProperties> {
  @key("internalConnectionName")
  @segment("internalConnections")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the internal connection.")
  @path
  name: string;
}

@doc("Describes an External Connection.")
model ExternalConnection is TrackedResource<ExternalConnectionProperties> {
  @key("externalConnectionName")
  @segment("externalConnections")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the external connection.")
  @path
  name: string;
}

@doc("Workload Interface")
@armResourceOperations
interface Workload {
  get is ArmResourceRead<WorkloadResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<WorkloadResource>;
  update is ArmResourcePatchAsync<WorkloadResource, WorkloadProperties>;
  delete is ArmResourceDeleteAsync<WorkloadResource>;
  listByParent is ArmResourceListByParent<WorkloadResource>;
  listBySubscription is ArmListBySubscription<WorkloadResource>;
}

@doc("Endpoint Interface")
@armResourceOperations
interface Endpoint {
  get is ArmResourceRead<EndpointResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<EndpointResource>;
  update is ArmResourcePatchAsync<EndpointResource, EndpointProperties>;
  delete is ArmResourceDeleteAsync<EndpointResource>;
  listByParent is ArmResourceListByParent<EndpointResource>;
  listBySubscription is ArmListBySubscription<EndpointResource>;
}

@doc("Virtual Enclave Interface")
@armResourceOperations
interface VirtualEnclave {
  get is ArmResourceRead<EnclaveResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<EnclaveResource>;
  update is ArmResourcePatchAsync<EnclaveResource, VirtualEnclaveProperties>;
  delete is ArmResourceDeleteAsync<EnclaveResource>;
  listByParent is ArmResourceListByParent<EnclaveResource>;
  listBySubscription is ArmListBySubscription<EnclaveResource>;

  @autoRoute
  @doc("Checks that the IP Address Space to be allocated for this Virtual Enclave is available.")
  @armResourceAction(EnclaveResource)
  @post
  @added(Microsoft.Mission.Versions.v2023_08_01_preview)
  checkAddressSpaceAvailability(
    ...ResourceInstanceParameters<EnclaveResource>,

    @doc("Check IP Address Space request body.")
    @body
    checkAddressSpaceAvailabilityRequest: CheckAddressSpaceAvailabilityRequest,
  ): ArmResponse<CheckAddressSpaceAvailabilityResponse> | ErrorResponse;
}

@doc("Community Interface")
@armResourceOperations
interface Community {
  get is ArmResourceRead<CommunityResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<CommunityResource>;
  update is ArmResourcePatchAsync<CommunityResource, CommunityProperties>;
  delete is ArmResourceDeleteAsync<CommunityResource>;
  listByParent is ArmResourceListByParent<CommunityResource>;
  listBySubscription is ArmListBySubscription<CommunityResource>;
}

@doc("Catalog Interface")
@armResourceOperations
interface Catalog {
  get is ArmResourceRead<CatalogResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<CatalogResource>;
  update is ArmResourcePatchAsync<CatalogResource, CatalogProperties>;
  delete is ArmResourceDeleteAsync<CatalogResource>;
  listByParent is ArmResourceListByParent<CatalogResource>;
  listBySubscription is ArmListBySubscription<CatalogResource>;
}

@doc("Internal Connections")
@armResourceOperations
interface InternalConnections {
  get is ArmResourceRead<InternalConnection>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<InternalConnection>;
  update is ArmResourcePatchAsync<
    InternalConnection,
    InternalConnectionProperties
  >;
  delete is ArmResourceDeleteAsync<InternalConnection>;
  listByParent is ArmResourceListByParent<InternalConnection>;
  listBySubscription is ArmListBySubscription<InternalConnection>;
}

@doc("External Connections")
@armResourceOperations
interface ExternalConnections {
  get is ArmResourceRead<ExternalConnection>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<ExternalConnection>;
  update is ArmResourcePatchAsync<
    ExternalConnection,
    ExternalConnectionProperties
  >;
  delete is ArmResourceDeleteAsync<ExternalConnection>;
  listByParent is ArmResourceListByParent<ExternalConnection>;
  listBySubscription is ArmListBySubscription<ExternalConnection>;
}
