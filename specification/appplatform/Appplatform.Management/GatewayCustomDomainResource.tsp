import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GatewayResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Custom domain of the Spring Cloud Gateway
 */
@parentResource(GatewayResource)
model GatewayCustomDomainResource
  is Azure.ResourceManager.ProxyResource<GatewayCustomDomainProperties> {
  ...ResourceNameParameter<
    Resource = GatewayCustomDomainResource,
    KeyName = "domainName",
    SegmentName = "domains",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GatewayCustomDomainResources {
  /**
   * Get the Spring Cloud Gateway custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GatewayCustomDomains_Get")
  get is ArmResourceRead<GatewayCustomDomainResource>;

  /**
   * Create or update the Spring Cloud Gateway custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GatewayCustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GatewayCustomDomainResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the Spring Cloud Gateway custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("GatewayCustomDomains_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    GatewayCustomDomainResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handle requests to list all Spring Cloud Gateway custom domains.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GatewayCustomDomains_List")
  list is ArmResourceListByParent<
    GatewayCustomDomainResource,
    Response = ArmResponse<GatewayCustomDomainResourceCollection>
  >;
}

@@doc(GatewayCustomDomainResource.name,
  "The name of the Spring Cloud Gateway custom domain."
);
@@doc(GatewayCustomDomainResource.properties,
  "The properties of custom domain for Spring Cloud Gateway"
);
@@doc(GatewayCustomDomainResources.createOrUpdate::parameters.resource,
  "The gateway custom domain resource for the create or update operation"
);
