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
/**
 * API portal resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ServiceResource)
@Azure.ResourceManager.Private.armResourceInternal(ApiPortalProperties)
@includeInapplicableMetadataInPayload(false)
model ApiPortalResource extends ProxyResource {
  /**
   * The name of API portal.
   */
  @path
  @key("apiPortalName")
  @segment("apiPortals")
  name: string;

  /**
   * Sku of the API portal resource
   */
  sku?: Sku;

  /**
   * API portal properties payload
   */
  @extension("x-ms-client-flatten", true)
  properties?: ApiPortalProperties;
}

@armResourceOperations
interface ApiPortalResources {
  /**
   * Get the API portal and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApiPortals_Get")
  get is ArmResourceRead<ApiPortalResource>;

  /**
   * Create the default API portal or update the existing API portal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApiPortals_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApiPortalResource>;

  /**
   * Delete the default API portal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApiPortals_Delete")
  delete is ArmResourceDeleteAsync<ApiPortalResource>;

  /**
   * Handles requests to list all resources in a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApiPortals_List")
  list is ArmResourceListByParent<ApiPortalResource>;

  /**
   * Check the domains are valid as well as not in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
