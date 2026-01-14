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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(StaticSiteARMResource)
model StaticSiteCustomDomainOverviewARMResource
  is Azure.ResourceManager.ProxyResource<StaticSiteCustomDomainOverviewARMResourceProperties> {
  ...ResourceNameParameter<
    Resource = StaticSiteCustomDomainOverviewARMResource,
    KeyName = "domainName",
    SegmentName = "customDomains",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface StaticSiteCustomDomainOverviewARMResources {
  /**
   * Description for Gets an existing custom domain for a particular static site.
   */
  @summary("Gets an existing custom domain for a particular static site.")
  getStaticSiteCustomDomain is ArmResourceRead<
    StaticSiteCustomDomainOverviewARMResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new static site custom domain in an existing resource group and static site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a new static site custom domain in an existing resource group and static site.")
  createOrUpdateStaticSiteCustomDomain is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    StaticSiteCustomDomainOverviewARMResource,
    StaticSiteCustomDomainRequestPropertiesARMResource,
    Response = ArmResourceUpdatedResponse<StaticSiteCustomDomainOverviewARMResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = StaticSiteCustomDomainOverviewARMResource>> & {
      @bodyRoot
      _: StaticSiteCustomDomainOverviewARMResource;
    }),
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a custom domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a custom domain.")
  deleteStaticSiteCustomDomain is ArmResourceDeleteWithoutOkAsync<
    StaticSiteCustomDomainOverviewARMResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Gets all static site custom domains for a particular static site.
   */
  @summary("Gets all static site custom domains for a particular static site.")
  listStaticSiteCustomDomains is ArmResourceListByParent<
    StaticSiteCustomDomainOverviewARMResource,
    Response = ArmResponse<StaticSiteCustomDomainOverviewCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Validates a particular custom domain can be added to a static site.
   */
  @summary("Validates a particular custom domain can be added to a static site.")
  @action("validate")
  validateCustomDomainCanBeAddedToStaticSite is ArmResourceActionAsync<
    StaticSiteCustomDomainOverviewARMResource,
    StaticSiteCustomDomainRequestPropertiesARMResource,
    {
      @body body: void;
    },
    Error = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
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
