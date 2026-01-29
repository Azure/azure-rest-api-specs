import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./WorkspaceConnectionPropertiesV2BasicResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

/**
 * RaiBlocklistPropertiesBasicResource is a preview-only resource.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@parentResource(WorkspaceConnectionPropertiesV2BasicResource)
model RaiBlocklistPropertiesBasicResource
  is Azure.ResourceManager.ProxyResource<RaiBlocklistProperties, false> {
  ...ResourceNameParameter<
    Resource = RaiBlocklistPropertiesBasicResource,
    KeyName = "raiBlocklistName",
    SegmentName = "raiBlocklists",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
}

/**
 * RaiBlocklistPropertiesBasicResources interface is preview-only.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@armResourceOperations
interface RaiBlocklistPropertiesBasicResources {
  /**
   * Gets the specified custom blocklist associated with the Azure OpenAI connection.
   */
  @summary("Gets the specified custom blocklist associated with the Azure OpenAI connection.")
  get is ArmResourceRead<RaiBlocklistPropertiesBasicResource>;

  /**
   * Update the state of specified blocklist associated with the Azure OpenAI connection.
   */
  @summary("Update the state of specified blocklist associated with the Azure OpenAI connection.")
  create is ArmResourceCreateOrReplaceAsync<
    RaiBlocklistPropertiesBasicResource,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = RaiBlocklistPropertiesBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified custom blocklist associated with the Azure OpenAI connection.
   */
  @summary("Deletes the specified custom blocklist associated with the Azure OpenAI connection.")
  delete is ArmResourceDeleteWithoutOkAsync<
    RaiBlocklistPropertiesBasicResource,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    }
  >;

  /**
   * Gets the custom blocklists associated with the Azure OpenAI connection.
   */
  @summary("Gets the custom blocklists associated with the Azure OpenAI connection.")
  list is ArmResourceListByParent<
    RaiBlocklistPropertiesBasicResource,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    },
    Response = ArmResponse<RaiBlocklistPropertiesBasicResourceArmPaginatedResult>
  >;

  /**
   * Add multiple blocklist items to the specified blocklist associated with the Azure OpenAI connection.
   */
  @removed(Versions.v2025_12_01)
  @added(Versions.v2026_01_15_preview)
  @summary("Add multiple blocklist items to the specified blocklist associated with the Azure OpenAI connection.")
  @action("addRaiBlocklistItems")
  addBulk is ArmResourceActionAsync<
    RaiBlocklistPropertiesBasicResource,
    RaiBlocklistItemsBulkAddRequest,
    {
      @body
      @identifiers(#[])
      @removed(Versions.v2025_12_01)
      @added(Versions.v2026_01_15_preview)
      _?: RaiBlocklistItemPropertiesBasicResource[];
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = RaiBlocklistItemPropertiesBasicResource[]>
  >;

  /**
   * Delete multiple blocklist items from the specified blocklist associated with the Azure OpenAI connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Existing API returns additional response codes"
  @summary("Delete multiple blocklist items from the specified blocklist associated with the Azure OpenAI connection.")
  @action("deleteRaiBlocklistItems")
  deleteBulk is ArmResourceActionAsync<
    RaiBlocklistPropertiesBasicResource,
    string[],
    Response = void,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(RaiBlocklistPropertiesBasicResource.name,
  "The name of the RaiBlocklist."
);
@@doc(RaiBlocklistPropertiesBasicResource.properties,
  "RAI Custom Blocklist properties."
);
@@doc(RaiBlocklistPropertiesBasicResources.create::parameters.resource, "");
@@doc(RaiBlocklistPropertiesBasicResources.addBulk::parameters.body,
  "Properties describing the custom blocklist items."
);
@@doc(RaiBlocklistPropertiesBasicResources.deleteBulk::parameters.body,
  "List of RAI Blocklist Items Names."
);
