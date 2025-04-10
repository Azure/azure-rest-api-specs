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
 * Spring Cloud Gateway resource
 */
@parentResource(ServiceResource)
model GatewayResource
  is Azure.ResourceManager.ProxyResource<GatewayProperties> {
  ...ResourceNameParameter<
    Resource = GatewayResource,
    KeyName = "gatewayName",
    SegmentName = "gateways",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;

  /**
   * Sku of the Spring Cloud Gateway resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface GatewayResources {
  /**
   * Get the Spring Cloud Gateway and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Gateways_Get")
  get is ArmResourceRead<GatewayResource>;

  /**
   * Create the default Spring Cloud Gateway or update the existing Spring Cloud Gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Gateways_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GatewayResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to update an exiting Spring Cloud Gateway capacity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Gateways_UpdateCapacity")
  updateCapacity is ArmCustomPatchAsync<
    GatewayResource,
    PatchModel = SkuObject
  >;

  /**
   * Disable the default Spring Cloud Gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Gateways_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    GatewayResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Gateways_List")
  list is ArmResourceListByParent<
    GatewayResource,
    Response = ArmResponse<GatewayResourceCollection>
  >;

  /**
   * List sensitive environment variables of Spring Cloud Gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Gateways_ListEnvSecrets")
  listEnvSecrets is ArmResourceActionSync<
    GatewayResource,
    void,
    ArmResponse<GatewayEnvSecrets>
  >;

  /**
   * Restart the Spring Cloud Gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Gateways_Restart")
  restart is ArmResourceActionAsync<GatewayResource, void, OkResponse>;

  /**
   * Check the domains are valid as well as not in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Gateways_ValidateDomain")
  validateDomain is ArmResourceActionSync<
    GatewayResource,
    CustomDomainValidatePayload,
    ArmResponse<CustomDomainValidateResult>
  >;
}

@@doc(GatewayResource.name, "The name of Spring Cloud Gateway.");
@@doc(GatewayResource.properties, "Spring Cloud Gateway properties payload");
@@doc(GatewayResources.createOrUpdate::parameters.resource,
  "The gateway for the create or update operation"
);
@@doc(GatewayResources.updateCapacity::parameters.properties,
  "The gateway capacity for the update operation"
);
@@doc(GatewayResources.validateDomain::parameters.body,
  "Custom domain payload to be validated"
);
