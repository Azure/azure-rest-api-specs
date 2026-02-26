import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
/**
 * A resource that supports private link capabilities.
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
   * Gets a private link resource by a specified group name for a container registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639379.aspx")
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Lists the private link resources for a container registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639379.aspx")
  list is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
    PrivateLinkResource,
    Response = ArmResponse<PrivateLinkResourcesListResult>
  >;
}

@@doc(PrivateLinkResource.name, "The name of the private link resource.");
@@doc(PrivateLinkResource.properties,
  "A resource that supports private link capabilities."
);
