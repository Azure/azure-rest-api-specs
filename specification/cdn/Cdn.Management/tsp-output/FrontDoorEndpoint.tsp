import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Cdn;
@doc("CDN endpoint is the entity within a CDN profile containing configuration information such as origin, protocol, content caching and delivery behavior. The AzureFrontDoor endpoint uses the URL format <endpointname>.azureedge.net.")
@parentResource(Profile)
model FrontDoorEndpoint is TrackedResource<AFDEndpointProperties> {
  @doc("Name of the endpoint under the profile which is unique globally.")
  @path
  @key("endpointName")
  @segment("afdEndpoints")
  name: string;
}

@armResourceOperations
interface FrontDoorEndpoints {
  @doc("Gets an existing AzureFrontDoor endpoint with the specified endpoint name under the specified subscription, resource group and profile.")
  get is ArmResourceRead<FrontDoorEndpoint>;
  @doc("Creates a new AzureFrontDoor endpoint with the specified endpoint name under the specified subscription, resource group and profile.")
  create is ArmResourceCreateOrUpdateAsync<FrontDoorEndpoint>;
  @doc("Updates an existing AzureFrontDoor endpoint with the specified endpoint name under the specified subscription, resource group and profile. Only tags can be updated after creating an endpoint. To update origins, use the Update Origin operation. To update origin groups, use the Update Origin group operation. To update domains, use the Update Custom Domain operation.")
  update is ArmResourcePatchAsync<FrontDoorEndpoint, AFDEndpointProperties>;
  @doc("Deletes an existing AzureFrontDoor endpoint with the specified endpoint name under the specified subscription, resource group and profile.")
  delete is ArmResourceDeleteAsync<FrontDoorEndpoint>;
  @doc("Lists existing AzureFrontDoor endpoints.")
  listByProfile is ArmResourceListByParent<FrontDoorEndpoint>;
  @doc("Removes a content from AzureFrontDoor.")
  purgeContent is ArmResourceActionAsync<
    FrontDoorEndpoint,
    FrontDoorPurgeParameters,
    void
  >;
  @doc("Checks the quota and actual usage of the given AzureFrontDoor endpoint under the given CDN profile.")
  listResourceUsage is ArmResourceActionSync<
    FrontDoorEndpoint,
    void,
    UsagesListResult
  >;
  @doc("Validates the custom domain mapping to ensure it maps to the correct CDN endpoint in DNS.This api isn't work for apex domain.")
  validateCustomDomain is ArmResourceActionSync<
    FrontDoorEndpoint,
    ValidateCustomDomainContent,
    ValidateCustomDomainResult
  >;
}
