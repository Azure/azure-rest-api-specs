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

/** Operation-status and final-result headers for asynchronous operations. */
alias EdgeActionLroHeaders<
  FinalResult extends TypeSpec.Reflection.Model | unknown | void
> = ArmCombinedLroHeaders<FinalResult = FinalResult> &
  Azure.Core.Foundations.RetryAfterHeader;

/** Operation-status headers for asynchronous PUT responses. */
alias EdgeActionPutLroHeaders<Resource extends Azure.ResourceManager.Foundations.SimpleResource> = ArmAsyncOperationHeader<FinalResult = Resource> &
  Azure.Core.Foundations.RetryAfterHeader;

@doc("Resource '{name}' update operation succeeded", Resource)
model EdgeActionUpdatedLroResponse<Resource extends Azure.ResourceManager.Foundations.SimpleResource> {
  ...ArmResourceUpdatedResponse<Resource>;
  ...EdgeActionPutLroHeaders<Resource>;
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

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "create")
  @sharedRoute
  createV1 is ArmResourceCreateOrUpdateAsync<EdgeAction>;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  create is ArmResourceCreateOrUpdateAsync<
    EdgeAction,
    LroHeaders = EdgeActionPutLroHeaders<EdgeAction>,
    Response =
      | EdgeActionUpdatedLroResponse<EdgeAction>
      | ArmResourceCreatedResponse<
          EdgeAction,
          EdgeActionPutLroHeaders<EdgeAction>
        >
  >;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "update")
  @sharedRoute
  updateV1 is ArmCustomPatchAsync<EdgeAction, EdgeActionUpdateV1>;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  @doc("Updates the tags of an Edge Action. Omitted tags are preserved, an empty tags object clears all tags, and supplied tags replace the entire tag collection. Null tags are rejected. Do not include sku in PATCH requests; any supplied sku, including null or the existing value, is rejected.")
  update is ArmCustomPatchAsync<
    EdgeAction,
    EdgeActionUpdate,
    LroHeaders = EdgeActionLroHeaders<EdgeAction>
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "delete")
  @sharedRoute
  deleteV1 is ArmResourceDeleteWithoutOkAsync<
    EdgeAction,
    Azure.ResourceManager.Foundations.BaseParameters<EdgeAction>,
    ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader,
    {},
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @added(Versions.`2026-10-01`)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    EdgeAction,
    BaseParameters = Azure.ResourceManager.Foundations.BaseParameters<EdgeAction>,
    LroHeaders = EdgeActionLroHeaders<void>,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<EdgeActionLroHeaders<void>>
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

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "create")
  @sharedRoute
  createV1 is ArmResourceCreateOrUpdateAsync<EdgeActionVersion>;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  create is ArmResourceCreateOrUpdateAsync<
    EdgeActionVersion,
    LroHeaders = EdgeActionPutLroHeaders<EdgeActionVersion>,
    Response =
      | EdgeActionUpdatedLroResponse<EdgeActionVersion>
      | ArmResourceCreatedResponse<
          EdgeActionVersion,
          EdgeActionPutLroHeaders<EdgeActionVersion>
        >
  >;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "update")
  @sharedRoute
  updateV1 is ArmCustomPatchAsync<
    EdgeActionVersion,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      EdgeActionVersion,
      EdgeActionVersionProperties
    >
  >;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  @doc("Updates the tags of an Edge Action version. Omitted tags are preserved, an empty tags object clears all tags, and supplied tags replace the entire tag collection. Null tags are rejected. Version properties are not changed. If deploymentType or isDefaultVersion is supplied, it must match the existing value; use swapDefault to change the default version.")
  update is ArmCustomPatchAsync<
    EdgeActionVersion,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      EdgeActionVersion,
      EdgeActionVersionProperties
    >,
    LroHeaders = EdgeActionLroHeaders<EdgeActionVersion>
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "delete")
  @sharedRoute
  deleteV1 is ArmResourceDeleteWithoutOkAsync<
    EdgeActionVersion,
    Azure.ResourceManager.Foundations.BaseParameters<EdgeActionVersion>,
    ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader,
    {},
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @added(Versions.`2026-10-01`)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    EdgeActionVersion,
    BaseParameters = Azure.ResourceManager.Foundations.BaseParameters<EdgeActionVersion>,
    LroHeaders = EdgeActionLroHeaders<void>,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<EdgeActionLroHeaders<void>>
      | ArmDeletedNoContentResponse
  >;
  listByEdgeAction is ArmResourceListByParent<EdgeActionVersion>;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "deployVersionCode")
  @sharedRoute
  @action("deployVersionCode")
  @doc("A long-running resource action.")
  deployVersionCodeV1 is ArmResourceActionAsync<
    EdgeActionVersion,
    VersionCode,
    EdgeActionVersionProperties
  >;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  @action("deployVersionCode")
  @doc("A long-running resource action.")
  deployVersionCode is ArmResourceActionAsync<
    EdgeActionVersion,
    VersionCode,
    EdgeActionVersion,
    LroHeaders = EdgeActionLroHeaders<EdgeActionVersion>
  >;

  /** Get the version code for the edge action version. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Explicitly set content type for POST operations - expected by service"
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "getVersionCode")
  @sharedRoute
  @action("getVersionCode")
  getVersionCodeV1 is ArmResourceActionAsync<
    EdgeActionVersion,
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
  getVersionCode is ArmResourceActionAsync<
    EdgeActionVersion,
    void,
    VersionCode,
    LroHeaders = EdgeActionLroHeaders<VersionCode>,
    Parameters = {
      /** Content type */
      @header contentType: "application/json";
    }
  >;

  /** Swap the default version for the edge action. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Explicitly set content type for POST operations - expected by service"
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "swapDefault")
  @sharedRoute
  @action("swapDefault")
  swapDefaultV1 is ArmResourceActionNoContentAsync<
    EdgeActionVersion,
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
  swapDefault is ArmResourceActionNoContentAsync<
    EdgeActionVersion,
    void,
    LroHeaders = EdgeActionLroHeaders<void>,
    Parameters = {
      /** Content type */
      @header contentType: "application/json";
    }
  >;
}

