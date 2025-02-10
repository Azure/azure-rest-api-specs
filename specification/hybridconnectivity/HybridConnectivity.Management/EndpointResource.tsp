import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridConnectivity;
/**
 * The endpoint for the target resource.
 */
model EndpointResource
  is Azure.ResourceManager.ExtensionResource<EndpointProperties> {
  ...ResourceNameParameter<
    Resource = EndpointResource,
    KeyName = "endpointName",
    SegmentName = "endpoints",
    NamePattern = ""
  >;
}

@armResourceOperations
interface EndpointResources {
  /**
   * Gets the endpoint to the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Endpoints_Get")
  get is ArmResourceRead<
    EndpointResource,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * Create or update the endpoint to the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes"
  @operationId("Endpoints_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    EndpointResource,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Response = ArmResourceUpdatedResponse<EndpointResource>
  >;

  /**
   * Update the endpoint to the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @parameterVisibility
  @operationId("Endpoints_Update")
  update is ArmCustomPatchSync<
    EndpointResource,
    EndpointResource,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * Deletes the endpoint access to the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
  @operationId("Endpoints_Delete")
  delete is ArmResourceDeleteSync<
    EndpointResource,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * List of endpoints to the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Endpoints_List")
  list is ArmResourceListByParent<
    EndpointResource,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Response = EndpointsList
  >;

  /**
   * Gets the endpoint access credentials to the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "The name of the body starts with a capital letter"
  @operationId("Endpoints_ListCredentials")
  listCredentials is ArmResourceActionSync<
    EndpointResource,
    {
      /**
       * Object of type ListCredentialsRequest
       */
      @body ListCredentialsRequest?: ListCredentialsRequest;
    },
    EndpointAccessResource,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The is how long the endpoint access token is valid (in seconds).
       */
      @maxValue(10800)
      @minValue(600)
      @query("expiresin")
      expiresin?: int64 = 10800;
    }
  >;

  /**
   * Gets the ingress gateway endpoint credentials
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "The name of the body starts with a capital letter"
  @operationId("Endpoints_ListIngressGatewayCredentials")
  listIngressGatewayCredentials is ArmResourceActionSync<
    EndpointResource,
    {
      /**
       * Object of type ListIngressGatewayCredentialsRequest
       */
      @body
      ListIngressGatewayCredentialsRequest?: ListIngressGatewayCredentialsRequest;
    },
    IngressGatewayResource,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The is how long the endpoint access token is valid (in seconds).
       */
      @maxValue(10800)
      @minValue(600)
      @query("expiresin")
      expiresin?: int64 = 10800;
    }
  >;

  /**
   * Fetches the managed proxy details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Endpoints_ListManagedProxyDetails")
  listManagedProxyDetails is ArmResourceActionSync<
    EndpointResource,
    ManagedProxyRequest,
    ManagedProxyResource,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;
}

@@doc(EndpointResource.name, "The endpoint name.");
@@doc(EndpointResource.properties, "The endpoint properties.");
@@doc(EndpointResources.createOrUpdate::parameters.resource,
  "Endpoint details"
);
@@doc(EndpointResources.update::parameters.properties, "Endpoint details");
@@doc(EndpointResources.listManagedProxyDetails::parameters.body,
  "Object of type ManagedProxyRequest"
);
@@doc(EndpointResources.listIngressGatewayCredentials,
  "Gets the ingress gateway endpoint credentials "
);
@@doc(EndpointResources.listManagedProxyDetails,
  "Fetches the managed proxy details "
);
@@path(EndpointResource.name, #{ allowReserved: true });
