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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionRaiBlocklist_Get")
  get is ArmResourceRead<RaiBlocklistPropertiesBasicResource>;

  /**
   * Update the state of specified blocklist associated with the Azure OpenAI connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionRaiBlocklist_Create")
  create is ArmResourceCreateOrReplaceAsync<
    RaiBlocklistPropertiesBasicResource,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = RaiBlocklistPropertiesBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified custom blocklist associated with the Azure OpenAI connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionRaiBlocklist_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    RaiBlocklistPropertiesBasicResource,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    }
  >;

  /**
   * Gets the custom blocklists associated with the Azure OpenAI connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionRaiBlocklists_List")
  list is ArmResourceListByParent<
    RaiBlocklistPropertiesBasicResource,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    },
    Response = ArmResponse<RaiBlocklistPropertiesBasicResourceArmPaginatedResult>
  >;

  /**
   * Add multiple blocklist items to the specified blocklist associated with the Azure OpenAI connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionRaiBlocklistItem_AddBulk")
  @list
  @action("addRaiBlocklistItems")
  addBulk is ArmResourceActionAsync<
    RaiBlocklistPropertiesBasicResource,
    RaiBlocklistItemBulkRequest[],
    ArmResponse<RaiBlocklistItemPropertiesBasicResource[]>
  >;

  /**
   * Delete multiple blocklist items from the specified blocklist associated with the Azure OpenAI connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionRaiBlocklistItem_DeleteBulk")
  @action("deleteRaiBlocklistItems")
  deleteBulk is ArmResourceActionAsync<
    RaiBlocklistPropertiesBasicResource,
    unknown,
    NoContentResponse
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
