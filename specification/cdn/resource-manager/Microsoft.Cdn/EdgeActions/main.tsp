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
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "SKU property required at envelope level for backwards compatibility with 2024-07-22-preview"
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

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility with 2024-07-22-preview"
#suppress "@azure-tools/typespec-azure-core/no-openapi-client-extensions" "Existing use of the 'x-ms-client-flatten' OpenAPI extension predates the no-openapi-client-extensions rule; suppressed pending migration to explicit modeling without flattening."
@@extension(EdgeAction.properties, "x-ms-client-flatten", true);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility with 2024-07-22-preview"
@@extension(EdgeAction.properties, "x-ms-mutability", #["read", "create"]);

@parentResource(EdgeAction)
model EdgeActionVersion is TrackedResource<EdgeActionVersionProperties> {
  @path
  @doc("The name of the Edge Action version")
  @segment("versions")
  @key("version")
  @visibility(Lifecycle.Read)
  name: smallString;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility with 2024-07-22-preview"
#suppress "@azure-tools/typespec-azure-core/no-openapi-client-extensions" "Existing use of the 'x-ms-client-flatten' OpenAPI extension predates the no-openapi-client-extensions rule; suppressed pending migration to explicit modeling without flattening."
@@extension(EdgeActionVersion.properties, "x-ms-client-flatten", true);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility with 2024-07-22-preview"
@@extension(
  EdgeActionVersion.properties,
  "x-ms-mutability",
  #["read", "create"]
);

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

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility with 2024-07-22-preview"
#suppress "@azure-tools/typespec-azure-core/no-openapi-client-extensions" "Existing use of the 'x-ms-client-flatten' OpenAPI extension predates the no-openapi-client-extensions rule; suppressed pending migration to explicit modeling without flattening."
@@extension(EdgeActionExecutionFilter.properties, "x-ms-client-flatten", true);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility with 2024-07-22-preview"
@@extension(
  EdgeActionExecutionFilter.properties,
  "x-ms-mutability",
  #["read", "create"]
);

@armResourceOperations
interface EdgeActions {
  get is ArmResourceRead<EdgeAction>;

  @sharedRoute
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "create")
  createPreview is ArmResourceCreateOrUpdateAsync<EdgeAction>;

  @sharedRoute
  @added(Versions.`2026-10-01`)
  create is ArmResourceCreateOrReplaceAsync<
    EdgeAction,
    LroHeaders = EdgeActionPutLroHeaders<EdgeAction>,
    Response =
      | EdgeActionResourceUpdatedLroResponse<EdgeAction>
      | ArmResourceCreatedResponse<
          EdgeAction,
          EdgeActionPutLroHeaders<EdgeAction>
        >
  >;

  @sharedRoute
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "update")
  updatePreview is ArmCustomPatchAsync<EdgeAction, EdgeActionUpdate>;

  @sharedRoute
  @added(Versions.`2026-10-01`)
  update is ArmCustomPatchAsync<
    EdgeAction,
    EdgeActionUpdate,
    LroHeaders = ArmCombinedLroHeaders<
      EdgeActionOperationStatus,
      EdgeAction
    > &
      EdgeActionRetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @sharedRoute
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "delete")
  deletePreview is ArmResourceDeleteWithoutOkAsync<
    EdgeAction,
    Azure.ResourceManager.Foundations.BaseParameters<EdgeAction>,
    ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader,
    {},
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The EdgeActions contract preserves synchronous 200 alongside asynchronous 202 and idempotent 204 delete responses."
  @sharedRoute
  @added(Versions.`2026-10-01`)
  delete is ArmResourceDeleteWithoutOkAsync<
    EdgeAction,
    Azure.ResourceManager.Foundations.BaseParameters<EdgeAction>,
    ArmCombinedLroHeaders<
      StatusMonitor = EdgeActionOperationStatus,
      FinalResult = void
    > &
      EdgeActionRetryAfterHeader,
    {},
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<
        StatusMonitor = EdgeActionOperationStatus,
        FinalResult = void
      > &
        EdgeActionRetryAfterHeader>
    | ArmDeletedNoContentResponse
  >;

  listByResourceGroup is ArmResourceListByParent<EdgeAction>;
  listBySubscription is ArmListBySubscription<EdgeAction>;

  @doc("A long-running resource action.")
  @removed(Versions.`2025-12-01-preview`)
  addAttachment is ArmResourceActionAsync<
    EdgeAction,
    EdgeActionAttachment,
    EdgeActionAttachmentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Operation matches 2024 baseline with 200, 202 responses"
  @doc("A long-running resource action.")
  @removed(Versions.`2025-12-01-preview`)
  deleteAttachment is ArmResourceActionNoContentAsync<
    EdgeAction,
    EdgeActionAttachment
  >;
}

