import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiPortalResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
@doc("Custom domain of the API portal")
@parentResource(ApiPortalResource)
model ApiPortalCustomDomainResource
  is ProxyResource<ApiPortalCustomDomainProperties> {
  @doc("The name of the API portal custom domain.")
  @path
  @key("domainName")
  @segment("domains")
  name: string;
}

@armResourceOperations
interface ApiPortalCustomDomainResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the API portal custom domain.")
  @operationId("ApiPortalCustomDomains_Get")
  get is ArmResourceRead<ApiPortalCustomDomainResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the API portal custom domain.")
  @operationId("ApiPortalCustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ApiPortalCustomDomainResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the API portal custom domain.")
  @operationId("ApiPortalCustomDomains_Delete")
  delete is ArmResourceDeleteAsync<ApiPortalCustomDomainResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handle requests to list all API portal custom domains.")
  @operationId("ApiPortalCustomDomains_List")
  list is ArmResourceListByParent<ApiPortalCustomDomainResource>;
}

@@projectedName(ApiPortalCustomDomainResources.createOrUpdate::parameters.resource,
  "json",
  "apiPortalCustomDomainResource"
);
@@extension(ApiPortalCustomDomainResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "apiPortalCustomDomainResource"
);
@@doc(ApiPortalCustomDomainResources.createOrUpdate::parameters.resource,
  "The API portal custom domain for the create or update operation"
);