@armResourceOperations
interface EdgeActionExecutionFilters {
  get is ArmResourceRead<EdgeActionExecutionFilter>;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "create")
  @sharedRoute
  createV1 is ArmResourceCreateOrUpdateAsync<EdgeActionExecutionFilter>;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  create is ArmResourceCreateOrUpdateAsync<
    EdgeActionExecutionFilter,
    LroHeaders = EdgeActionPutLroHeaders<EdgeActionExecutionFilter>,
    Response =
      | EdgeActionUpdatedLroResponse<EdgeActionExecutionFilter>
      | ArmResourceCreatedResponse<
          EdgeActionExecutionFilter,
          EdgeActionPutLroHeaders<EdgeActionExecutionFilter>
        >
  >;

  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "update")
  @sharedRoute
  updateV1 is ArmCustomPatchAsync<
    EdgeActionExecutionFilter,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      EdgeActionExecutionFilter,
      EdgeActionExecutionFilterProperties
    >
  >;

  @added(Versions.`2026-10-01`)
  @sharedRoute
  @doc("Updates the properties and tags of an Edge Action execution filter. Omitted tags are preserved, an empty tags object clears all tags, and supplied tags replace the entire tag collection. Null tags are rejected.")
  update is ArmCustomPatchAsync<
    EdgeActionExecutionFilter,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      EdgeActionExecutionFilter,
      EdgeActionExecutionFilterProperties
    >,
    LroHeaders = EdgeActionLroHeaders<EdgeActionExecutionFilter>
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @removed(Versions.`2026-10-01`)
  @renamedFrom(Versions.`2026-10-01`, "delete")
  @sharedRoute
  deleteV1 is ArmResourceDeleteWithoutOkAsync<
    EdgeActionExecutionFilter,
    Azure.ResourceManager.Foundations.BaseParameters<EdgeActionExecutionFilter>,
    ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader,
    {},
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Service returns 200 for successful delete operations"
  @added(Versions.`2026-10-01`)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    EdgeActionExecutionFilter,
    BaseParameters = Azure.ResourceManager.Foundations.BaseParameters<EdgeActionExecutionFilter>,
    LroHeaders = EdgeActionLroHeaders<void>,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<EdgeActionLroHeaders<void>>
      | ArmDeletedNoContentResponse
  >;
  listByEdgeAction is ArmResourceListByParent<EdgeActionExecutionFilter>;
}
