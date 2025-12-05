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
  is Azure.ResourceManager.ProxyResource<ApplicationGatewayPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ApplicationGateway,
    KeyName = "applicationGatewayName",
    SegmentName = "applicationGateways",
    NamePattern = ""
  >;

  /** Resource tags. */
  tags?: TagsObject;

  /** Resource location. */
  location?: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  @visibility(Lifecycle.Read)
  etag?: string;

  /** A list of availability zones denoting where the resource needs to come from. */
  zones?: string[];

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
  get is ArmResourceRead<ApplicationGateway, Error = CloudError>;

  /**
   * Creates or updates the specified application gateway.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApplicationGateway,
    Error = CloudError
  >;

  /**
   * Updates the specified application gateway tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ApplicationGateway,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified application gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationGateway,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all application gateways in a resource group.
   */
  list is ArmResourceListByParent<ApplicationGateway, Error = CloudError>;

  /**
   * Gets all the application gateways in a subscription.
   */
  listAll is ArmListBySubscription<ApplicationGateway, Error = CloudError>;

  /**
   * Starts the specified application gateway.
   */
  start is ArmResourceActionAsync<
    ApplicationGateway,
    void,
    OkResponse,
    Error = CloudError
  >;

  /**
   * Stops the specified application gateway in a resource group.
   */
  stop is ArmResourceActionAsync<
    ApplicationGateway,
    void,
    OkResponse,
    Error = CloudError
  >;

  /**
   * Gets the backend health of the specified application gateway in a resource group.
   */
  @action("backendhealth")
  backendHealth is ArmResourceActionAsync<
    ApplicationGateway,
    void,
    ApplicationGatewayBackendHealth,
    Parameters = {
      /**
       * Expands BackendAddressPool and BackendHttpSettings referenced in backend health.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Gets the backend health for given combination of backend pool and http setting of the specified application gateway in a resource group.
   */
  @action("getBackendHealthOnDemand")
  backendHealthOnDemand is ArmResourceActionAsync<
    ApplicationGateway,
    ApplicationGatewayOnDemandProbe,
    ApplicationGatewayBackendHealthOnDemand,
    Parameters = {
      /**
       * Expands BackendAddressPool and BackendHttpSettings referenced in backend health.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
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
    ArmResponse<ResourceListResult<ApplicationGatewayPrivateLinkResource>>,
    Error = CloudError
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
