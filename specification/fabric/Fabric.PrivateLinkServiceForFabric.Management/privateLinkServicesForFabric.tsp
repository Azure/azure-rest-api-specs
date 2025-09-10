import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Fabric;

/** Model Definitions */
@doc("PrivateLinkServiceForFabric Object")
model PrivateLinkServiceForFabric
  is TrackedResource<PrivateLinkServiceForFabricProperties> {
  @doc("PrivateLinkServiceForFabric")
  @pattern("^(?:[a-zA-Z0-9]+-?){3,80}$")
  @key("privateLinkServiceName")
  @path
  @segment("privateLinkServicesForFabric")
  @visibility(Lifecycle.Read)
  name: string;
}

@doc("PrivateLinkServiceForFabric Properties")
model PrivateLinkServiceForFabricProperties {
  @doc("Tenant Id")
  tenantId: string;

  @doc("Workspace Object Id")
  workspaceObjectId: string;

  @doc("Private Endpoint Connections")
  @visibility(Lifecycle.Read)
  privateEndpointConnections: PrivateEndpointConnection[];

  @doc("Provisioning State")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("Operation Id Parameter")
model OperationIdParameter {
  @doc("The ID of an ongoing async operation.")
  @path
  @minLength(1)
  @segment("operationResults")
  @Azure.ResourceManager.Private.armCommonParameter(
    "OperationIdParameter",
    Azure.ResourceManager.CommonTypes.Versions.v3
  )
  @Azure.ResourceManager.Private.armCommonParameter(
    "OperationIdParameter",
    Azure.ResourceManager.CommonTypes.Versions.v4
  )
  @Azure.ResourceManager.Private.armCommonParameter(
    "OperationIdParameter",
    Azure.ResourceManager.CommonTypes.Versions.v5
  )
  operationId: string;
}

@doc("Arm Operation Status")
model ArmOperationStatus {
  @doc("Operation Id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Operation Name")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Operation Start Time in UTC and ISO 8601 DateTime format yyyy-MM-ddTHH:mm:ss.fffffffZ")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("Operation End Time in UTC and ISO 8601 DateTime format yyyy-MM-ddTHH:mm:ss.fffffffZ")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("Status Value")
  @Azure.Core.lroStatus
  status: ResourceProvisioningState;

  @doc("Operation Error Detail")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface OperationResult {
  @doc("Get result of an async operation.")
  GetOperationResult<
    Resource extends {},
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
    Parameters extends {} = OperationIdParameter,
    Response extends {} = ArmOperationStatus,
    Error extends {} = ErrorResponse
  > is Azure.ResourceManager.Foundations.ArmReadOperation<
    ResourceInstanceParameters<Resource, BaseParameters> & Parameters,
    Response,
    Error
  >;
}

@armResourceOperations
interface PrivateLinkServicesForFabric {
  @doc("Get private link service for Fabric")
  get is ArmResourceRead<PrivateLinkServiceForFabric>;
  @doc("Create or update private link service for Fabric")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrivateLinkServiceForFabric>;
  @doc("Delete private link service for Fabric")
  delete is ArmResourceDeleteSync<PrivateLinkServiceForFabric>;
  @doc("List private link services for Fabric by resource group")
  listByResourceGroup is ArmResourceListByParent<PrivateLinkServiceForFabric>;
  @doc("List private link services for Fabric by subscription")
  listBySubscription is ArmListBySubscription<PrivateLinkServiceForFabric>;
  @doc("update private link service for fabric tags")
  updateTags is ArmTagsPatchSync<PrivateLinkServiceForFabric>;
  @doc("Get private link service for Fabric operation result")
  getOperationResult is OperationResult.GetOperationResult<PrivateLinkServiceForFabric>;
}
