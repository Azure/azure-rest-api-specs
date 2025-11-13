import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Application gateway resource.
 */
model ApplicationGateway
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ApplicationGatewayPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ApplicationGateway,
    KeyName = "applicationGatewayName",
    SegmentName = "applicationGateways",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The identity of the application gateway, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface ApplicationGateways {
  /**
   * Gets the specified application gateway.
   */
  get is ArmResourceRead<ApplicationGateway>;

  /**
   * Creates or updates the specified application gateway.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApplicationGateway>;

  /**
   * Updates the specified application gateway tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<ApplicationGateway, PatchModel = TagsObject>;

  /**
   * Deletes the specified application gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationGateway,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all application gateways in a resource group.
   */
  list is ArmResourceListByParent<ApplicationGateway>;

  /**
   * Gets all the application gateways in a subscription.
   */
  listAll is ArmListBySubscription<ApplicationGateway>;

  /**
   * Starts the specified application gateway.
   */
  start is ArmResourceActionAsync<ApplicationGateway, void, OkResponse>;

  /**
   * Stops the specified application gateway in a resource group.
   */
  stop is ArmResourceActionAsync<ApplicationGateway, void, OkResponse>;

  /**
   * Gets the backend health of the specified application gateway in a resource group.
   */
  @action("backendhealth")
  backendHealth is ArmResourceActionAsync<
    ApplicationGateway,
    void,
    ArmResponse<ApplicationGatewayBackendHealth>,
    Parameters = {
      /**
       * Expands BackendAddressPool and BackendHttpSettings referenced in backend health.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Gets the backend health for given combination of backend pool and http setting of the specified application gateway in a resource group.
   */
  @action("getBackendHealthOnDemand")
  backendHealthOnDemand is ArmResourceActionAsync<
    ApplicationGateway,
    ApplicationGatewayOnDemandProbe,
    ArmResponse<ApplicationGatewayBackendHealthOnDemand>,
    Parameters = {
      /**
       * Expands BackendAddressPool and BackendHttpSettings referenced in backend health.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Lists all private link resources on an application gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGatewayPrivateLinkResources_List")
  @list
  @get
  @action("privateLinkResources")
  applicationGatewayPrivateLinkResourcesList is ArmResourceActionSync<
    ApplicationGateway,
    void,
    ArmResponse<ResourceListResult<ApplicationGatewayPrivateLinkResource>>
  >;
}

@@doc(ApplicationGateway.name, "The name of the application gateway.");
@@doc(ApplicationGateway.properties, "Properties of the application gateway.");
@@doc(ApplicationGateways.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update application gateway operation."
);
@@doc(ApplicationGateways.updateTags::parameters.properties,
  "Parameters supplied to update application gateway tags."
);
@@doc(ApplicationGateways.backendHealthOnDemand::parameters.body,
  "Request body for on-demand test probe operation."
);
