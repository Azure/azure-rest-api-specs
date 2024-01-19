import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GatewayResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
@doc("Custom domain of the Spring Cloud Gateway")
@parentResource(GatewayResource)
model GatewayCustomDomainResource
  is ProxyResource<GatewayCustomDomainProperties> {
  @doc("The name of the Spring Cloud Gateway custom domain.")
  @path
  @key("domainName")
  @segment("domains")
  name: string;
}

@armResourceOperations
interface GatewayCustomDomainResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the Spring Cloud Gateway custom domain.")
  @operationId("GatewayCustomDomains_Get")
  get is ArmResourceRead<GatewayCustomDomainResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the Spring Cloud Gateway custom domain.")
  @operationId("GatewayCustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GatewayCustomDomainResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the Spring Cloud Gateway custom domain.")
  @operationId("GatewayCustomDomains_Delete")
  delete is ArmResourceDeleteAsync<GatewayCustomDomainResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handle requests to list all Spring Cloud Gateway custom domains.")
  @operationId("GatewayCustomDomains_List")
  list is ArmResourceListByParent<GatewayCustomDomainResource>;
}

@@projectedName(GatewayCustomDomainResources.createOrUpdate::parameters.resource,
  "json",
  "gatewayCustomDomainResource"
);
@@extension(GatewayCustomDomainResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "gatewayCustomDomainResource"
);
@@doc(GatewayCustomDomainResources.createOrUpdate::parameters.resource,
  "The gateway custom domain resource for the create or update operation"
);
