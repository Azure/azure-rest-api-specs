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
/**
 * Custom domain of the Spring Cloud Gateway
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(GatewayResource)
@Azure.ResourceManager.Private.armResourceInternal(
  GatewayCustomDomainProperties
)
@includeInapplicableMetadataInPayload(false)
model GatewayCustomDomainResource extends ProxyResource {
  /**
   * The name of the Spring Cloud Gateway custom domain.
   */
  @path
  @key("domainName")
  @segment("domains")
  name: string;

  /**
   * The properties of custom domain for Spring Cloud Gateway
   */
  @extension("x-ms-client-flatten", true)
  properties?: GatewayCustomDomainProperties;
}

@armResourceOperations
interface GatewayCustomDomainResources {
  /**
   * Get the Spring Cloud Gateway custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GatewayCustomDomains_Get")
  get is ArmResourceRead<GatewayCustomDomainResource>;

  /**
   * Create or update the Spring Cloud Gateway custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GatewayCustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<GatewayCustomDomainResource>;

  /**
   * Delete the Spring Cloud Gateway custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GatewayCustomDomains_Delete")
  delete is ArmResourceDeleteAsync<GatewayCustomDomainResource>;

  /**
   * Handle requests to list all Spring Cloud Gateway custom domains.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