@armResourceOperations
interface EdgeActionVersions {
  get is ArmResourceRead<EdgeActionVersion>;

  @sharedRoute
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "create")
  createPreview is ArmResourceCreateOrUpdateAsync<EdgeActionVersion>;

  @sharedRoute
  @added(Versions.`2026-10-01`)
  create is ArmResourceCreateOrReplaceAsync<
    EdgeActionVersion,
    LroHeaders = EdgeActionPutLroHeaders<EdgeActionVersion>,
    Response =
      | EdgeActionResourceUpdatedLroResponse<EdgeActionVersion>
      | ArmResourceCreatedResponse<
          EdgeActionVersion,
          EdgeActionPutLroHeaders<EdgeActionVersion>
        >
  >;

  @sharedRoute
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "update")
  updatePreview is ArmCustomPatchAsync<
    EdgeActionVersion,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      EdgeActionVersion,
      EdgeActionVersionProperties
    >
  >;

  @sharedRoute
  @added(Versions.`2026-10-01`)
  update is ArmCustomPatchAsync<
    EdgeActionVersion,
    EdgeActionVersionUpdate,
    LroHeaders = ArmCombinedLroHeaders<
      StatusMonitor = EdgeActionOperationStatus,
      FinalResult = EdgeActionVersion
    > &
      EdgeActionRetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @sharedRoute
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "delete")
  deletePreview is ArmResourceDeleteWithoutOkAsync<
    EdgeActionVersion,
    Azure.ResourceManager.Foundations.BaseParameters<EdgeActionVersion>,
    ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader,
    {},
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The EdgeActions contract preserves synchronous 200 alongside asynchronous 202 and idempotent 204 delete responses."
  @sharedRoute
  @added(Versions.`2026-10-01`)
  delete is ArmResourceDeleteWithoutOkAsync<
    EdgeActionVersion,
    Azure.ResourceManager.Foundations.BaseParameters<EdgeActionVersion>,
    ArmCombinedLroHeaders<
      StatusMonitor = EdgeActionOperationStatus,
      FinalResult = void
    > &
      EdgeActionRetryAfterHeader,
    {},
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<
        StatusMonitor = EdgeActionOperationStatus,
        FinalResult = void
      > &
        EdgeActionRetryAfterHeader>
    | ArmDeletedNoContentResponse
  >;

  listByEdgeAction is ArmResourceListByParent<EdgeActionVersion>;

  @doc("A long-running resource action.")
  @sharedRoute
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "deployVersionCode")
  deployVersionCodePreview is ArmResourceActionAsync<
    EdgeActionVersion,
    VersionCode,
    EdgeActionVersionProperties
  >;

  /** Deploys code to an edge action version. */
  @sharedRoute
  @added(Versions.`2026-10-01`)
  deployVersionCode is ArmResourceActionAsync<
    EdgeActionVersion,
    VersionCode,
    EdgeActionVersionProperties,
    LroHeaders = ArmCombinedLroHeaders<
      StatusMonitor = EdgeActionOperationStatus,
      FinalResult = EdgeActionVersionProperties
    > &
      EdgeActionRetryAfterHeader
  >;

  /** Get the version code for the edge action version. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Explicitly set content type for POST operations - expected by service"
  @sharedRoute
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "getVersionCode")
  getVersionCodePreview is ArmResourceActionAsync<
    EdgeActionVersion,
    void,
    VersionCode,
    Parameters = {
      /** Content type */
      @header contentType: "application/json";
    }
  >;

  /** Gets the deployed code for an edge action version. */
  @sharedRoute
  @added(Versions.`2026-10-01`)
  getVersionCode is ArmResourceActionSync<EdgeActionVersion, void, VersionCode>;

  /** Swap the default version for the edge action. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Explicitly set content type for POST operations - expected by service"
  @sharedRoute
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "swapDefault")
  swapDefaultPreview is ArmResourceActionNoContentAsync<
    EdgeActionVersion,
    void,
    Parameters = {
      /** Content type */
      @header contentType: "application/json";
    }
  >;

  /** Swaps the default edge action version. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "The final response has no content, so 204 is returned."
  @sharedRoute
  @added(Versions.`2026-10-01`)
  swapDefault is ArmResourceActionNoContentAsync<
    EdgeActionVersion,
    void,
    LroHeaders = ArmCombinedLroHeaders<
      StatusMonitor = EdgeActionOperationStatus,
      FinalResult = void
    > &
      EdgeActionRetryAfterHeader
  >;
}

@armResourceOperations
interface EdgeActionExecutionFilters {
  get is ArmResourceRead<EdgeActionExecutionFilter>;

  @sharedRoute
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "create")
  createPreview is ArmResourceCreateOrUpdateAsync<EdgeActionExecutionFilter>;

  @sharedRoute
  @added(Versions.`2026-10-01`)
  create is ArmResourceCreateOrReplaceAsync<
    EdgeActionExecutionFilter,
    LroHeaders = EdgeActionPutLroHeaders<EdgeActionExecutionFilter>,
    Response =
      | EdgeActionResourceUpdatedLroResponse<EdgeActionExecutionFilter>
      | ArmResourceCreatedResponse<
          EdgeActionExecutionFilter,
          EdgeActionPutLroHeaders<EdgeActionExecutionFilter>
        >
  >;

  @sharedRoute
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "update")
  updatePreview is ArmCustomPatchAsync<
    EdgeActionExecutionFilter,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      EdgeActionExecutionFilter,
      EdgeActionExecutionFilterProperties
    >
  >;

  @sharedRoute
  @added(Versions.`2026-10-01`)
  update is ArmCustomPatchAsync<
    EdgeActionExecutionFilter,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      EdgeActionExecutionFilter,
      EdgeActionExecutionFilterProperties
    >,
    LroHeaders = ArmCombinedLroHeaders<
      StatusMonitor = EdgeActionOperationStatus,
      FinalResult = EdgeActionExecutionFilter
    > &
      EdgeActionRetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @sharedRoute
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "delete")
  deletePreview is ArmResourceDeleteWithoutOkAsync<
    EdgeActionExecutionFilter,
    Azure.ResourceManager.Foundations.BaseParameters<EdgeActionExecutionFilter>,
    ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader,
    {},
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The EdgeActions contract preserves synchronous 200 alongside asynchronous 202 and idempotent 204 delete responses."
  @sharedRoute
  @added(Versions.`2026-10-01`)
  delete is ArmResourceDeleteWithoutOkAsync<
    EdgeActionExecutionFilter,
    Azure.ResourceManager.Foundations.BaseParameters<EdgeActionExecutionFilter>,
    ArmCombinedLroHeaders<
      StatusMonitor = EdgeActionOperationStatus,
      FinalResult = void
    > &
      EdgeActionRetryAfterHeader,
    {},
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<
        StatusMonitor = EdgeActionOperationStatus,
        FinalResult = void
      > &
        EdgeActionRetryAfterHeader>
    | ArmDeletedNoContentResponse
  >;
  listByEdgeAction is ArmResourceListByParent<EdgeActionExecutionFilter>;
}

/**
 * Edge Action asynchronous operation status, addressed by the `Azure-AsyncOperation` header.
 * The route is resource-group scoped because that is the address the service already emits.
 */
