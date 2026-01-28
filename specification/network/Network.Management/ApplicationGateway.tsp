import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Application gateway resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ApplicationGateway extends Resource {
  properties?: ApplicationGatewayPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("applicationGatewayName")
  @segment("applicationGateways")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /** A list of availability zones denoting where the resource needs to come from. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  zones?: string[];

  /**
   * The identity of the application gateway, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    Response = {
      @body body: void;
    },
    Error = CloudError
  >;

  /**
   * Stops the specified application gateway in a resource group.
   */
  stop is ArmResourceActionAsync<
    ApplicationGateway,
    void,
    Response = {
      @body body: void;
    },
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
