import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

import "./model.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

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
  update is ArmCustomPatchAsync<
    WorkloadResource,
    PatchModel = WorkloadPatchModel
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<WorkloadResource>;
  listByEnclaveResource is ArmResourceListByParent<WorkloadResource>;
  listBySubscription is ArmListBySubscription<WorkloadResource>;
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
  update is ArmCustomPatchAsync<
    EnclaveResource,
    PatchModel = VirtualEnclavePatchModel
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<EnclaveResource>;
  listByResourceGroup is ArmResourceListByParent<EnclaveResource>;
  listBySubscription is ArmListBySubscription<EnclaveResource>;

  @doc("Callback that triggers on approval state change.")
  @armResourceAction(EnclaveResource)
  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  approvalCallback is ArmResourceActionAsync<
    EnclaveResource,
    ApprovalCallbackRequest,
    ApprovalCallbackResponse
  >;
  @doc("Callback that triggers on approval deletion state change.")
  @armResourceAction(EnclaveResource)
  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
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
  update is ArmCustomPatchAsync<
    CommunityResource,
    PatchModel = CommunityPatchModel
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<CommunityResource>;
  listByResourceGroup is ArmResourceListByParent<CommunityResource>;
  listBySubscription is ArmListBySubscription<CommunityResource>;

  @autoRoute
  @doc("Checks that the IP Address Space to be allocated for this Community is available.")
  @armResourceAction(CommunityResource)
  @post
  checkAddressSpaceAvailability(
    ...ResourceInstanceParameters<CommunityResource>,

    @doc("Check IP Address Space request body.")
    @bodyRoot
    checkAddressSpaceAvailabilityRequest: CheckAddressSpaceAvailabilityRequest,
  ): ArmResponse<CheckAddressSpaceAvailabilityResponse> | ErrorResponse;
}

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
  update is ArmCustomPatchAsync<
    TransitHubResource,
    PatchModel = TransitHubPatchModel
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<TransitHubResource>;
  listByCommunityResource is ArmResourceListByParent<TransitHubResource>;
  listBySubscription is ArmListBySubscription<TransitHubResource>;
}

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
  update is ArmCustomPatchAsync<
    EnclaveConnectionResource,
    PatchModel = EnclaveConnectionPatchModel
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<EnclaveConnectionResource>;
  listByResourceGroup is ArmResourceListByParent<EnclaveConnectionResource>;
  listBySubscription is ArmListBySubscription<EnclaveConnectionResource>;

  @doc("Callback that triggers on approval state change.")
  @armResourceAction(EnclaveConnectionResource)
  approvalCallback is ArmResourceActionAsync<
    EnclaveConnectionResource,
    ApprovalCallbackRequest,
    ApprovalCallbackResponse
  >;
  @doc("Callback that triggers on approval deletion state change.")
  @armResourceAction(EnclaveConnectionResource)
  approvalDeletionCallback is ArmResourceActionAsync<
    EnclaveConnectionResource,
    ApprovalDeletionCallbackRequest,
    ApprovalDeletionCallbackResponse
  >;
}

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
  update is ArmCustomPatchAsync<
    EnclaveEndpointResource,
    PatchModel = EnclaveEndpointPatchModel
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<EnclaveEndpointResource>;
  listByEnclaveResource is ArmResourceListByParent<EnclaveEndpointResource>;
  listBySubscription is ArmListBySubscription<EnclaveEndpointResource>;

  @doc("Callback that triggers on approval state change.")
  @armResourceAction(EnclaveEndpointResource)
  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  approvalCallback is ArmResourceActionAsync<
    EnclaveEndpointResource,
    ApprovalCallbackRequest,
    ApprovalCallbackResponse
  >;
  @doc("Callback that triggers on approval deletion state change.")
  @armResourceAction(EnclaveEndpointResource)
  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  approvalDeletionCallback is ArmResourceActionAsync<
    EnclaveEndpointResource,
    ApprovalDeletionCallbackRequest,
    ApprovalDeletionCallbackResponse
  >;
}

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
  update is ArmCustomPatchAsync<
    CommunityEndpointResource,
    PatchModel = CommunityEndpointPatchModel
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "deprecated" "Backwards compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<CommunityEndpointResource>;
  listByCommunityResource is ArmResourceListByParent<CommunityEndpointResource>;
  listBySubscription is ArmListBySubscription<CommunityEndpointResource>;

  @doc("Callback that triggers on approval state change.")
  @armResourceAction(CommunityEndpointResource)
  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  approvalCallback is ArmResourceActionAsync<
    CommunityEndpointResource,
    ApprovalCallbackRequest,
    ApprovalCallbackResponse
  >;
  @doc("Callback that triggers on approval deletion state change.")
  @armResourceAction(CommunityEndpointResource)
  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  approvalDeletionCallback is ArmResourceActionAsync<
    CommunityEndpointResource,
    ApprovalDeletionCallbackRequest,
    ApprovalDeletionCallbackResponse
  >;
}

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
  update is ArmCustomPatchAsync<
    ApprovalResource,
    PatchModel = ApprovalPatchModel
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ApprovalResource>;
  @doc("Upon receiving approval or rejection from approver, this facilitates actions on approval resource")
  @armResourceAction(ApprovalResource)
  initiatorCallback is ArmResourceActionAsync<
    ApprovalResource,
    InitiatorCallbackRequest,
    InitiatorCallbackResponse
  >;
}
