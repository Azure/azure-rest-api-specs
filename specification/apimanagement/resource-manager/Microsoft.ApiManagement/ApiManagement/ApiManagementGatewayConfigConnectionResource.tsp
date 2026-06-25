import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementGatewayResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * A single API Management gateway resource in List or Get response.
 */
@parentResource(ApiManagementGatewayResource)
model ApiManagementGatewayConfigConnectionResource
  is Azure.ResourceManager.ProxyResource<
    GatewayConfigConnectionBaseProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ApiManagementGatewayConfigConnectionResource,
    KeyName = "configConnectionName",
    SegmentName = "configConnections",
    NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
  >;

  /**
   * ETag of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: Azure.Core.eTag;
}

alias ApiManagementGatewayConfigConnectionListPagingParameters = {
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

// ResourceName = "ApiGatewayConfigConnection" makes the C# emitter produce
// ApiGatewayConfigConnectionResource.cs / Collection.cs (matching GA contract).
@armResourceOperations
interface ApiManagementGatewayConfigConnectionResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management gateway. */
        @path
        @segment("gateways")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(45)
        gatewayName: string,
      },
      {
        /** The name of the API Management gateway config connection. */
        @path
        @segment("configConnections")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(30)
        configConnectionName: string,
      },
      ResourceName = "ApiGatewayConfigConnection"
    > {}

@armResourceOperations
interface ApiManagementGatewayConfigConnectionResources {
  /**
   * Gets an API Management gateway config connection resource description.
   */
  get is ApiManagementGatewayConfigConnectionResourceOps.Read<ApiManagementGatewayConfigConnectionResource>;

  /**
   * Creates or updates an API Management gateway config connection. This is long running operation and could take several minutes to complete.
   */
  createOrUpdate is ApiManagementGatewayConfigConnectionResourceOps.CreateOrUpdateAsync<ApiManagementGatewayConfigConnectionResource>;

  /**
   * Deletes an existing API Management gateway config connection.
   */
  delete is ApiManagementGatewayConfigConnectionResourceOps.DeleteWithoutOkAsync<
    ApiManagementGatewayConfigConnectionResource,
    Parameters = IfMatchHeaderParameter
  >;

  /**
   * List all API Management gateway config connections within a gateway.
   */
  listByGateway is ApiManagementGatewayConfigConnectionResourceOps.List<
    ApiManagementGatewayConfigConnectionResource,
    Parameters = ApiManagementGatewayConfigConnectionListPagingParameters,
    Response = ArmResponse<ApiManagementGatewayConfigConnectionListResult>
  >;
}

@@maxLength(ApiManagementGatewayConfigConnectionResource.name, 30);
@@minLength(ApiManagementGatewayConfigConnectionResource.name, 1);
@@doc(
  ApiManagementGatewayConfigConnectionResource.name,
  "The name of the API Management gateway config connection."
);
@@encodedName(
  ApiManagementGatewayConfigConnectionResource.etag,
  "application/json",
  "etag"
);
@@doc(
  ApiManagementGatewayConfigConnectionResource.properties,
  "Properties of the API Management gateway config connection."
);
@@doc(
  ApiManagementGatewayConfigConnectionResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate API Management gateway config connection operation."
);
