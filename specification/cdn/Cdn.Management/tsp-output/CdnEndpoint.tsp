import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Cdn;
@doc("CDN endpoint is the entity within a CDN profile containing configuration information such as origin, protocol, content caching and delivery behavior. The CDN endpoint uses the URL format <endpointname>.azureedge.net.")
@parentResource(Profile)
model CdnEndpoint is TrackedResource<EndpointProperties> {
  @doc("Name of the endpoint under the profile which is unique globally.")
  @key("endpointName")
  @segment("endpoints")
  name: string;
}

@armResourceOperations
interface CdnEndpoints {
  @doc("Gets an existing CDN endpoint with the specified endpoint name under the specified subscription, resource group and profile.")
  get is ArmResourceRead<CdnEndpoint>;

  @doc("Creates a new CDN endpoint with the specified endpoint name under the specified subscription, resource group and profile.")
  create is ArmResourceCreateOrUpdateAsync<CdnEndpoint>;

  @doc("Updates an existing CDN endpoint with the specified endpoint name under the specified subscription, resource group and profile. Only tags can be updated after creating an endpoint. To update origins, use the Update Origin operation. To update origin groups, use the Update Origin group operation. To update custom domains, use the Update Custom Domain operation.")
  update is ArmCustomPatchAsync<CdnEndpoint, EndpointUpdateParameters>;

  @doc("Deletes an existing CDN endpoint with the specified endpoint name under the specified subscription, resource group and profile.")
  delete is ArmResourceDeleteAsync<CdnEndpoint>;

  @doc("Lists existing CDN endpoints.")
  listByProfile is ArmResourceListByParent<CdnEndpoint>;

  @doc("Starts an existing CDN endpoint that is on a stopped state.")
  start is ArmResourceActionAsync<CdnEndpoint, void, CdnEndpoint>;

  @doc("Stops an existing running CDN endpoint.")
  stop is ArmResourceActionAsync<CdnEndpoint, void, CdnEndpoint>;

  @doc("Removes a content from CDN.")
  purgeContent is ArmResourceActionAsync<CdnEndpoint, PurgeParameters, void>;

  @doc("Pre-loads a content to CDN. Available for Verizon Profiles.")
  loadContent is ArmResourceActionAsync<CdnEndpoint, LoadParameters, void>;

  @doc("Validates the custom domain mapping to ensure it maps to the correct CDN endpoint in DNS.")
  validateCustomDomain is ArmResourceActionSync<
    CdnEndpoint,
    ValidateCustomDomainContent,
    ValidateCustomDomainResult
  >;

  @doc("Checks the quota and usage of geo filters and custom domains under the given endpoint.")
  listResourceUsage is ArmResourceActionSync<
    CdnEndpoint,
    void,
    ResourceUsageListResult
  >;
}
