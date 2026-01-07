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
 * NetworkVirtualAppliance Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkVirtualAppliance extends Resource {
  properties?: NetworkVirtualAppliancePropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("networkVirtualApplianceName")
  @segment("networkVirtualAppliances")
  name: string;

  /**
   * The service principal that has read access to cloud-init and config blob.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias NetworkVirtualApplianceNetworkVirtualApplianceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the Network Virtual Appliance. */
    @path
    @segment("networkVirtualAppliances")
    @key
    networkVirtualApplianceName: string;
  },
  {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("networkVirtualApplianceConnections")
    @key
    connectionName: string;
  }
>;

@armResourceOperations
interface NetworkVirtualAppliances {
  /**
   * Gets the specified Network Virtual Appliance.
   */
  get is ArmResourceRead<
    NetworkVirtualAppliance,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates or updates the specified Network Virtual Appliance.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetworkVirtualAppliance,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = NetworkVirtualAppliance> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Updates a Network Virtual Appliance.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    NetworkVirtualAppliance,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified Network Virtual Appliance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkVirtualAppliance,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all Network Virtual Appliances in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    NetworkVirtualAppliance,
    Error = CloudError
  >;

  /**
   * Gets all Network Virtual Appliances in a subscription.
   */
  list is ArmListBySubscription<NetworkVirtualAppliance, Error = CloudError>;

  /**
   * Restarts one or more VMs belonging to the specified Network Virtual Appliance.
   */
  restart is ArmResourceActionAsync<
    NetworkVirtualAppliance,
    NetworkVirtualApplianceInstanceIds,
    NetworkVirtualApplianceInstanceIds,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Reimages one VM belonging to the specified Network Virtual Appliance.
   */
  reimage is ArmResourceActionAsync<
    NetworkVirtualAppliance,
    NetworkVirtualApplianceInstanceIds,
    NetworkVirtualApplianceInstanceIds,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Retrieves the boot diagnostic logs for a VM instance belonging to the specified Network Virtual Appliance.
   */
  getBootDiagnosticLogs is ArmResourceActionAsync<
    NetworkVirtualAppliance,
    NetworkVirtualApplianceBootDiagnosticParameters,
    NetworkVirtualApplianceInstanceId,
    Error = CloudError
  >;

  /**
   * Creates a connection to Network Virtual Appliance, if it doesn't exist else updates the existing NVA connection'
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkVirtualApplianceConnections_CreateOrUpdate")
  @put
  networkVirtualApplianceConnectionsCreateOrUpdate is NetworkVirtualApplianceNetworkVirtualApplianceOps.CreateOrUpdateAsync<
    NetworkVirtualAppliance,
    Response = ArmResponse<NetworkVirtualApplianceConnection> | (ArmResourceCreatedResponse<
      NetworkVirtualApplianceConnection,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = NetworkVirtualApplianceConnection>
    > &
      Azure.Core.Foundations.RetryAfterHeader),
    Request = NetworkVirtualApplianceConnection,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieves the details of specified NVA connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkVirtualApplianceConnections_Get")
  @get
  networkVirtualApplianceConnectionsGet is NetworkVirtualApplianceNetworkVirtualApplianceOps.Read<
    NetworkVirtualAppliance,
    Response = ArmResponse<NetworkVirtualApplianceConnection>,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes a NVA connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkVirtualApplianceConnections_Delete")
  @delete
  networkVirtualApplianceConnectionsDelete is NetworkVirtualApplianceNetworkVirtualApplianceOps.DeleteWithoutOkAsync<
    NetworkVirtualAppliance,
    Response = {
      @body body: void;
    } | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Lists NetworkVirtualApplianceConnections under the NVA.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkVirtualApplianceConnections_List")
  @list
  @get
  networkVirtualApplianceConnectionsList is NetworkVirtualApplianceNetworkVirtualApplianceOps.List<
    NetworkVirtualAppliance,
    Response = ArmResponse<NetworkVirtualApplianceConnectionList>,
    OverrideErrorType = CloudError
  >;
}

@@doc(NetworkVirtualAppliance.name, "The name of Network Virtual Appliance.");
@@doc(NetworkVirtualAppliance.properties,
  "Properties of the Network Virtual Appliance."
);
@@doc(NetworkVirtualAppliances.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Network Virtual Appliance."
);
@@doc(NetworkVirtualAppliances.updateTags::parameters.properties,
  "Parameters supplied to Update Network Virtual Appliance Tags."
);
@@doc(NetworkVirtualAppliances.restart::parameters.body,
  "Specifies a list of virtual machine instance IDs from the Network Virtual Appliance VM instances."
);
@@doc(NetworkVirtualAppliances.reimage::parameters.body,
  "Specifies a list of virtual machine instance IDs from the Network Virtual Appliance VM instances."
);
@@doc(NetworkVirtualAppliances.getBootDiagnosticLogs::parameters.body,
  "Parameters supplied to retrieve boot diagnostic logs for a NVA VM instance"
);
@@doc(NetworkVirtualAppliances.networkVirtualApplianceConnectionsCreateOrUpdate::parameters.resource,
  "Parameters supplied in an NetworkVirtualApplianceConnection PUT operation."
);
