import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformGateway.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Custom domain of the Spring Cloud Gateway")
@parentResource(AppPlatformGateway)
model AppPlatformGatewayCustomDomain
  is ProxyResource<GatewayCustomDomainProperties> {
  @doc("The name of the Spring Cloud Gateway custom domain.")
  @path
  @key("domainName")
  @segment("domains")
  name: string;
}

@armResourceOperations
interface AppPlatformGatewayCustomDomains {
  @doc("Get the Spring Cloud Gateway custom domain.")
  get is ArmResourceRead<AppPlatformGatewayCustomDomain>;
  @doc("Create or update the Spring Cloud Gateway custom domain.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformGatewayCustomDomain>;
  @doc("Delete the Spring Cloud Gateway custom domain.")
  delete is ArmResourceDeleteAsync<AppPlatformGatewayCustomDomain>;
  @doc("Handle requests to list all Spring Cloud Gateway custom domains.")
  list is ArmResourceListByParent<AppPlatformGatewayCustomDomain>;
}
