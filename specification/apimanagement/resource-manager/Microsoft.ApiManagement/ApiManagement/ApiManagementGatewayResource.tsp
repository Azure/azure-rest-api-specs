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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: ApiManagementGatewaySkuProperties;

  /**
   * ETag of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: Azure.Core.eTag;
}

alias ApiManagementGatewayListPagingParameters = {
  /**
   * Number of records to return.
   */
  @query("$top")
  @minValue(1)
  $top?: int32;

  /**
   * Skip token for retrieving the next page of results.
   */
  @query("$skipToken")
  $skipToken?: string;
};

// ResourceName = "ApiManagementGateway" makes the C# emitter produce
// ApiManagementGatewayResource.cs / Collection.cs / ApiManagementGatewayData.cs
// (matching the GA contract) under modern arm-resource detection.
@armResourceOperations
interface ApiManagementGatewayResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /** The name of the API Management gateway. */
        @path
        @segment("gateways")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(45)
        gatewayName: string,
      },
      ResourceName = "ApiManagementGateway"
    > {}

@armResourceOperations
interface ApiManagementGatewayResources {
  /**
   * Gets an API Management gateway resource description.
   */
  get is ApiManagementGatewayResourceOps.Read<ApiManagementGatewayResource>;

  /**
   * Creates or updates an API Management gateway. This is long running operation and could take several minutes to complete.
   */
  createOrUpdate is ApiManagementGatewayResourceOps.CreateOrUpdateAsync<
    ApiManagementGatewayResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = ApiManagementGatewayResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates an existing API Management gateway.
   */
  @patch(#{ implicitOptionality: false })
  update is ApiManagementGatewayResourceOps.CustomPatchAsync<
    ApiManagementGatewayResource,
    PatchModel = ApiManagementGatewayUpdateParameters
  >;

  /**
   * Deletes an existing API Management gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ApiManagementGatewayResourceOps.DeleteWithoutOkAsync<
    ApiManagementGatewayResource,
    Response =
      | (ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ApiManagementGatewayResource>> & {
          @bodyRoot
          _: ApiManagementGatewayResource;
        })
      | ArmDeletedNoContentResponse
  >;

  /**
   * List all API Management gateways within a resource group.
   */
  listByResourceGroup is ApiManagementGatewayResourceOps.List<
    ApiManagementGatewayResource,
    Parameters = ApiManagementGatewayListPagingParameters,
    Response = ArmResponse<ApiManagementGatewayListResult>
  >;

  /**
   * List all API Management gateways within a subscription.
   */
  list is ArmListBySubscription<
    ApiManagementGatewayResource,
    Parameters = ApiManagementGatewayListPagingParameters,
    Response = ArmResponse<ApiManagementGatewayListResult>
  >;

  /**
   * Gets all available SKU for a given API Management gateway
   */
  @get
  @action("skus")
  @list
  @summary("Gets available SKUs for API Management gateway")
  listAvailableSkus is ApiManagementGatewayResourceOps.ActionSync<
    ApiManagementGatewayResource,
    void,
    ArmResponse<GatewayResourceSkuResults>
  >;
}

@@maxLength(ApiManagementGatewayResource.name, 45);
@@minLength(ApiManagementGatewayResource.name, 1);
@@doc(
  ApiManagementGatewayResource.name,
  "The name of the API Management gateway."
);
@@encodedName(ApiManagementGatewayResource.etag, "application/json", "etag");
@@doc(
  ApiManagementGatewayResource.properties,
  "Properties of the API Management gateway."
);
@@doc(
  ApiManagementGatewayResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate API Management gateway operation."
);
@@doc(
  ApiManagementGatewayResources.update::parameters.properties,
  "Parameters supplied to the CreateOrUpdate API Management gateway operation."
);
