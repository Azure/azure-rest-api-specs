import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./RaiBlocklistPropertiesBasicResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

/**
 * RaiBlocklistItemPropertiesBasicResource is a preview-only resource.
 */
@removed(Versions.v2025_12_01)
@parentResource(RaiBlocklistPropertiesBasicResource)
model RaiBlocklistItemPropertiesBasicResource
  is Azure.ResourceManager.ProxyResource<RaiBlocklistItemProperties, false> {
  ...ResourceNameParameter<
    Resource = RaiBlocklistItemPropertiesBasicResource,
    KeyName = "raiBlocklistItemName",
    SegmentName = "raiBlocklistItems",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
}

/**
 * RaiBlocklistItemPropertiesBasicResources interface is preview-only.
 */
@removed(Versions.v2025_12_01)
@armResourceOperations
interface RaiBlocklistItemPropertiesBasicResources {
  /**
   * Gets the specified custom blocklist item associated with the Azure OpenAI connection.
   */
  @summary("Gets the specified custom blocklist item associated with the Azure OpenAI connection.")
  get is ArmResourceRead<RaiBlocklistItemPropertiesBasicResource>;

  /**
   * Update the state of specified blocklist item associated with the Azure OpenAI connection.
   */
  @summary("Update the state of specified blocklist item associated with the Azure OpenAI connection.")
  create is ArmResourceCreateOrReplaceAsync<
    RaiBlocklistItemPropertiesBasicResource,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = RaiBlocklistItemPropertiesBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified custom blocklist item associated with the Azure OpenAI connection.
   */
  @summary("Deletes the specified custom blocklist item associated with the Azure OpenAI connection.")
  delete is ArmResourceDeleteWithoutOkAsync<
    RaiBlocklistItemPropertiesBasicResource,
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
   * Gets the custom blocklist items associated with the Azure OpenAI connection.
   */
  @summary("Gets the custom blocklist items associated with the Azure OpenAI connection.")
  list is ArmResourceListByParent<
    RaiBlocklistItemPropertiesBasicResource,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    },
    Response = ArmResponse<RaiBlocklistItemPropertiesBasicResourceArmPaginatedResult>
  >;
}

@@doc(RaiBlocklistItemPropertiesBasicResource.name,
  "Name of the RaiBlocklist Item"
);
@@doc(RaiBlocklistItemPropertiesBasicResource.properties,
  "RAI Custom Blocklist Item properties."
);
@@doc(RaiBlocklistItemPropertiesBasicResources.create::parameters.resource, "");
