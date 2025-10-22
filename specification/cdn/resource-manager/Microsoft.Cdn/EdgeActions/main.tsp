import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./edgeactionsbasemodels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

@armProviderNamespace("Microsoft.Cdn")
@service(#{
  title: "Microsoft.Cdn/EdgeAction",
})
@versioned(Versions)
@armCommonTypesVersion("v6")
namespace Microsoft.Cdn;

enum Versions {
  `2025-09-01-preview`,
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
model EdgeAction is TrackedResource<EdgeActionProperties> {
  @path
  @doc("The name of the Edge Action")
  @segment("edgeActions")
  @key("edgeActionName")
  @visibility(Lifecycle.Read)
  name: smallString;

  @doc("The sku type of the edge action")
  sku: SkuType;
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
  @Autorest.example("./examples/EdgeActions_Get.json", "Get EdgeAction")
  get is ArmResourceRead<EdgeAction>;

  @Autorest.example("./examples/EdgeActions_Create.json", "Create EdgeAction")
  create is ArmResourceCreateOrUpdateAsync<EdgeAction>;

  @Autorest.example("./examples/EdgeActions_Update.json", "Update EdgeAction")
  update is ArmResourcePatchAsync<EdgeAction, EdgeActionProperties>;

  @Autorest.example("./examples/EdgeActions_Delete.json", "Delete EdgeAction")
  delete is ArmResourceDeleteWithoutOkAsync<EdgeAction>;

  @Autorest.example(
    "./examples/EdgeActions_ListByResourceGroup.json",
    "List EdgeActions by ResourceGroup"
  )
  listByResourceGroup is ArmResourceListByParent<EdgeAction>;

  @Autorest.example(
    "./examples/EdgeActions_ListBySubscription.json",
    "List EdgeActions by Subscription"
  )
  listBySubscription is ArmListBySubscription<EdgeAction>;

  @Autorest.example(
    "./examples/EdgeActions_AddAttachment.json",
    "Add Attachment to EdgeAction"
  )
  addAttachment is ArmResourceActionAsync<
    EdgeAction,
    EdgeActionAttachment,
    EdgeActionAttachmentResponse
  >;

  @Autorest.example(
    "./examples/EdgeActions_DeleteAttachment.json",
    "Delete Attachment from EdgeAction"
  )
  deleteAttachment is ArmResourceActionAsync<
    EdgeAction,
    EdgeActionAttachment,
    EmptyBody
  >;
}

@armResourceOperations
interface EdgeActionVersions {
  @Autorest.example(
    "./examples/EdgeActionsVersions_Get.json",
    "Get EdgeActionVersion"
  )
  get is ArmResourceRead<EdgeActionVersion>;

  @Autorest.example(
    "./examples/EdgeActionsVersions_Create.json",
    "Create EdgeActionVersion"
  )
  create is ArmResourceCreateOrUpdateAsync<EdgeActionVersion>;

  @Autorest.example(
    "./examples/EdgeActionsVersions_Update.json",
    "Update EdgeActionVersion"
  )
  update is ArmResourcePatchAsync<
    EdgeActionVersion,
    EdgeActionVersionProperties
  >;

  @Autorest.example(
    "./examples/EdgeActionsVersions_Delete.json",
    "Delete EdgeActionVersion"
  )
  delete is ArmResourceDeleteWithoutOkAsync<EdgeActionVersion>;

  @Autorest.example(
    "./examples/EdgeActionsVersions_ListByEdgeAction.json",
    "List EdgeActionVersions by EdgeAction"
  )
  listByResourceGroup is ArmResourceListByParent<EdgeActionVersion>;

  @Autorest.example(
    "./examples/EdgeActionVersions_ListBySubscription.json",
    "List EdgeActionVersions by Subscription"
  )
  listBySubscription is ArmListBySubscription<EdgeActionVersion>;

  @Autorest.example(
    "./examples/EdgeActionVersions_DeployVersionCode.json",
    "Deploy Version Code"
  )
  deployVersionCode is ArmResourceActionAsync<
    EdgeActionVersion,
    VersionCode,
    EdgeActionVersionProperties
  >;

  @Autorest.example(
    "./examples/EdgeActionVersions_GetVersionCode.json",
    "Get Version Code"
  )
  getVersionCode is ArmResourceActionAsync<
    EdgeActionVersion,
    EmptyBody,
    VersionCode
  >;

  @Autorest.example(
    "./examples/EdgeActionVersions_SwapDefault.json",
    "Swap Default Version"
  )
  swapDefault is ArmResourceActionAsync<
    EdgeActionVersion,
    EmptyBody,
    EmptyBody
  >;
}

@armResourceOperations
interface EdgeActionExecutionFilters {
  @Autorest.example(
    "./examples/EdgeActionsExecutionFilters_Get.json",
    "Get EdgeActionExecutionFilter"
  )
  get is ArmResourceRead<EdgeActionExecutionFilter>;

  @Autorest.example(
    "./examples/EdgeActionsExecutionFilters_Create.json",
    "Create EdgeActionExecutionFilter"
  )
  create is ArmResourceCreateOrUpdateAsync<EdgeActionExecutionFilter>;

  @Autorest.example(
    "./examples/EdgeActionsExecutionFilters_Update.json",
    "Update EdgeActionExecutionFilter"
  )
  update is ArmResourcePatchAsync<
    EdgeActionExecutionFilter,
    EdgeActionExecutionFilterProperties
  >;

  @Autorest.example(
    "./examples/EdgeActionsExecutionFilters_Delete.json",
    "Delete EdgeActionExecutionFilter"
  )
  delete is ArmResourceDeleteWithoutOkAsync<EdgeActionExecutionFilter>;

  @Autorest.example(
    "./examples/EdgeActionsExecutionFilters_ListByEdgeAction.json",
    "List EdgeActionExecutionFilters by EdgeAction"
  )
  listByResourceGroup is ArmResourceListByParent<EdgeActionExecutionFilter>;

  @Autorest.example(
    "./examples/EdgeActionExecutionFilters_ListBySubscription.json",
    "List EdgeActionExecutionFilters by Subscription"
  )
  listBySubscription is ArmListBySubscription<EdgeActionExecutionFilter>;
}
