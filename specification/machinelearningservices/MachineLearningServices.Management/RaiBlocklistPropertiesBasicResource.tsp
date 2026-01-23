import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkspaceConnectionPropertiesV2BasicResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

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
      ...ProxyApiVersion;
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
      ...ProxyApiVersion;
    }
  >;

  /**
   * Gets the custom blocklists associated with the Azure OpenAI connection.
   */
  @summary("Gets the custom blocklists associated with the Azure OpenAI connection.")
  list is ArmResourceListByParent<
    RaiBlocklistPropertiesBasicResource,
    Parameters = {
      ...ProxyApiVersion;
    },
    Response = ArmResponse<RaiBlocklistPropertiesBasicResourceArmPaginatedResult>
  >;

  /**
   * Add multiple blocklist items to the specified blocklist associated with the Azure OpenAI connection.
   */
  @summary("Add multiple blocklist items to the specified blocklist associated with the Azure OpenAI connection.")
  @action("addRaiBlocklistItems")
  addBulk is ArmResourceActionAsync<
    RaiBlocklistPropertiesBasicResource,
    RaiBlocklistItemsBulkAddRequest,
    {
      @body
      @identifiers(#[])
      _?: RaiBlocklistItemPropertiesBasicResource[];
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = RaiBlocklistItemPropertiesBasicResource[]>
  >;

  /**
   * Delete multiple blocklist items from the specified blocklist associated with the Azure OpenAI connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
