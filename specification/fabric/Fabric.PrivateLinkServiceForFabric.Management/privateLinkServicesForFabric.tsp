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
  @visibility("read")
  name: string;
}

@doc("PrivateLinkServiceForFabric Properties")
model PrivateLinkServiceForFabricProperties {
  @doc("Tenant Id")
  tenantId: string;

  @doc("Workspace Object Id")
  workspaceObjectId: string;

  @doc("Private Endpoint Connections")
  @visibility("read")
  privateEndpointConnections: PrivateEndpointConnection[];

  @doc("Provisioning State")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Operation Identifier Parameter")
model OperationIdentifierParameter {
  @doc("Operation Id")
  @segment("operationResults")
  @path
  operationIdentifier: string;
}

@doc("Arm Operation Status")
model ArmOperationStatus {
  @doc("Operation Id")
  @visibility("read")
  id: string;

  @doc("Operation Name")
  @visibility("read")
  name?: string;

  @doc("Operation Start Time")
  @visibility("read")
  startTime?: utcDateTime;

  @doc("Operation End Time")
  @visibility("read")
  endTime?: utcDateTime;

  @doc("Status Value")
  @Azure.Core.lroStatus
  status: ResourceProvisioningState;

  @doc("Operation Error Detail")
  @visibility("read")
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

interface Operations extends Azure.ResourceManager.Operations {}

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
  getOperationResult is ArmResourceRead<
    PrivateLinkServiceForFabric,
    Parameters = OperationIdentifierParameter,
    Response = ArmOperationStatus
  >;
}
