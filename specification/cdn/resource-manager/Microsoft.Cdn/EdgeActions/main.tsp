import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./edgeactionsbasemodels.tsp";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.Core;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations interface defined in main CDN swagger, not in EdgeActions-specific swagger"
@armProviderNamespace
@service(#{ title: "Microsoft.Cdn/EdgeAction" })
@versioned(Versions)
@armCommonTypesVersion("v6")
namespace Microsoft.Cdn;

enum Versions {
  `2025-09-01-preview`,
  `2025-12-01-preview`,
  `2026-10-01`,

  /** Preview contract with explicit request visibility and operation polling. */
  @previewVersion
  `2027-01-01-preview`,
}

/** Operation-status and final-result headers for asynchronous operations. */
alias EdgeActionLroHeaders<
  FinalResult extends TypeSpec.Reflection.Model | unknown | void
> = ArmCombinedLroHeaders<
  StatusMonitor = EdgeActionOperation,
  FinalResult = FinalResult
> &
  Azure.Core.Foundations.RetryAfterHeader;

/** Operation-status headers for asynchronous PUT responses. */
alias EdgeActionPutLroHeaders<Resource extends Azure.ResourceManager.Foundations.SimpleResource> = ArmAsyncOperationHeader<
  StatusMonitor = EdgeActionOperation,
  FinalResult = Resource
> &
  Azure.Core.Foundations.RetryAfterHeader;

@doc("Resource '{name}' update operation succeeded", Resource)
model EdgeActionUpdatedLroResponse<Resource extends Azure.ResourceManager.Foundations.SimpleResource> {
  ...ArmResourceUpdatedResponse<Resource>;
  ...EdgeActionPutLroHeaders<Resource>;
}

/** Preview operation-status and final-result headers. */
alias EdgeActionPreviewLroHeaders<
  FinalResult extends TypeSpec.Reflection.Model | unknown | void
> = ArmCombinedLroHeaders<
  StatusMonitor = EdgeActionOperationStatus,
  FinalResult = FinalResult
> &
  EdgeActionRetryAfterHeader;

/** Preview operation-status headers for resource PUT responses. */
alias EdgeActionPreviewPutLroHeaders<Resource extends Azure.ResourceManager.Foundations.SimpleResource> = ArmAsyncOperationHeader<
  StatusMonitor = EdgeActionOperationStatus,
  FinalResult = Resource
> &
  EdgeActionRetryAfterHeader;

/** Resource replacement response with preview polling metadata. */
@doc("Resource '{name}' update operation succeeded", Resource)
model EdgeActionPreviewUpdatedLroResponse<Resource extends Azure.ResourceManager.Foundations.SimpleResource> {
  ...ArmResourceUpdatedResponse<Resource>;
  ...EdgeActionPreviewPutLroHeaders<Resource>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "SKU property required at envelope level for backwards compatibility with 2024-07-22-preview"
@removed(Versions.`2027-01-01-preview`)
@renamedFrom(Versions.`2027-01-01-preview`, "EdgeAction")
model EdgeActionLegacy is TrackedResource<EdgeActionProperties> {
  @path
  @doc("The name of the Edge Action")
  @segment("edgeActions")
  @key("edgeActionName")
  @visibility(Lifecycle.Read)
  name: smallString;

  @doc("The sku type of the edge action")
  sku: SkuType;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Retain the existing SDK property flattening."
#suppress "@azure-tools/typespec-azure-core/no-openapi-client-extensions" "Retain the existing SDK property flattening."
@@extension(EdgeActionLegacy.properties, "x-ms-client-flatten", true);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility with 2024-07-22-preview"
@@extension(
  EdgeActionLegacy.properties,
  "x-ms-mutability",
  #["read", "create"]
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "SKU property required at envelope level for backwards compatibility with 2024-07-22-preview"
@added(Versions.`2027-01-01-preview`)
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

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Retain the existing SDK property flattening."
#suppress "@azure-tools/typespec-azure-core/no-openapi-client-extensions" "Retain the existing SDK property flattening."
@@extension(EdgeAction.properties, "x-ms-client-flatten", true);
@@visibility(
  EdgeAction.properties,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);

@parentResource(EdgeActionLegacy)
@removed(Versions.`2027-01-01-preview`)
@renamedFrom(Versions.`2027-01-01-preview`, "EdgeActionVersion")
model EdgeActionVersionLegacy is TrackedResource<EdgeActionVersionProperties> {
  @path
  @doc("The name of the Edge Action version")
  @segment("versions")
  @key("version")
  @visibility(Lifecycle.Read)
  name: smallString;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Retain the existing SDK property flattening."
#suppress "@azure-tools/typespec-azure-core/no-openapi-client-extensions" "Retain the existing SDK property flattening."
@@extension(EdgeActionVersionLegacy.properties, "x-ms-client-flatten", true);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility with 2024-07-22-preview"
@@extension(
  EdgeActionVersionLegacy.properties,
  "x-ms-mutability",
  #["read", "create"]
);

@parentResource(EdgeAction)
@added(Versions.`2027-01-01-preview`)
model EdgeActionVersion is TrackedResource<EdgeActionVersionProperties> {
  @path
  @doc("The name of the Edge Action version")
  @segment("versions")
  @key("version")
  @visibility(Lifecycle.Read)
  name: smallString;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Retain the existing SDK property flattening."
#suppress "@azure-tools/typespec-azure-core/no-openapi-client-extensions" "Retain the existing SDK property flattening."
@@extension(EdgeActionVersion.properties, "x-ms-client-flatten", true);
@@visibility(
  EdgeActionVersion.properties,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);

@parentResource(EdgeActionLegacy)
@removed(Versions.`2027-01-01-preview`)
@renamedFrom(Versions.`2027-01-01-preview`, "EdgeActionExecutionFilter")
model EdgeActionExecutionFilterLegacy
  is TrackedResource<EdgeActionExecutionFilterProperties> {
  @path
  @doc("The name of the execution filter")
  @segment("executionFilters")
  @key("executionFilter")
  @visibility(Lifecycle.Read)
  name: smallString;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Retain the existing SDK property flattening."
#suppress "@azure-tools/typespec-azure-core/no-openapi-client-extensions" "Retain the existing SDK property flattening."
@@extension(
  EdgeActionExecutionFilterLegacy.properties,
  "x-ms-client-flatten",
  true
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility with 2024-07-22-preview"
@@extension(
  EdgeActionExecutionFilterLegacy.properties,
  "x-ms-mutability",
  #["read", "create"]
);

@parentResource(EdgeAction)
@added(Versions.`2027-01-01-preview`)
model EdgeActionExecutionFilter
  is TrackedResource<EdgeActionExecutionFilterProperties> {
  @path
  @doc("The name of the execution filter")
  @segment("executionFilters")
  @key("executionFilter")
  @visibility(Lifecycle.Read)
  name: smallString;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Retain the existing SDK property flattening."
#suppress "@azure-tools/typespec-azure-core/no-openapi-client-extensions" "Retain the existing SDK property flattening."
@@extension(EdgeActionExecutionFilter.properties, "x-ms-client-flatten", true);
@@visibility(
  EdgeActionExecutionFilter.properties,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);

@armResourceOperations
interface EdgeActions {
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "get")
  @sharedRoute
  getLegacy is ArmResourceRead<EdgeActionLegacy>;

  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  get is ArmResourceRead<EdgeAction>;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "create")
  @sharedRoute
  createV1 is ArmResourceCreateOrUpdateAsync<EdgeActionLegacy>;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "create")
  createStable is ArmResourceCreateOrUpdateAsync<
    EdgeActionLegacy,
    LroHeaders = EdgeActionPutLroHeaders<EdgeActionLegacy>,
    Response =
      | EdgeActionUpdatedLroResponse<EdgeActionLegacy>
      | ArmResourceCreatedResponse<
          EdgeActionLegacy,
          EdgeActionPutLroHeaders<EdgeActionLegacy>
        >
  >;

  /** Creates or replaces an Edge Action. */
  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  create is ArmResourceCreateOrReplaceAsync<
    EdgeAction,
    LroHeaders = EdgeActionPreviewPutLroHeaders<EdgeAction>,
    Response =
      | EdgeActionPreviewUpdatedLroResponse<EdgeAction>
      | ArmResourceCreatedResponse<
          EdgeAction,
          EdgeActionPreviewPutLroHeaders<EdgeAction>
        >
  >;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "update")
  @sharedRoute
  updateV1 is ArmCustomPatchAsync<EdgeActionLegacy, EdgeActionUpdateV1>;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  @doc("Updates the tags of an Edge Action. Omitted tags are preserved, an empty tags object clears all tags, and supplied tags replace the entire tag collection. Null tags are rejected. Do not include sku in PATCH requests; any supplied sku, including null or the existing value, is rejected.")
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "update")
  updateStable is ArmCustomPatchAsync<
    EdgeActionLegacy,
    EdgeActionUpdate,
    LroHeaders = EdgeActionLroHeaders<EdgeActionLegacy>
  >;

  /** Updates only tags. Omitted tags are preserved, an empty object clears all tags, and supplied tags replace the entire collection. Null tags are rejected. */
  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  update is ArmCustomPatchAsync<
    EdgeAction,
    EdgeActionUpdate,
    LroHeaders = EdgeActionPreviewLroHeaders<EdgeAction>
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "delete")
  @sharedRoute
  deleteV1 is ArmResourceDeleteWithoutOkAsync<
    EdgeActionLegacy,
    Azure.ResourceManager.Foundations.BaseParameters<EdgeActionLegacy>,
    ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader,
    {},
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @added(Versions.`2026-10-01`)
  @sharedRoute
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "delete")
  deleteStable is ArmResourceDeleteWithoutOkAsync<
    EdgeActionLegacy,
    BaseParameters = Azure.ResourceManager.Foundations.BaseParameters<EdgeActionLegacy>,
    LroHeaders = EdgeActionLroHeaders<void>,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<EdgeActionLroHeaders<void>>
      | ArmDeletedNoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Preserve synchronous 200, asynchronous 202, and idempotent 204 responses."
  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    EdgeAction,
    LroHeaders = EdgeActionPreviewLroHeaders<void>,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<EdgeActionPreviewLroHeaders<void>>
      | ArmDeletedNoContentResponse
  >;
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "listByResourceGroup")
  @sharedRoute
  listByResourceGroupLegacy is ArmResourceListByParent<EdgeActionLegacy>;

  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  listByResourceGroup is ArmResourceListByParent<EdgeAction>;
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "listBySubscription")
  @sharedRoute
  listBySubscriptionLegacy is ArmListBySubscription<EdgeActionLegacy>;

  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  listBySubscription is ArmListBySubscription<EdgeAction>;

  @doc("A long-running resource action.")
  @removed(Versions.`2025-12-01-preview`)
  addAttachment is ArmResourceActionAsync<
    EdgeActionLegacy,
    EdgeActionAttachment,
    EdgeActionAttachmentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Operation matches 2024 baseline with 200, 202 responses"
  @doc("A long-running resource action.")
  @removed(Versions.`2025-12-01-preview`)
  deleteAttachment is ArmResourceActionNoContentAsync<
    EdgeActionLegacy,
    EdgeActionAttachment
  >;
}

