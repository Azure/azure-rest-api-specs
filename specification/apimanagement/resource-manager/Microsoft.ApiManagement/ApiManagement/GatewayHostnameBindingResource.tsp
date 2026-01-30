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
 * A single API Management gateway hostname binding resource in List or Get response.
 */
@parentResource(ApiManagementGatewayResource)
model GatewayHostnameBindingResource
  is Azure.ResourceManager.ProxyResource<
    GatewayHostnameBindingBaseProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = GatewayHostnameBindingResource,
    KeyName = "hostnameBindingName",
    SegmentName = "hostnameBindings",
    NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

@armResourceOperations
interface GatewayHostnameBindingResources {
  /**
   * Gets an API Management gateway hostname binding resource description.
   */
  get is ArmResourceRead<GatewayHostnameBindingResource>;

  /**
   * Creates or updates an API Management gateway hostname binding. This is long running operation and could take several minutes to complete.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GatewayHostnameBindingResource,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<GatewayHostnameBindingResource> &
      ArmCombinedLroHeaders<FinalResult = GatewayHostnameBindingResource>) | ArmResourceCreatedResponse<
      GatewayHostnameBindingResource,
      LroHeaders = ArmCombinedLroHeaders<FinalResult = GatewayHostnameBindingResource>
    >
  >;

  /**
   * Deletes an existing API Management gateway hostname binding.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    GatewayHostnameBindingResource,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | NoContentResponse
  >;

  /**
   * List all API Management gateway hostname bindings within a gateway.
   */
  listByGateway is ArmResourceListByParent<
    GatewayHostnameBindingResource,
    Response = ArmResponse<GatewayHostnameBindingListResult>
  >;

  /**
   * Refresh the secret for an API Management gateway hostname binding.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  refreshSecret is ArmResourceActionAsyncBase<
    GatewayHostnameBindingResource,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<GatewayHostnameBindingResource>
  >;
}

@@maxLength(GatewayHostnameBindingResource.name, 45);
@@minLength(GatewayHostnameBindingResource.name, 1);
@@doc(GatewayHostnameBindingResource.name,
  "Gateway hostname binding identifier. Must be unique in the scope of parent Gateway entity."
);
@@encodedName(GatewayHostnameBindingResource.eTag, "application/json", "etag");
@@doc(GatewayHostnameBindingResource.properties,
  "Properties of the API Management gateway hostname binding."
);
@@doc(GatewayHostnameBindingResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate API Management gateway hostname binding operation."
);
