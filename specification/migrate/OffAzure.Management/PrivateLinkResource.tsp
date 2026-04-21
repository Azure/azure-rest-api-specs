import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MasterSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * REST model used to encapsulate Private Link properties for tracked resources.
 */
@parentResource(MasterSite)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface PrivateLinkResources {
  /**
   * Gets the private link resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PrivateLinkResourcesController")
  @operationId("PrivateLinkResourcesController_Get")
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Gets the private link resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PrivateLinkResourcesController")
  @operationId("PrivateLinkResourcesController_ListByMasterSite")
  listByMasterSite is ArmResourceListByParent<PrivateLinkResource>;
}

@@doc(PrivateLinkResource.name, "Private link resource name.");
@@doc(PrivateLinkResource.properties,
  "The resource-specific properties for this resource."
);