@armResourceOperations
interface EdgeActionVersions {
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "get")
  @sharedRoute
  getLegacy is ArmResourceRead<EdgeActionVersionLegacy>;

  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  get is ArmResourceRead<EdgeActionVersion>;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "create")
  @sharedRoute
  createV1 is ArmResourceCreateOrUpdateAsync<EdgeActionVersionLegacy>;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "create")
  createStable is ArmResourceCreateOrUpdateAsync<
    EdgeActionVersionLegacy,
    LroHeaders = EdgeActionPutLroHeaders<EdgeActionVersionLegacy>,
    Response =
      | EdgeActionUpdatedLroResponse<EdgeActionVersionLegacy>
      | ArmResourceCreatedResponse<
          EdgeActionVersionLegacy,
          EdgeActionPutLroHeaders<EdgeActionVersionLegacy>
        >
  >;

  /** Creates or replaces an Edge Action version. */
  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  create is ArmResourceCreateOrReplaceAsync<
    EdgeActionVersion,
    LroHeaders = EdgeActionPreviewPutLroHeaders<EdgeActionVersion>,
    Response =
      | EdgeActionPreviewUpdatedLroResponse<EdgeActionVersion>
      | ArmResourceCreatedResponse<
          EdgeActionVersion,
          EdgeActionPreviewPutLroHeaders<EdgeActionVersion>
        >
  >;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "update")
  @sharedRoute
  updateV1 is ArmCustomPatchAsync<
    EdgeActionVersionLegacy,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      EdgeActionVersionLegacy,
      EdgeActionVersionProperties
    >
  >;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  @doc("Updates the tags of an Edge Action version. Omitted tags are preserved, an empty tags object clears all tags, and supplied tags replace the entire tag collection. Null tags are rejected. Version properties are not changed. If deploymentType or isDefaultVersion is supplied, it must match the existing value; use swapDefault to change the default version.")
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "update")
  updateStable is ArmCustomPatchAsync<
    EdgeActionVersionLegacy,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      EdgeActionVersionLegacy,
      EdgeActionVersionProperties
    >,
    LroHeaders = EdgeActionLroHeaders<EdgeActionVersionLegacy>
  >;

  /** Updates only version tags. Omitted tags are preserved, an empty object clears all tags, and supplied tags replace the entire collection. Null tags are rejected. Use swapDefault to change the default version. */
  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  update is ArmCustomPatchAsync<
    EdgeActionVersion,
    EdgeActionVersionUpdate,
    LroHeaders = EdgeActionPreviewLroHeaders<EdgeActionVersion>
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "delete")
  @sharedRoute
  deleteV1 is ArmResourceDeleteWithoutOkAsync<
    EdgeActionVersionLegacy,
    Azure.ResourceManager.Foundations.BaseParameters<EdgeActionVersionLegacy>,
    ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader,
    {},
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @added(Versions.`2026-10-01`)
  @sharedRoute
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "delete")
  deleteStable is ArmResourceDeleteWithoutOkAsync<
    EdgeActionVersionLegacy,
    BaseParameters = Azure.ResourceManager.Foundations.BaseParameters<EdgeActionVersionLegacy>,
    LroHeaders = EdgeActionLroHeaders<void>,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<EdgeActionLroHeaders<void>>
      | ArmDeletedNoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Preserve synchronous 200, asynchronous 202, and idempotent 204 responses."
  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    EdgeActionVersion,
    LroHeaders = EdgeActionPreviewLroHeaders<void>,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<EdgeActionPreviewLroHeaders<void>>
      | ArmDeletedNoContentResponse
  >;
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "listByEdgeAction")
  @sharedRoute
  listByEdgeActionLegacy is ArmResourceListByParent<EdgeActionVersionLegacy>;

  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  listByEdgeAction is ArmResourceListByParent<EdgeActionVersion>;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "deployVersionCode")
  @sharedRoute
  @action("deployVersionCode")
  @doc("A long-running resource action.")
  deployVersionCodeV1 is ArmResourceActionAsync<
    EdgeActionVersionLegacy,
    VersionCode,
    EdgeActionVersionProperties
  >;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  @action("deployVersionCode")
  @doc("A long-running resource action.")
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "deployVersionCode")
  deployVersionCodeStable is ArmResourceActionAsync<
    EdgeActionVersionLegacy,
    VersionCode,
    EdgeActionVersionLegacy,
    LroHeaders = EdgeActionLroHeaders<EdgeActionVersionLegacy>
  >;

  /** Deploys code to an Edge Action version and returns the complete version resource. */
  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  @action("deployVersionCode")
  deployVersionCode is ArmResourceActionAsync<
    EdgeActionVersion,
    VersionCode,
    EdgeActionVersion,
    LroHeaders = EdgeActionPreviewLroHeaders<EdgeActionVersion>
  >;

  /** Get the version code for the edge action version. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Explicitly set content type for POST operations - expected by service"
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "getVersionCode")
  @sharedRoute
  @action("getVersionCode")
  getVersionCodeV1 is ArmResourceActionAsync<
    EdgeActionVersionLegacy,
    void,
    VersionCode,
    Parameters = {
      /** Content type */
      @header contentType: "application/json";
    }
  >;

  /** Get the version code for the edge action version. */
  @added(Versions.`2026-10-01`)
  @sharedRoute
  @action("getVersionCode")
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "getVersionCode")
  getVersionCodeStable is ArmResourceActionAsync<
    EdgeActionVersionLegacy,
    void,
    VersionCode,
    LroHeaders = EdgeActionLroHeaders<VersionCode>,
    Parameters = {
      /** Content type */
      @header contentType: "application/json";
    }
  >;

  /** Gets the deployed code synchronously. */
  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  @action("getVersionCode")
  getVersionCode is ArmResourceActionSync<EdgeActionVersion, void, VersionCode>;

  /** Swap the default version for the edge action. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Explicitly set content type for POST operations - expected by service"
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "swapDefault")
  @sharedRoute
  @action("swapDefault")
  swapDefaultV1 is ArmResourceActionNoContentAsync<
    EdgeActionVersionLegacy,
    void,
    Parameters = {
      /** Content type */
      @header contentType: "application/json";
    }
  >;

  /** Swap the default version for the edge action. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Explicitly set content type for POST operations - expected by service"
  @added(Versions.`2026-10-01`)
  @sharedRoute
  @action("swapDefault")
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "swapDefault")
  swapDefaultStable is ArmResourceActionNoContentAsync<
    EdgeActionVersionLegacy,
    void,
    LroHeaders = EdgeActionLroHeaders<void>,
    Parameters = {
      /** Content type */
      @header contentType: "application/json";
    }
  >;

  /** Selects the default version without a request body. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "The final response has no content, so 204 is returned."
  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  @action("swapDefault")
  swapDefault is ArmResourceActionNoContentAsync<
    EdgeActionVersion,
    void,
    LroHeaders = EdgeActionPreviewLroHeaders<void>
  >;
}

@armResourceOperations
interface EdgeActionExecutionFilters {
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "get")
  @sharedRoute
  getLegacy is ArmResourceRead<EdgeActionExecutionFilterLegacy>;

  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  get is ArmResourceRead<EdgeActionExecutionFilter>;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "create")
  @sharedRoute
  createV1 is ArmResourceCreateOrUpdateAsync<EdgeActionExecutionFilterLegacy>;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "create")
  createStable is ArmResourceCreateOrUpdateAsync<
    EdgeActionExecutionFilterLegacy,
    LroHeaders = EdgeActionPutLroHeaders<EdgeActionExecutionFilterLegacy>,
    Response =
      | EdgeActionUpdatedLroResponse<EdgeActionExecutionFilterLegacy>
      | ArmResourceCreatedResponse<
          EdgeActionExecutionFilterLegacy,
          EdgeActionPutLroHeaders<EdgeActionExecutionFilterLegacy>
        >
  >;

  /** Creates or replaces an execution filter, including its version and identifier headers. */
  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  create is ArmResourceCreateOrReplaceAsync<
    EdgeActionExecutionFilter,
    LroHeaders = EdgeActionPreviewPutLroHeaders<EdgeActionExecutionFilter>,
    Response =
      | EdgeActionPreviewUpdatedLroResponse<EdgeActionExecutionFilter>
      | ArmResourceCreatedResponse<
          EdgeActionExecutionFilter,
          EdgeActionPreviewPutLroHeaders<EdgeActionExecutionFilter>
        >
  >;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "update")
  @sharedRoute
  updateV1 is ArmCustomPatchAsync<
    EdgeActionExecutionFilterLegacy,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      EdgeActionExecutionFilterLegacy,
      EdgeActionExecutionFilterProperties
    >
  >;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  @doc("Updates the properties and tags of an Edge Action execution filter. Omitted tags are preserved, an empty tags object clears all tags, and supplied tags replace the entire tag collection. Null tags are rejected.")
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "update")
  updateStable is ArmCustomPatchAsync<
    EdgeActionExecutionFilterLegacy,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      EdgeActionExecutionFilterLegacy,
      EdgeActionExecutionFilterProperties
    >,
    LroHeaders = EdgeActionLroHeaders<EdgeActionExecutionFilterLegacy>
  >;

  /** Updates filter properties and tags. Omitted fields are preserved. Empty tags clear all tags, supplied tags replace the collection, and null tags are rejected. */
  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  update is ArmCustomPatchAsync<
    EdgeActionExecutionFilter,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      EdgeActionExecutionFilter,
      EdgeActionExecutionFilterProperties
    >,
    LroHeaders = EdgeActionPreviewLroHeaders<EdgeActionExecutionFilter>
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "delete")
  @sharedRoute
  deleteV1 is ArmResourceDeleteWithoutOkAsync<
    EdgeActionExecutionFilterLegacy,
    Azure.ResourceManager.Foundations.BaseParameters<EdgeActionExecutionFilterLegacy>,
    ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader,
    {},
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @added(Versions.`2026-10-01`)
  @sharedRoute
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "delete")
  deleteStable is ArmResourceDeleteWithoutOkAsync<
    EdgeActionExecutionFilterLegacy,
    BaseParameters = Azure.ResourceManager.Foundations.BaseParameters<EdgeActionExecutionFilterLegacy>,
    LroHeaders = EdgeActionLroHeaders<void>,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<EdgeActionLroHeaders<void>>
      | ArmDeletedNoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Preserve synchronous 200, asynchronous 202, and idempotent 204 responses."
  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    EdgeActionExecutionFilter,
    LroHeaders = EdgeActionPreviewLroHeaders<void>,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<EdgeActionPreviewLroHeaders<void>>
      | ArmDeletedNoContentResponse
  >;
  @removed(Versions.`2027-01-01-preview`)
  @renamedFrom(Versions.`2027-01-01-preview`, "listByEdgeAction")
  @sharedRoute
  listByEdgeActionLegacy is ArmResourceListByParent<EdgeActionExecutionFilterLegacy>;

  @added(Versions.`2027-01-01-preview`)
  @sharedRoute
  listByEdgeAction is ArmResourceListByParent<EdgeActionExecutionFilter>;
}

/** Status polling addressed by Azure-AsyncOperation. */
@added(Versions.`2027-01-01-preview`)
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface EdgeActionOperations {
  /** Gets the operation status. A failed operation is reported in the body of an HTTP 200 response. */
  @tag("EdgeActionOperations")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/edgeActionOperations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...Azure.ResourceManager.Foundations.OperationIdParameter,
  ): ArmResponse<EdgeActionOperationStatus> | ErrorResponse;
}

/** Final-result polling addressed by Location, distinct from the operation status envelope. */
@added(Versions.`2027-01-01-preview`)
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface EdgeActionOperationResults {
  /** Gets the operation-specific synchronous result, or 202 with Location while pending. Failed operations return the corresponding HTTP error and standard error body. */
  @tag("EdgeActionOperationResults")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cdn/edgeActionOperationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...Azure.ResourceManager.Foundations.OperationIdParameter,
  ):
    | EdgeActionOperationCompletedResult
    | (AcceptedResponse & EdgeActionOperationResultPollingHeaders)
    | ArmNoContentResponse<"The operation completed successfully and produced no content.">
    | ErrorResponse;
}
