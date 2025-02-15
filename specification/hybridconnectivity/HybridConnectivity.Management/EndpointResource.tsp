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

/**
 * @dev A long-running resource action.
 * @template Resource The resource being acted upon
 * @template Request The request model for the action
 * @template Response The response model for the action
 * @template BaseParameters Optional. Allows overriding the parameters for the operation
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "template"
@returnsDoc("Azure operation completed successfully.")
@autoRoute
@armResourceAction(Resource)
@post
op ArmResourceActionSync<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Request extends TypeSpec.Reflection.Model | void,
  Response extends TypeSpec.Reflection.Model | void,
  BaseParameters extends TypeSpec.Reflection.Model = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse,
  RequestBody extends {} = {
    @doc("The content of the action request")
    @bodyRoot
    body: Request;
  }
>(
  ...ResourceInstanceParameters<Resource, BaseParameters>,
  ...Parameters,
  ...RequestBody,
): Response | Error;

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
    ListCredentialsRequest,
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
    },
    RequestBody = {
      /**
       * Object of type ListCredentialsRequest
       */
      @body ListCredentialsRequest?: ListCredentialsRequest;
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
    ListIngressGatewayCredentialsRequest,
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
    },
    RequestBody = {
      /**
       * Object of type ListIngressGatewayCredentialsRequest
       */
      @body
      ListIngressGatewayCredentialsRequest?: ListIngressGatewayCredentialsRequest;
    }
  >;

  /**
   * Fetches the managed proxy details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Endpoints_ListManagedProxyDetails")
  listManagedProxyDetails is Azure.ResourceManager.ArmResourceActionSync<
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
