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

@armResourceOperations
interface ApiManagementGatewayConfigConnectionResources {
  /**
   * Gets an API Management gateway config connection resource description.
   */
  get is ArmResourceRead<ApiManagementGatewayConfigConnectionResource>;

  /**
   * Creates or updates an API Management gateway config connection. This is long running operation and could take several minutes to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApiManagementGatewayConfigConnectionResource>;

  /**
   * Deletes an existing API Management gateway config connection.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ApiManagementGatewayConfigConnectionResource,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * List all API Management gateway config connections within a gateway.
   */
  listByGateway is ArmResourceListByParent<
    ApiManagementGatewayConfigConnectionResource,
    Response = ArmResponse<ApiManagementGatewayConfigConnectionListResult>
  >;
}

@@maxLength(ApiManagementGatewayConfigConnectionResource.name, 30);
@@minLength(ApiManagementGatewayConfigConnectionResource.name, 1);
@@doc(ApiManagementGatewayConfigConnectionResource.name,
  "The name of the API Management gateway config connection."
);
@@encodedName(ApiManagementGatewayConfigConnectionResource.etag,
  "application/json",
  "etag"
);
@@doc(ApiManagementGatewayConfigConnectionResource.properties,
  "Properties of the API Management gateway config connection."
);
@@doc(ApiManagementGatewayConfigConnectionResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate API Management gateway config connection operation."
);
