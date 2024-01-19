import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
@doc("Spring Cloud Gateway resource")
@parentResource(ServiceResource)
model GatewayResource is ProxyResource<GatewayProperties> {
  @doc("The name of Spring Cloud Gateway.")
  @path
  @key("gatewayName")
  @segment("gateways")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface GatewayResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the Spring Cloud Gateway and its properties.")
  @operationId("Gateways_Get")
  get is ArmResourceRead<GatewayResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create the default Spring Cloud Gateway or update the existing Spring Cloud Gateway.")
  @operationId("Gateways_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GatewayResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Disable the default Spring Cloud Gateway.")
  @operationId("Gateways_Delete")
  delete is ArmResourceDeleteAsync<GatewayResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a Service.")
  @operationId("Gateways_List")
  list is ArmResourceListByParent<GatewayResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Check the domains are valid as well as not in use.")
  @operationId("Gateways_ValidateDomain")
  validateDomain is ArmResourceActionSync<
    GatewayResource,
    CustomDomainValidatePayload,
    CustomDomainValidateResult
  >;
}

@@projectedName(GatewayResources.createOrUpdate::parameters.resource,
  "json",
  "gatewayResource"
);
@@extension(GatewayResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "gatewayResource"
);
@@doc(GatewayResources.createOrUpdate::parameters.resource,
  "The gateway for the create or update operation"
);
@@projectedName(GatewayResources.validateDomain::parameters.body,
  "json",
  "validatePayload"
);
@@extension(GatewayResources.validateDomain::parameters.body,
  "x-ms-client-name",
  "validatePayload"
);
@@doc(GatewayResources.validateDomain::parameters.body,
  "Custom domain payload to be validated"
);
