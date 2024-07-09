import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

import "./resourcetypes/community/community.tsp";
import "./resourcetypes/virtualEnclave/virtualenclave.tsp";
import "./resourcetypes/workload/workload.tsp";
import "./resourcetypes/catalog/catalog.tsp";
import "./resourcetypes/endpoint/endpoint.tsp";
import "./resourcetypes/internalConnection/internalConnection.tsp";
import "./resourcetypes/externalConnection/externalConnection.tsp";
import "./resourcetypes/postActions/checkaddressspaceavailability.tsp";
import "./resourcetypes/transitHub/transitHub.tsp";
import "./resourcetypes/enclaveConnection/enclaveConnection.tsp";
import "./resourcetypes/communityEndpoint/communityEndpoint.tsp";
import "./resourcetypes/enclaveEndpoint/enclaveEndpoint.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

/** Compliant create or update template */
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "This is a valid template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a valid template"
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
op ArmResourceCreateOrUpdateAsync<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @bodyRoot
  resource: TResource,
): ArmUpdatedResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

@doc("Arm resource update successful")
model ArmUpdatedResponse<TResource extends Azure.ResourceManager.Foundations.Resource>
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

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Should be top-level"
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("The managed service identity for this resource")
  identity: ManagedServiceIdentityProperty;
}

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("Enclave Update Resource")
model EnclaveUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("The managed service identity for this resource")
  identity?: ManagedServiceIdentityUpdate;

  @doc("The enclave properties")
  properties?: VirtualEnclavePropertiesUpdate;
}

@doc("Virtual Enclave Properties Update Resource")
model VirtualEnclavePropertiesUpdate
  is OptionalProperties<UpdateableProperties<VirtualEnclaveProperties>>;

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("Managed Service Identity Update Resource")
model ManagedServiceIdentityUpdate
    is OptionalProperties<UpdateableProperties<ManagedServiceIdentityProperty>>;

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

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
@removed(Microsoft.Mission.Versions.v2024_06_01_preview)
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

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
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

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
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

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
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

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
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
  createOrUpdate is ArmResourceCreateOrUpdateAsync<WorkloadResource>;
  update is ArmResourcePatchAsync<WorkloadResource, WorkloadProperties>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<EndpointResource>;
  listByParent is ArmResourceListByParent<EndpointResource>;
  listBySubscription is ArmListBySubscription<EndpointResource>;
}

@doc("Virtual Enclave Interface")
@armResourceOperations
interface VirtualEnclave {
  get is ArmResourceRead<EnclaveResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EnclaveResource>;
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @sharedRoute
  update is ArmCustomPatchAsync<EnclaveResource, EnclaveUpdate>;
  @removed(Microsoft.Mission.Versions.v2024_06_01_preview)
  @sharedRoute
  @renamedFrom(Microsoft.Mission.Versions.v2024_06_01_preview, "update")
  oldUpdate is ArmResourcePatchAsync<EnclaveResource, VirtualEnclaveProperties>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<EnclaveResource>;
  listByParent is ArmResourceListByParent<EnclaveResource>;
  listBySubscription is ArmListBySubscription<EnclaveResource>;

  @autoRoute
  @doc("Checks that the IP Address Space to be allocated for this Virtual Enclave is available.")
  @armResourceAction(EnclaveResource)
  @post
  @added(Microsoft.Mission.Versions.v2023_08_01_preview)
  @removed(Microsoft.Mission.Versions.v2024_06_01_preview)
  checkAddressSpaceAvailability(
    ...ResourceInstanceParameters<EnclaveResource>,

    @doc("Check IP Address Space request body.")
    @bodyRoot
    checkAddressSpaceAvailabilityRequest: CheckAddressSpaceAvailabilityRequest,
  ): ArmResponse<CheckAddressSpaceAvailabilityResponse> | ErrorResponse;
}

@doc("Community Interface")
@armResourceOperations
interface Community {
  get is ArmResourceRead<CommunityResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CommunityResource>;
  update is ArmResourcePatchAsync<CommunityResource, CommunityProperties>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<CommunityResource>;
  listByParent is ArmResourceListByParent<CommunityResource>;
  listBySubscription is ArmListBySubscription<CommunityResource>;

  @autoRoute
  @doc("Checks that the IP Address Space to be allocated for this Community is available.")
  @armResourceAction(CommunityResource)
  @post
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  checkAddressSpaceAvailability(
    ...ResourceInstanceParameters<CommunityResource>,

    @doc("Check IP Address Space request body.")
    @bodyRoot
    checkAddressSpaceAvailabilityRequest: CheckAddressSpaceAvailabilityRequest,
  ): ArmResponse<CheckAddressSpaceAvailabilityResponse> | ErrorResponse;
}

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
@removed(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("Catalog Interface")
@armResourceOperations
interface CatalogInterface {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Catalog_Get")
  get is ArmResourceRead<CatalogResource>;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Catalog_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CatalogResource>;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Catalog_Update")
  update is ArmResourcePatchAsync<CatalogResource, CatalogProperties>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  @operationId("Catalog_Delete")
  delete is ArmResourceDeleteAsync<CatalogResource>;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Catalog_ListByResourceGroup")
  listByParent is ArmResourceListByParent<CatalogResource>;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Catalog_ListBySubscription")
  listBySubscription is ArmListBySubscription<CatalogResource>;
}

@doc("Internal Connections")
@armResourceOperations
interface InternalConnections {
  get is ArmResourceRead<InternalConnection>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<InternalConnection>;
  update is ArmResourcePatchAsync<
    InternalConnection,
    InternalConnectionProperties
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<InternalConnection>;
  listByParent is ArmResourceListByParent<InternalConnection>;
  listBySubscription is ArmListBySubscription<InternalConnection>;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("TransitHub Interface")
@armResourceOperations
interface TransitHub {
  get is ArmResourceRead<TransitHubResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<TransitHubResource>;
  update is ArmResourcePatchAsync<TransitHubResource, TransitHubProperties>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<TransitHubResource>;
  listByParent is ArmResourceListByParent<TransitHubResource>;
  listBySubscription is ArmListBySubscription<TransitHubResource>;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("Enclave Connection Interface")
@armResourceOperations
interface EnclaveConnection {
  get is ArmResourceRead<EnclaveConnectionResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EnclaveConnectionResource>;
  update is ArmResourcePatchAsync<
    EnclaveConnectionResource,
    EnclaveConnectionProperties
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<EnclaveConnectionResource>;
  listByParent is ArmResourceListByParent<EnclaveConnectionResource>;
  listBySubscription is ArmListBySubscription<EnclaveConnectionResource>;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("Enclave Endpoint Interface")
@armResourceOperations
interface EnclaveEndpoints {
  get is ArmResourceRead<EnclaveEndpointResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EnclaveEndpointResource>;
  update is ArmResourcePatchAsync<
    EnclaveEndpointResource,
    EnclaveEndpointProperties
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<EnclaveEndpointResource>;
  listByParent is ArmResourceListByParent<EnclaveEndpointResource>;
  listBySubscription is ArmListBySubscription<EnclaveEndpointResource>;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("Community Endpoint Interface")
@armResourceOperations
interface CommunityEndpoints {
  get is ArmResourceRead<CommunityEndpointResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CommunityEndpointResource>;
  update is ArmResourcePatchAsync<
    CommunityEndpointResource,
    CommunityEndpointProperties
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<ExternalConnection>;
  listByParent is ArmResourceListByParent<ExternalConnection>;
  listBySubscription is ArmListBySubscription<ExternalConnection>;
}
