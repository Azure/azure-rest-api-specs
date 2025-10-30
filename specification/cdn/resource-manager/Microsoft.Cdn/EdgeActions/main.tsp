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

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations interface defined in main CDN swagger, not in EdgeActions-specific swagger"
@armProviderNamespace
@service(#{ title: "Microsoft.Cdn/EdgeAction" })
@versioned(Versions)
@armCommonTypesVersion("v6")
namespace Microsoft.Cdn;

enum Versions {
  `2025-09-01-preview`,
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
  listByEdgeAction is ArmResourceListByParent<EdgeActionVersion>;
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
  swapDefault is ArmResourceActionNoContentAsync<EdgeActionVersion, void>;
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
  listByEdgeAction is ArmResourceListByParent<EdgeActionExecutionFilter>;
}
