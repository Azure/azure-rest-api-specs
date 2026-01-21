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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(StaticSiteARMResource)
model StaticSiteBasicAuthPropertiesARMResource
  is Azure.ResourceManager.ProxyResource<StaticSiteBasicAuthPropertiesARMResourceProperties> {
  ...ResourceNameParameter<
    Resource = StaticSiteBasicAuthPropertiesARMResource,
    KeyName = "basicAuthName",
    SegmentName = "basicAuth",
    NamePattern = "",
    Type = BasicAuthName
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface StaticSiteBasicAuthPropertiesARMResources {
  /**
   * Description for Gets the basic auth properties for a static site.
   */
  @summary("Gets the basic auth properties for a static site.")
  getBasicAuth is ArmResourceRead<
    StaticSiteBasicAuthPropertiesARMResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Adds or updates basic auth for a static site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Adds or updates basic auth for a static site.")
  createOrUpdateBasicAuth is ArmResourceCreateOrReplaceSync<
    StaticSiteBasicAuthPropertiesARMResource,
    Response = ArmResourceUpdatedResponse<StaticSiteBasicAuthPropertiesARMResource>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets the basic auth properties for a static site as a collection.
   */
  @summary("Gets the basic auth properties for a static site as a collection.")
  listBasicAuth is ArmResourceListByParent<
    StaticSiteBasicAuthPropertiesARMResource,
    Response = ArmResponse<StaticSiteBasicAuthPropertiesCollection>,
    Error = DefaultErrorResponse
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
