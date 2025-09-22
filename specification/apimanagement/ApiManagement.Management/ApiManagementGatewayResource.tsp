import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * A single API Management gateway resource in List or Get response.
 */
model ApiManagementGatewayResource
  is Azure.ResourceManager.TrackedResource<
    ApiManagementGatewayProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ApiManagementGatewayResource,
    KeyName = "gatewayName",
    SegmentName = "gateways",
    NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
  >;

  /**
   * SKU properties of the API Management gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: ApiManagementGatewaySkuProperties;

  ...Azure.ResourceManager.EntityTagProperty;
}

@armResourceOperations
interface ApiManagementGatewayResources {
  /**
   * Gets an API Management gateway resource description.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiGateway_Get")
  get is ArmResourceRead<ApiManagementGatewayResource>;

  /**
   * Creates or updates an API Management gateway. This is long running operation and could take several minutes to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiGateway_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApiManagementGatewayResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = ApiManagementGatewayResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates an existing API Management gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiGateway_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ApiManagementGatewayResource,
    PatchModel = ApiManagementGatewayUpdateParameters
  >;

  /**
   * Deletes an existing API Management gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("ApiGateway_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ApiManagementGatewayResource,
    Response = (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: ApiManagementGatewayResource;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List all API Management gateways within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiGateway_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ApiManagementGatewayResource>;

  /**
   * List all API Management gateways within a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiGateway_List")
  list is ArmListBySubscription<ApiManagementGatewayResource>;

  /**
   * Gets all available SKU for a given API Management gateway
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiManagementGatewaySkus_ListAvailableSkus")
  @get
  @action("skus")
  listAvailableSkus is ArmResourceActionSync<
    ApiManagementGatewayResource,
    void,
    ArmResponse<GatewayResourceSkuResults>
  >;
}

@@maxLength(ApiManagementGatewayResource.name, 45);
@@minLength(ApiManagementGatewayResource.name, 1);
@@doc(ApiManagementGatewayResource.name,
  "The name of the API Management gateway."
);
@@encodedName(ApiManagementGatewayResource.eTag, "application/json", "etag");
@@doc(ApiManagementGatewayResource.properties,
  "Properties of the API Management gateway."
);
@@doc(ApiManagementGatewayResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate API Management gateway operation."
);
@@doc(ApiManagementGatewayResources.update::parameters.properties,
  "Parameters supplied to the CreateOrUpdate API Management gateway operation."
);
