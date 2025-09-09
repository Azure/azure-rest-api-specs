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
 * Static Site Custom Domain Overview ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@parentResource(StaticSiteARMResource)
model StaticSiteCustomDomainOverviewARMResource
  is Azure.ResourceManager.ProxyResource<StaticSiteCustomDomainOverviewARMResourceProperties> {
  ...ResourceNameParameter<
    Resource = StaticSiteCustomDomainOverviewARMResource,
    KeyName = "domainName",
    SegmentName = "customDomains",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armResourceOperations
interface StaticSiteCustomDomainOverviewARMResources {
  /**
   * Description for Gets an existing custom domain for a particular static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_GetStaticSiteCustomDomain")
  getStaticSiteCustomDomain is ArmResourceRead<
    StaticSiteCustomDomainOverviewARMResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new static site custom domain in an existing resource group and static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("StaticSites_CreateOrUpdateStaticSiteCustomDomain")
  createOrUpdateStaticSiteCustomDomain is ArmResourceCreateOrReplaceAsync<
    StaticSiteCustomDomainOverviewARMResource,
    Response = ArmResourceUpdatedResponse<StaticSiteCustomDomainOverviewARMResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: StaticSiteCustomDomainOverviewARMResource;
    }),
    LroHeaders = ArmLroLocationHeader<FinalResult = StaticSiteCustomDomainOverviewARMResource> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("StaticSites_DeleteStaticSiteCustomDomain")
  deleteStaticSiteCustomDomain is ArmResourceDeleteWithoutOkAsync<
    StaticSiteCustomDomainOverviewARMResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets all static site custom domains for a particular static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ListStaticSiteCustomDomains")
  listStaticSiteCustomDomains is ArmResourceListByParent<
    StaticSiteCustomDomainOverviewARMResource,
    Response = ArmResponse<StaticSiteCustomDomainOverviewCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Validates a particular custom domain can be added to a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StaticSites_ValidateCustomDomainCanBeAddedToStaticSite")
  @action("validate")
  validateCustomDomainCanBeAddedToStaticSite is ArmResourceActionAsync<
    StaticSiteCustomDomainOverviewARMResource,
    StaticSiteCustomDomainRequestPropertiesARMResource,
    OkResponse,
    Error = DefaultErrorResponse
  >;
}

@@doc(StaticSiteCustomDomainOverviewARMResource.name,
  "The custom domain name."
);
@@doc(StaticSiteCustomDomainOverviewARMResource.properties,
  "StaticSiteCustomDomainOverviewARMResource resource specific properties"
);
@@doc(StaticSiteCustomDomainOverviewARMResources.createOrUpdateStaticSiteCustomDomain::parameters.resource,
  "A JSON representation of the static site custom domain request properties. See example."
);
@@doc(StaticSiteCustomDomainOverviewARMResources.validateCustomDomainCanBeAddedToStaticSite::parameters.body,
  "A JSON representation of the static site custom domain request properties. See example."
);
