import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * API portal resource
 */
@parentResource(ServiceResource)
model ApiPortalResource
  is Azure.ResourceManager.ProxyResource<ApiPortalProperties> {
  ...ResourceNameParameter<
    Resource = ApiPortalResource,
    KeyName = "apiPortalName",
    SegmentName = "apiPortals",
    NamePattern = ""
  >;

  /**
   * Sku of the API portal resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface ApiPortalResources {
  /**
   * Get the API portal and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiPortals_Get")
  get is ArmResourceRead<ApiPortalResource>;

  /**
   * Create the default API portal or update the existing API portal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiPortals_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApiPortalResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the default API portal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("ApiPortals_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ApiPortalResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiPortals_List")
  list is ArmResourceListByParent<
    ApiPortalResource,
    Response = ArmResponse<ApiPortalResourceCollection>
  >;

  /**
   * Check the domains are valid as well as not in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiPortals_ValidateDomain")
  validateDomain is ArmResourceActionSync<
    ApiPortalResource,
    CustomDomainValidatePayload,
    ArmResponse<CustomDomainValidateResult>
  >;
}

@@doc(ApiPortalResource.name, "The name of API portal.");
@@doc(ApiPortalResource.properties, "API portal properties payload");
@@doc(ApiPortalResources.createOrUpdate::parameters.resource,
  "The API portal for the create or update operation"
);
@@doc(ApiPortalResources.validateDomain::parameters.body,
  "Custom domain payload to be validated"
);
