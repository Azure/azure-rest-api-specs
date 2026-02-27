import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RaiBlocklistPropertiesBasicResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

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
      ...ProxyApiVersion;
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
      ...ProxyApiVersion;
    }
  >;

  /**
   * Gets the custom blocklist items associated with the Azure OpenAI connection.
   */
  @summary("Gets the custom blocklist items associated with the Azure OpenAI connection.")
  list is ArmResourceListByParent<
    RaiBlocklistItemPropertiesBasicResource,
    Parameters = {
      ...ProxyApiVersion;
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
