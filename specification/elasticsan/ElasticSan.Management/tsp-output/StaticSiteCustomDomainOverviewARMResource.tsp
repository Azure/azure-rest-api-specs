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
@doc("Static Site Custom Domain Overview ARM resource.")
@parentResource(StaticSiteARMResource)
model StaticSiteCustomDomainOverviewARMResource
  is ProxyResource<StaticSiteCustomDomainOverviewARMResourceProperties> {
  @doc("The custom domain name.")
  @path
  @key("domainName")
  @segment("customDomains")
  name: string;
}

@armResourceOperations
interface StaticSiteCustomDomainOverviewARMResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets an existing custom domain for a particular static site.")
  @operationId("StaticSites_GetStaticSiteCustomDomain")
  getStaticSiteCustomDomain is ArmResourceRead<StaticSiteCustomDomainOverviewARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates a new static site custom domain in an existing resource group and static site.")
  @operationId("StaticSites_CreateOrUpdateStaticSiteCustomDomain")
  createOrUpdateStaticSiteCustomDomain is ArmResourceCreateOrUpdateAsync<StaticSiteCustomDomainOverviewARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Deletes a custom domain.")
  @operationId("StaticSites_DeleteStaticSiteCustomDomain")
  deleteStaticSiteCustomDomain is ArmResourceDeleteAsync<StaticSiteCustomDomainOverviewARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets all static site custom domains for a particular static site.")
  @operationId("StaticSites_ListStaticSiteCustomDomains")
  listStaticSiteCustomDomains is ArmResourceListByParent<StaticSiteCustomDomainOverviewARMResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Validates a particular custom domain can be added to a static site.")
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
