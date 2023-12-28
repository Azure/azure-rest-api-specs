import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Spring Cloud Gateway resource")
@parentResource(ServiceResource)
model GatewayResource is ProxyResource<GatewayProperties> {
  @doc("The name of Spring Cloud Gateway.")
  @key("gatewayName")
  @segment("gateways")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Gateways {
  @doc("Get the Spring Cloud Gateway and its properties.")
  get is ArmResourceRead<GatewayResource>;
  @doc("Create the default Spring Cloud Gateway or update the existing Spring Cloud Gateway.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GatewayResource>;
  @doc("Disable the default Spring Cloud Gateway.")
  delete is ArmResourceDeleteAsync<GatewayResource>;
  @doc("Handles requests to list all resources in a Service.")
  list is ArmResourceListByParent<GatewayResource>;
  @doc("Check the domains are valid as well as not in use.")
  validateDomain is ArmResourceActionSync<
    GatewayResource,
    CustomDomainValidatePayload,
    CustomDomainValidateResult
  >;
}
