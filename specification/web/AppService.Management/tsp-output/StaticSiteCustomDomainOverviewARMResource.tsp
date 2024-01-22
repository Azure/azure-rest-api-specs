import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StaticSiteARMResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Static Site Custom Domain Overview ARM resource.
 */
@parentResource(StaticSiteARMResource)
model StaticSiteCustomDomainOverviewARMResource
  is ProxyResource<StaticSiteCustomDomainOverviewARMResourceProperties> {
  /**
   * The custom domain name.
   */
  @path
  @key("domainName")
  @segment("customDomains")
  name: string;
}

@armResourceOperations
interface StaticSiteCustomDomainOverviewARMResources {
  /**
   * Description for Gets an existing custom domain for a particular static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_GetStaticSiteCustomDomain")
  getStaticSiteCustomDomain is ArmResourceRead<StaticSiteCustomDomainOverviewARMResource>;

  /**
   * Description for Creates a new static site custom domain in an existing resource group and static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_CreateOrUpdateStaticSiteCustomDomain")
  createOrUpdateStaticSiteCustomDomain is ArmResourceCreateOrReplaceAsync<StaticSiteCustomDomainOverviewARMResource>;

  /**
   * Description for Deletes a custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_DeleteStaticSiteCustomDomain")
  deleteStaticSiteCustomDomain is ArmResourceDeleteAsync<StaticSiteCustomDomainOverviewARMResource>;

  /**
   * Description for Gets all static site custom domains for a particular static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_ListStaticSiteCustomDomains")
  listStaticSiteCustomDomains is ArmResourceListByParent<StaticSiteCustomDomainOverviewARMResource>;

  /**
   * Description for Validates a particular custom domain can be added to a static site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StaticSites_ValidateCustomDomainCanBeAddedToStaticSite")
  validateCustomDomainCanBeAddedToStaticSite is ArmResourceActionAsync<
    StaticSiteCustomDomainOverviewARMResource,
    StaticSiteCustomDomainRequestPropertiesARMResource,
    void
  >;
}

@@projectedName(StaticSiteCustomDomainOverviewARMResources.createOrUpdateStaticSiteCustomDomain::parameters.resource,
  "json",
  "staticSiteCustomDomainRequestPropertiesEnvelope"
);
@@extension(StaticSiteCustomDomainOverviewARMResources.createOrUpdateStaticSiteCustomDomain::parameters.resource,
  "x-ms-client-name",
  "staticSiteCustomDomainRequestPropertiesEnvelope"
);
@@doc(StaticSiteCustomDomainOverviewARMResources.createOrUpdateStaticSiteCustomDomain::parameters.resource,
  "A JSON representation of the static site custom domain request properties. See example."
);
@@projectedName(StaticSiteCustomDomainOverviewARMResources.validateCustomDomainCanBeAddedToStaticSite::parameters.body,
  "json",
  "staticSiteCustomDomainRequestPropertiesEnvelope"
);
@@extension(StaticSiteCustomDomainOverviewARMResources.validateCustomDomainCanBeAddedToStaticSite::parameters.body,
  "x-ms-client-name",
  "staticSiteCustomDomainRequestPropertiesEnvelope"
);
@@doc(StaticSiteCustomDomainOverviewARMResources.validateCustomDomainCanBeAddedToStaticSite::parameters.body,
  "A JSON representation of the static site custom domain request properties. See example."
);
