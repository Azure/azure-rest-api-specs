import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./CdnEndpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Cdn;
@doc("Friendly domain name mapping to the endpoint hostname that the customer provides for branding purposes, e.g. www.contoso.com.")
@parentResource(CdnEndpoint)
model CdnCustomDomain is ProxyResource<CustomDomainProperties> {
  @doc("Name of the custom domain within an endpoint.")
  @key("customDomainName")
  @segment("customDomains")
  name: string;
}

@armResourceOperations
interface CdnCustomDomains {
  @doc("Gets an existing custom domain within an endpoint.")
  get is ArmResourceRead<CdnCustomDomain>;

  @doc("Creates a new custom domain within an endpoint.")
  create is ArmResourceCreateOrUpdateAsync<CdnCustomDomain>;

  @doc("Deletes an existing custom domain within an endpoint.")
  delete is ArmResourceDeleteAsync<CdnCustomDomain>;

  @doc("Lists all of the existing custom domains within an endpoint.")
  listByEndpoint is ArmResourceListByParent<CdnCustomDomain>;

  @doc("Disable https delivery of the custom domain.")
  disableCustomHttps is ArmResourceActionAsync<
    CdnCustomDomain,
    void,
    CdnCustomDomain
  >;

  @doc("Enable https delivery of the custom domain.")
  enableCustomHttps is ArmResourceActionAsync<
    CdnCustomDomain,
    CustomDomainHttpsParameters,
    CdnCustomDomain
  >;
}
