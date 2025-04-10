import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiPortalResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Custom domain of the API portal
 */
@parentResource(ApiPortalResource)
model ApiPortalCustomDomainResource
  is Azure.ResourceManager.ProxyResource<ApiPortalCustomDomainProperties> {
  ...ResourceNameParameter<
    Resource = ApiPortalCustomDomainResource,
    KeyName = "domainName",
    SegmentName = "domains",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ApiPortalCustomDomainResources {
  /**
   * Get the API portal custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiPortalCustomDomains_Get")
  get is ArmResourceRead<ApiPortalCustomDomainResource>;

  /**
   * Create or update the API portal custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiPortalCustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApiPortalCustomDomainResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the API portal custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("ApiPortalCustomDomains_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ApiPortalCustomDomainResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handle requests to list all API portal custom domains.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiPortalCustomDomains_List")
  list is ArmResourceListByParent<
    ApiPortalCustomDomainResource,
    Response = ArmResponse<ApiPortalCustomDomainResourceCollection>
  >;
}

@@doc(ApiPortalCustomDomainResource.name,
  "The name of the API portal custom domain."
);
@@doc(ApiPortalCustomDomainResource.properties,
  "The properties of custom domain for API portal"
);
@@doc(ApiPortalCustomDomainResources.createOrUpdate::parameters.resource,
  "The API portal custom domain for the create or update operation"
);
