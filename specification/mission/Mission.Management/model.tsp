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
import "./resourcetypes/postActions/approvalcallback.tsp";
import "./resourcetypes/approvals/approvals.tsp";
import "./resourcetypes/postActions/initiatorcallback.tsp";
import "./resourcetypes/postActions/approvaldeletioncallback.tsp";

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

  /** The managed service identity for this resource */
  ...ManagedServiceIdentityProperty;
}

@@added(CommunityResource.identity,
  Microsoft.Mission.Versions.v2024_06_01_preview
);

@doc("Virtual Enclave Model Resource")
model EnclaveResource is TrackedResource<VirtualEnclaveProperties> {
  @key("virtualEnclaveName")
  @segment("virtualEnclaves")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the enclaveResource Resource")
  @path
  name: string;

  /** The managed service identity for this resource */
  ...ManagedServiceIdentityProperty;
}

@@added(EnclaveResource.identity,
  Microsoft.Mission.Versions.v2024_06_01_preview
);

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


@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("Approval Model Resource")
model ApprovalResource is ExtensionResource<ApprovalProperties> {
  @key("approvalName")
  @segment("approvals")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the approvals resource.")
  name: string;
}

@doc("Workload Interface")
@armResourceOperations
interface Workload {
  get is ArmResourceRead<WorkloadResource>;
  @useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WorkloadResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader
  >;
  update is ArmResourcePatchAsync<WorkloadResource, WorkloadProperties>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<WorkloadResource>;
  listByEnclaveResource is ArmResourceListByParent<WorkloadResource>;
  listBySubscription is ArmListBySubscription<WorkloadResource>;
}

@doc("Endpoint Interface")
@armResourceOperations
interface Endpoint {
  get is ArmResourceRead<EndpointResource>;
  @useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    EndpointResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader
  >;
  update is ArmResourcePatchAsync<EndpointResource, EndpointProperties>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<EndpointResource>;
  listByEnclaveResource is ArmResourceListByParent<EndpointResource>;
  listBySubscription is ArmListBySubscription<EndpointResource>;
}

@doc("Virtual Enclave Interface")
@armResourceOperations
interface VirtualEnclave {
  get is ArmResourceRead<EnclaveResource>;
  @useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    EnclaveResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader
  >;
  update is ArmResourcePatchAsync<EnclaveResource, VirtualEnclaveProperties>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<EnclaveResource>;
  listByResourceGroup is ArmResourceListByParent<EnclaveResource>;
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

  @doc("Callback that triggers on approval state change.")
  @armResourceAction(EnclaveResource)
  @added(Microsoft.Mission.Versions.v2024_11_01_preview)
  approvalCallback is ArmResourceActionAsync<
    EnclaveResource,
    ApprovalCallbackRequest,
    ApprovalCallbackResponse
  >;
  @doc("Callback that triggers on approval deletion state change.")
  @armResourceAction(EnclaveResource)
  @added(Microsoft.Mission.Versions.v2024_11_01_preview)
  approvalDeletionCallback is ArmResourceActionAsync<
    EnclaveResource,
    ApprovalDeletionCallbackRequest,
    ApprovalDeletionCallbackResponse
  >;
}

@doc("Community Interface")
@armResourceOperations
interface Community {
  get is ArmResourceRead<CommunityResource>;
  @useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CommunityResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader
  >;
  update is ArmResourcePatchAsync<CommunityResource, CommunityProperties>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<CommunityResource>;
  listByResourceGroup is ArmResourceListByParent<CommunityResource>;
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
@renamedFrom(Microsoft.Mission.Versions.v2024_06_01_preview, "Catalog")
interface CatalogInterface {
  get is ArmResourceRead<CatalogResource>;
  @useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CatalogResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader
  >;
  update is ArmResourcePatchAsync<CatalogResource, CatalogProperties>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<CatalogResource>;
  listByResourceGroup is ArmResourceListByParent<CatalogResource>;
  listBySubscription is ArmListBySubscription<CatalogResource>;
}

@doc("Internal Connections")
@armResourceOperations
interface InternalConnections {
  get is ArmResourceRead<InternalConnection>;
  @useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InternalConnection,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader
  >;
  update is ArmResourcePatchAsync<
    InternalConnection,
    InternalConnectionProperties
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<InternalConnection>;
  listByResourceGroup is ArmResourceListByParent<InternalConnection>;
  listBySubscription is ArmListBySubscription<InternalConnection>;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("TransitHub Interface")
@armResourceOperations
interface TransitHub {
  get is ArmResourceRead<TransitHubResource>;
  @useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    TransitHubResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader
  >;
  update is ArmResourcePatchAsync<TransitHubResource, TransitHubProperties>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<TransitHubResource>;
  listByCommunityResource is ArmResourceListByParent<TransitHubResource>;
  listBySubscription is ArmListBySubscription<TransitHubResource>;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("Enclave Connection Interface")
@armResourceOperations
interface EnclaveConnection {
  get is ArmResourceRead<EnclaveConnectionResource>;
  @useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    EnclaveConnectionResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader
  >;
  update is ArmResourcePatchAsync<
    EnclaveConnectionResource,
    EnclaveConnectionProperties
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<EnclaveConnectionResource>;
  listByResourceGroup is ArmResourceListByParent<EnclaveConnectionResource>;
  listBySubscription is ArmListBySubscription<EnclaveConnectionResource>;

