import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
/**
 * Information of the private link resource.
 */
@parentResource(RelayNamespace)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets a description for the specified Private Endpoint Connection name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from legacy"
  @OpenAPI.externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639379.aspx")
  get is ArmResourceRead<PrivateLinkResource>;

    /**
   * Gets lists of resources that supports Privatelinks.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Migration from legacy"
  @OpenAPI.externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639379.aspx")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Relay/namespaces/{namespaceName}/privateLinkResources")
  @get
  op list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...KeysOf<RelayNamespaceNameParameter>): ArmResponse<PrivateLinkResourcesListResult> | ErrorResponse;
}

@@doc(PrivateLinkResource.name, "The PrivateLinkResource name");
@@doc(PrivateLinkResource.properties,
  "Properties of the private link resource."
);
