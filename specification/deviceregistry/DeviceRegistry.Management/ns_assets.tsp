import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/topic.tsp";
import "./properties/ns_assetProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2025_07_01_preview)
@parentResource(Namespace)
@doc("Asset definition.")
model NamespaceAsset is TrackedResource<NamespaceAssetProperties> {
  @doc("The name of the asset.")
  @key("assetName")
  @segment("assets")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

@added(Versions.v2026_04_01)
@doc("The request body for the executeAction operation on NamespaceAsset.")
model NamespaceAssetExecuteActionRequest {
  @doc("Name of the management action to be executed.")
  managementActionName: string;

  @doc("Name of the management group under which the action is to be executed.")
  managementGroupName: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "payload property field is custom defined by customer"
  @doc("Payload required for executing the management action.")
  payload?: {};
}

@added(Versions.v2026_04_01)
@doc("The response body for the executeAction operation on NamespaceAsset.")
model NamespaceAssetExecuteActionResponse {
  @doc("Status of the management action execution.")
  status: string;

  @doc("Name of the management action that was executed.")
  managementActionName: string;

  @doc("Name of the management group under which the action was executed.")
  managementGroupName: string;

  @doc("Resource ID of the asset on which the management action was executed.")
  assetResourceId: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "payload property field is custom defined by connector"
  @doc("Response from the asset regarding the management action execution.")
  response?: {};

  @doc("Error if the execute action operation is not successful.")
  error?: Error;
}

@added(Versions.v2025_07_01_preview)
@armResourceOperations
interface NamespaceAssets {
  get is ArmResourceRead<NamespaceAsset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceAsset>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    NamespaceAsset,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceAsset,
      NamespaceAssetProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceAsset>;
  listByResourceGroup is ArmResourceListByParent<NamespaceAsset>;
  @added(Versions.v2026_04_01)
  executeAction is ArmResourceActionAsync<
    NamespaceAsset,
    NamespaceAssetExecuteActionRequest,
    NamespaceAssetExecuteActionResponse,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}