@added(Versions.`2026-10-01`)
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface EdgeActionOperations {
  /** Returns the current status of an Edge Action asynchronous operation. */
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

/**
 * Edge Action asynchronous operation results, addressed by the `Location` header. The route is
 * subscription scoped so that the result of a delete outlives the resource group it removed.
 * While the result is not final the endpoint returns `202` and repeats `Location`, as the ARM
 * asynchronous contract requires. On completion it returns the response the originating operation
 * would have produced synchronously: `200` with that operation's own body, or `204` for the
 * operations that complete without one, which are the three deletes and `swapDefault`.
 *
 * This is a different contract from `EdgeActionOperations`, which serves the
 * `Azure-AsyncOperation` status resource. The status body reports an operation record with a
 * `status` field, and a failed operation is still a `200` there. The result body has no `status`
 * field, because the outcome is the HTTP status code, and a failed operation is returned here as
 * the status code the synchronous call would have returned, with the standard error response.
 */
@added(Versions.`2026-10-01`)
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface EdgeActionOperationResults {
  /**
   * Returns the result of an Edge Action asynchronous operation. The `200` body is the body the
   * originating operation would have returned synchronously, so it varies by operation and is not
   * declared as one fixed schema.
   */
  @tag("EdgeActionOperationResults")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cdn/edgeActionOperationResults/{operationId}")
  @get
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The Location result body is the response the originating operation would have produced synchronously, so it varies by operation and OpenAPI cannot key it to the operation the id names. Declaring a fixed schema here would misreport every other operation, and reusing the status model would advertise status and error fields this contract does not have. Published stable precedent for a schema-less result 200 alongside a typed status 200: Microsoft.ApiManagement stable 2024-05-01 operationStatuses.json, Microsoft.Synapse stable 2020-12-01 operations.json, Microsoft.RecoveryServices RecoveryServicesBackup stable 2016-06-01."
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
