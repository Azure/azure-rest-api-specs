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
/**
 * Custom domain of the API portal
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ApiPortalResource)
@Azure.ResourceManager.Private.armResourceInternal(
  ApiPortalCustomDomainProperties
)
@includeInapplicableMetadataInPayload(false)
model ApiPortalCustomDomainResource extends ProxyResource {
  /**
   * The name of the API portal custom domain.
   */
  @path
  @key("domainName")
  @segment("domains")
  name: string;

  /**
   * The properties of custom domain for API portal
   */
  @extension("x-ms-client-flatten", true)
  properties?: ApiPortalCustomDomainProperties;
}

@armResourceOperations
interface ApiPortalCustomDomainResources {
  /**
   * Get the API portal custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApiPortalCustomDomains_Get")
  get is ArmResourceRead<ApiPortalCustomDomainResource>;

  /**
   * Create or update the API portal custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApiPortalCustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApiPortalCustomDomainResource>;

  /**
   * Delete the API portal custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApiPortalCustomDomains_Delete")
  delete is ArmResourceDeleteAsync<ApiPortalCustomDomainResource>;

  /**
   * Handle requests to list all API portal custom domains.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
