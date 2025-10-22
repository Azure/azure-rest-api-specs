import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./edgeactionsbasemodels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

@armProviderNamespace
@service(#{
  title: "Microsoft.Cdn/EdgeAction",
})
@versioned(Versions)
@armCommonTypesVersion("v6")
namespace Microsoft.Cdn;

enum Versions {
  `2025-09-01-preview`,
}

// ARM Operations interface is required
interface Operations extends Azure.ResourceManager.Operations {}

model EdgeAction is TrackedResource<EdgeActionProperties> {
  @path
  @doc("The name of the Edge Action")
  @segment("edgeActions")
  @key("edgeActionName")
  @visibility(Lifecycle.Read)
  name: smallString;
}

@parentResource(EdgeAction)
model EdgeActionVersion is TrackedResource<EdgeActionVersionProperties> {
  @path
  @doc("The name of the Edge Action version")
  @segment("versions")
  @key("version")
  @visibility(Lifecycle.Read)
  name: smallString;
}

@parentResource(EdgeAction)
model EdgeActionExecutionFilter
  is TrackedResource<EdgeActionExecutionFilterProperties> {
  @path
  @doc("The name of the execution filter")
  @segment("executionFilters")
  @key("executionFilter")
  @visibility(Lifecycle.Read)
  name: smallString;
}

// REMOVED: EdgeActionOperation model and EdgeActionOperations interface - not in 2024-07-22-preview baseline
// model EdgeActionOperation is ProxyResource<EdgeActionOperationProperties> {
//   @path
//   @doc("The operation id")
//   @segment("edgeActionOperations")
//   @key("operationId")
//   @visibility(Lifecycle.Read)
//   name: smallString;
// }

// @armResourceOperations
// interface EdgeActionOperations {
//   @Autorest.example(
//     "./examples/EdgeActionOperations_Get.json",
//     "Get EdgeActionOperation"
//   )
//   get is ArmResourceRead<EdgeActionOperation>;

//   @Autorest.example(
//     "./examples/EdgeActionOperations_ListByResourceGroup.json",
//     "List EdgeActionOperations by ResourceGroup"
//   )
//   listByResourceGroup is ArmResourceListByParent<EdgeActionOperation>;

//   @Autorest.example(
//     "./examples/EdgeActionOperations_ListBySubscription.json",
//     "List EdgeActionOperations by Subscription"
//   )
//   listBySubscription is ArmListBySubscription<EdgeActionOperation>;
// }

@armResourceOperations
interface EdgeActions {
  get is ArmResourceRead<EdgeAction>;
  create is ArmResourceCreateOrUpdateAsync<EdgeAction>;
  update is ArmResourcePatchAsync<EdgeAction, EdgeActionProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<EdgeAction>;
  listByResourceGroup is ArmResourceListByParent<EdgeAction>;
  listBySubscription is ArmListBySubscription<EdgeAction>;
  addAttachment is ArmResourceActionAsync<
    EdgeAction,
    EdgeActionAttachment,
    EdgeActionAttachmentResponse
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Operation matches 2024 baseline with 200, 202 responses"
  deleteAttachment is ArmResourceActionNoContentAsync<
    EdgeAction,
    EdgeActionAttachment
  >;
}

@armResourceOperations
interface EdgeActionVersions {
  get is ArmResourceRead<EdgeActionVersion>;
  create is ArmResourceCreateOrUpdateAsync<EdgeActionVersion>;
  update is ArmResourcePatchAsync<
    EdgeActionVersion,
    EdgeActionVersionProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EdgeActionVersion>;
  listByResourceGroup is ArmResourceListByParent<EdgeActionVersion>;
  listBySubscription is ArmListBySubscription<EdgeActionVersion>;
  deployVersionCode is ArmResourceActionAsync<
    EdgeActionVersion,
    VersionCode,
    EdgeActionVersionProperties
  >;
  getVersionCode is ArmResourceActionAsync<
    EdgeActionVersion,
    void,
    VersionCode
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Operation matches 2024 baseline with 200, 202 responses"
  swapDefault is ArmResourceActionNoContentAsync<
    EdgeActionVersion,
    void
  >;
}

@armResourceOperations
interface EdgeActionExecutionFilters {
  get is ArmResourceRead<EdgeActionExecutionFilter>;
  create is ArmResourceCreateOrUpdateAsync<EdgeActionExecutionFilter>;
  update is ArmResourcePatchAsync<
    EdgeActionExecutionFilter,
    EdgeActionExecutionFilterProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EdgeActionExecutionFilter>;
  listByResourceGroup is ArmResourceListByParent<EdgeActionExecutionFilter>;
  listBySubscription is ArmListBySubscription<EdgeActionExecutionFilter>;
}