  @doc("Callback that triggers on approval state change.")
  @armResourceAction(EnclaveConnectionResource)
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  approvalCallback is ArmResourceActionAsync<
    EnclaveConnectionResource,
    ApprovalCallbackRequest,
    ApprovalCallbackResponse
  >;
  @doc("Callback that triggers on approval deletion state change.")
  @armResourceAction(EnclaveConnectionResource)
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  approvalDeletionCallback is ArmResourceActionAsync<
    EnclaveConnectionResource,
    ApprovalDeletionCallbackRequest,
    ApprovalDeletionCallbackResponse
  >;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("Enclave Endpoint Interface")
@armResourceOperations
interface EnclaveEndpoints {
  get is ArmResourceRead<EnclaveEndpointResource>;
  @useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    EnclaveEndpointResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader
  >;
  update is ArmResourcePatchAsync<
    EnclaveEndpointResource,
    EnclaveEndpointProperties
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<EnclaveEndpointResource>;
  listByEnclaveResource is ArmResourceListByParent<EnclaveEndpointResource>;
  listBySubscription is ArmListBySubscription<EnclaveEndpointResource>;

  @doc("Callback that triggers on approval state change.")
  @armResourceAction(EnclaveEndpointResource)
  @added(Microsoft.Mission.Versions.v2024_11_01_preview)
  approvalCallback is ArmResourceActionAsync<
    EnclaveEndpointResource,
    ApprovalCallbackRequest,
    ApprovalCallbackResponse
  >;
  @doc("Callback that triggers on approval deletion state change.")
  @armResourceAction(EnclaveEndpointResource)
  @added(Microsoft.Mission.Versions.v2024_11_01_preview)
  approvalDeletionCallback is ArmResourceActionAsync<
    EnclaveEndpointResource,
    ApprovalDeletionCallbackRequest,
    ApprovalDeletionCallbackResponse
  >;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("Community Endpoint Interface")
@armResourceOperations
interface CommunityEndpoints {
  get is ArmResourceRead<CommunityEndpointResource>;
  @useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CommunityEndpointResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader
  >;
  update is ArmResourcePatchAsync<
    CommunityEndpointResource,
    CommunityEndpointProperties
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<CommunityEndpointResource>;
  listByCommunityResource is ArmResourceListByParent<CommunityEndpointResource>;
  listBySubscription is ArmListBySubscription<CommunityEndpointResource>;

  @doc("Callback that triggers on approval state change.")
  @armResourceAction(CommunityEndpointResource)
  @added(Microsoft.Mission.Versions.v2024_11_01_preview)
  approvalCallback is ArmResourceActionAsync<
    CommunityEndpointResource,
    ApprovalCallbackRequest,
    ApprovalCallbackResponse
  >;
  @doc("Callback that triggers on approval deletion state change.")
  @armResourceAction(CommunityEndpointResource)
  @added(Microsoft.Mission.Versions.v2024_11_01_preview)
  approvalDeletionCallback is ArmResourceActionAsync<
    CommunityEndpointResource,
    ApprovalDeletionCallbackRequest,
    ApprovalDeletionCallbackResponse
  >;
}

@doc("External Connections")
@armResourceOperations
interface ExternalConnections {
  get is ArmResourceRead<ExternalConnection>;
  @useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExternalConnection,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader
  >;
  update is ArmResourcePatchAsync<
    ExternalConnection,
    ExternalConnectionProperties
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteAsync<ExternalConnection>;
  listByResourceGroup is ArmResourceListByParent<ExternalConnection>;
  listBySubscription is ArmListBySubscription<ExternalConnection>;
}

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("Approval Interface")
@armResourceOperations
interface Approval {
  get is ArmResourceRead<ApprovalResource>;
  @useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApprovalResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader
  >;
  listByParent is ArmResourceListByParent<ApprovalResource>;
  update is ArmResourcePatchAsync<ApprovalResource,ApprovalProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<ApprovalResource>;  
  @doc("Upon receiving approval or rejection from approver, this facilitates actions on approval resource")
  @armResourceAction(ApprovalResource)
  initiatorCallback is ArmResourceActionAsync<ApprovalResource, InitiatorCallbackRequest, InitiatorCallbackResponse>;
}