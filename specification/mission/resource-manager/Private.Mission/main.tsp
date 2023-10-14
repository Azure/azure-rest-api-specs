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
import "./resourcetypes/workloadServiceTemplate/workloadServiceTemplate.tsp";
import "./resourcetypes/catalog/catalog.tsp";
import "./resourcetypes/endpoint/endpoint.tsp";
import "./resourcetypes/internalConnection/internalConnection.tsp";
import "./resourcetypes/postActions/checkaddressspaceavailability.tsp";
import "./resourcetypes/transitHub/transitHub.tsp";
import "./resourcetypes/enclaveConnection/enclaveConnection.tsp";
import "./resourcetypes/communityEndpoint/communityEndpoint.tsp";
import "./resourcetypes/enclaveEndpoint/enclaveEndpoint.tsp";
import "./resourcetypes/externalConnection/externalConnection.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service({
  title: "Private Mission",
})
@versioned(global.Private.Mission.Versions)
@doc("Microsoft Mission Resource Provider management API.")
namespace Private.Mission;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Supported API versions for the Microsoft.Mission resource provider.")
enum Versions {
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
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the communityResource Resource")
  name: string;
}

@doc("Virtual Enclave Model Resource")
model EnclaveResource is TrackedResource<VirtualEnclaveProperties> {
  @key("virtualEnclaveName")
  @segment("virtualEnclaves")
  @doc("The name of the enclaveResource Resource")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  name: string;
}

@doc("Workload Model Resource")
@parentResource(EnclaveResource)
model WorkloadResource is TrackedResource<WorkloadProperties> {
  @key("workloadName")
  @segment("workloads")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the workloadResource Resource")
  name: string;
}

@doc("Workload Service Template Model Resource")
@parentResource(EnclaveResource)
model WorkloadServiceTempalteResource
  is TrackedResource<WorkloadServiceTemplateProperties> {
  @key("workloadServiceTemplateName")
  @segment("workloads")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @path
  @doc("The name of the workloadServiceTemplateResource Resource")
  name: string;
}

@doc("Catalog Model Resource")
model CatalogResource is TrackedResource<CatalogProperties> {
  @key("catalogName")
  @segment("catalogs")
  @doc("The name of the catalogResource Resource")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  name: string;
}

@doc("Endpoint Model Resource")
@parentResource(EnclaveResource)
model EndpointResource is TrackedResource<EndpointProperties> {
  @key("endpointName")
  @segment("endpoints")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the endpointResource Resource")
  name: string;
}

@doc("Describes an Internal Connection.")
model InternalConnection is TrackedResource<InternalConnectionProperties> {
  @key("internalConnectionName")
  @segment("internalConnections")
  @doc("The name of the internal connection.")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  name: string;
}

@doc("TransitHub Model Resource")
@parentResource(CommunityResource)
model TransitHubResource is TrackedResource<TransitHubProperties> {
  @key("transitHubName")
  @segment("transitHubs")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the TransitHub Resource")
  name: string;
}

@doc("EnclaveConnection Model Resource")
model EnclaveConnectionResource
  is TrackedResource<EnclaveConnectionProperties> {
  @key("enclaveConnectionName")
  @segment("enclaveConnections")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the Enclave Connection Resource")
  name: string;
}

@doc("EnclaveEndpoint Model Resource")
@parentResource(EnclaveResource)
model EnclaveEndpointResource is TrackedResource<EnclaveEndpointProperties> {
  @key("enclaveEndpointName")
  @segment("enclaveEndpoints")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the Enclave Endpoint Resource")
  name: string;
}

@doc("CommunityEndpoint Model Resource")
@parentResource(CommunityResource)
model CommunityEndpointResource
  is TrackedResource<CommunityEndpointProperties> {
  @key("communityEndpointName")
  @segment("communityEndpoints")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the Community Endpoint Resource")
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

  @autoRoute
  @doc("Checks that the IP Address Space to be allocated for a new Virtual Enclave is available.")
  @armResourceAction(CommunityResource)
  @post
  checkAddressSpaceAvailability(
    ...ResourceInstanceParameters<CommunityResource>,

    @doc("Check IP Address Space request body.")
    @body
    checkAddressSpaceAvailabilityRequest: CheckAddressSpaceAvailabilityRequest,
  ): ArmResponse<CheckAddressSpaceAvailabilityResponse> | ErrorResponse;
}

@doc("Request to the action call to check address space availability.")
model CheckAddressSpaceAvailabilityRequest {
  @doc("Resource Id of the Community")
  communityResourceId: string;

  @doc("Information about the enclave virtual network")
  enclaveVirtualNetwork: EnclaveVirtualNetwork;
}

@doc("Response of availability of the requested address space.")
model CheckAddressSpaceAvailabilityResponse {
  @doc("Boolean representing whether the address space is available.")
  value: boolean;
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

@doc("Describes an External Connection.")
model ExternalConnection is TrackedResource<ExternalConnectionProperties> {
  @key("externalConnectionName")
  @segment("externalConnections")
  @doc("The name of the external connection.")
  @path
  name: string;
}

@doc("TransitHub Interface")
@armResourceOperations
interface TransitHub {
  get is ArmResourceRead<TransitHubResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<TransitHubResource>;
  update is ArmResourcePatchAsync<TransitHubResource, TransitHubProperties>;
  delete is ArmResourceDeleteAsync<TransitHubResource>;
  listByParent is ArmResourceListByParent<TransitHubResource>;
  listBySubscription is ArmListBySubscription<TransitHubResource>;
}

@doc("Enclave Connection Interface")
@armResourceOperations
interface EnclaveConnection {
  get is ArmResourceRead<EnclaveConnectionResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EnclaveConnectionResource>;
  update is ArmResourcePatchAsync<
    EnclaveConnectionResource,
    EnclaveConnectionProperties
  >;
  delete is ArmResourceDeleteAsync<EnclaveConnectionResource>;
  listByParent is ArmResourceListByParent<EnclaveConnectionResource>;
  listBySubscription is ArmListBySubscription<EnclaveConnectionResource>;
}

@doc("Enclave Endpoint Interface")
@armResourceOperations
interface EnclaveEndpoints {
  get is ArmResourceRead<EnclaveEndpointResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EnclaveEndpointResource>;
  update is ArmResourcePatchAsync<
    EnclaveEndpointResource,
    EnclaveEndpointProperties
  >;
  delete is ArmResourceDeleteAsync<EnclaveEndpointResource>;
  listByParent is ArmResourceListByParent<EnclaveEndpointResource>;
  listBySubscription is ArmListBySubscription<EnclaveEndpointResource>;
}

@doc("Community Endpoint Interface")
@armResourceOperations
interface CommunityEndpoints {
  get is ArmResourceRead<CommunityEndpointResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CommunityEndpointResource>;
  update is ArmResourcePatchAsync<
    CommunityEndpointResource,
    CommunityEndpointProperties
  >;
  delete is ArmResourceDeleteAsync<CommunityEndpointResource>;
  listByParent is ArmResourceListByParent<CommunityEndpointResource>;
  listBySubscription is ArmListBySubscription<CommunityEndpointResource>;
}

@doc("External Connections")
@armResourceOperations
interface ExternalConnections {
  get is ArmResourceRead<ExternalConnection>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExternalConnection>;
  update is ArmResourcePatchAsync<
    ExternalConnection,
    ExternalConnectionProperties
  >;
  delete is ArmResourceDeleteAsync<ExternalConnection>;
  listByParent is ArmResourceListByParent<ExternalConnection>;
  listBySubscription is ArmListBySubscription<ExternalConnection>;
}
