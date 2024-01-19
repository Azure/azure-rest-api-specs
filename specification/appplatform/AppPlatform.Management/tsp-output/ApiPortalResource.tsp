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
@doc("API portal resource")
@parentResource(ServiceResource)
model ApiPortalResource is ProxyResource<ApiPortalProperties> {
  @doc("The name of API portal.")
  @path
  @key("apiPortalName")
  @segment("apiPortals")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ApiPortalResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the API portal and its properties.")
  @operationId("ApiPortals_Get")
  get is ArmResourceRead<ApiPortalResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create the default API portal or update the existing API portal.")
  @operationId("ApiPortals_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ApiPortalResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the default API portal.")
  @operationId("ApiPortals_Delete")
  delete is ArmResourceDeleteAsync<ApiPortalResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a Service.")
  @operationId("ApiPortals_List")
  list is ArmResourceListByParent<ApiPortalResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Check the domains are valid as well as not in use.")
  @operationId("ApiPortals_ValidateDomain")
  validateDomain is ArmResourceActionSync<
    ApiPortalResource,
    CustomDomainValidatePayload,
    CustomDomainValidateResult
  >;
}

@@projectedName(ApiPortalResources.createOrUpdate::parameters.resource,
  "json",
  "apiPortalResource"
);
@@extension(ApiPortalResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "apiPortalResource"
);
@@doc(ApiPortalResources.createOrUpdate::parameters.resource,
  "The API portal for the create or update operation"
);
@@projectedName(ApiPortalResources.validateDomain::parameters.body,
  "json",
  "validatePayload"
);
@@extension(ApiPortalResources.validateDomain::parameters.body,
  "x-ms-client-name",
  "validatePayload"
);
@@doc(ApiPortalResources.validateDomain::parameters.body,
  "Custom domain payload to be validated"
);
