import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StaticSiteARMResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Static site basic auth properties ARM resource.
 */
@parentResource(StaticSiteARMResource)
model StaticSiteBasicAuthPropertiesARMResource
  is Azure.ResourceManager.ProxyResource<StaticSiteBasicAuthPropertiesARMResourceProperties> {
  ...ResourceNameParameter<
    Resource = StaticSiteBasicAuthPropertiesARMResource,
    KeyName = "basicAuthName",
    SegmentName = "basicAuth",
    NamePattern = "default",
    Type = BasicAuthName
  >;
}

@armResourceOperations
interface StaticSiteBasicAuthPropertiesARMResources {
  /**
   * Description for Gets the basic auth properties for a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetBasicAuth")
  getBasicAuth is ArmResourceRead<StaticSiteBasicAuthPropertiesARMResource>;

  /**
   * Description for Adds or updates basic auth for a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("StaticSites_CreateOrUpdateBasicAuth")
  createOrUpdateBasicAuth is ArmResourceCreateOrReplaceSync<
    StaticSiteBasicAuthPropertiesARMResource,
    Response = ArmResourceUpdatedResponse<StaticSiteBasicAuthPropertiesARMResource>
  >;

  /**
   * Description for Gets the basic auth properties for a static site as a collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ListBasicAuth")
  listBasicAuth is ArmResourceListByParent<
    StaticSiteBasicAuthPropertiesARMResource,
    Response = ArmResponse<StaticSiteBasicAuthPropertiesCollection>
  >;
}

@@doc(StaticSiteBasicAuthPropertiesARMResource.name,
  "name of the basic auth entry."
);
@@doc(StaticSiteBasicAuthPropertiesARMResource.properties,
  "StaticSiteBasicAuthPropertiesARMResource resource specific properties"
);
@@doc(StaticSiteBasicAuthPropertiesARMResources.createOrUpdateBasicAuth::parameters.resource,
  "A JSON representation of the basic auth properties."
);
