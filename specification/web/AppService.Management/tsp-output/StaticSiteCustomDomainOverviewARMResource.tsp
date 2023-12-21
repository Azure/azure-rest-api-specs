import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StaticSiteARMResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
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
interface StaticSites {
  @doc("Description for Gets an existing custom domain for a particular static site.")
  getStaticSiteCustomDomain is ArmResourceRead<StaticSiteCustomDomainOverviewARMResource>;
  @doc("Description for Creates a new static site custom domain in an existing resource group and static site.")
  createOrUpdateStaticSiteCustomDomain is ArmResourceCreateOrUpdateAsync<StaticSiteCustomDomainOverviewARMResource>;
  @doc("Description for Deletes a custom domain.")
  deleteStaticSiteCustomDomain is ArmResourceDeleteAsync<StaticSiteCustomDomainOverviewARMResource>;
  @doc("Description for Gets all static site custom domains for a particular static site.")
  listStaticSiteCustomDomains is ArmResourceListByParent<StaticSiteCustomDomainOverviewARMResource>;
  @doc("Description for Validates a particular custom domain can be added to a static site.")
  validateCustomDomainCanBeAddedToStaticSite is ArmResourceActionAsync<
    StaticSiteCustomDomainOverviewARMResource,
    StaticSiteCustomDomainRequestPropertiesARMResource,
    void
  >;
}
