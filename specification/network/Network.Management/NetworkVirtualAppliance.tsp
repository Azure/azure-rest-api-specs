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
model NetworkVirtualAppliance
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<NetworkVirtualAppliancePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkVirtualAppliance,
    KeyName = "networkVirtualApplianceName",
    SegmentName = "networkVirtualAppliances",
    NamePattern = ""
  >;

  /**
   * The service principal that has read access to cloud-init and config blob.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;
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
    LroHeaders = ArmCombinedLroHeaders &
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkVirtualApplianceConnections_CreateOrUpdate")
  @put
  networkVirtualApplianceConnectionsCreateOrUpdate is NetworkVirtualApplianceNetworkVirtualApplianceOps.CreateOrUpdateAsync<
    NetworkVirtualAppliance,
    Response = ArmResponse<NetworkVirtualApplianceConnection> | (ArmResourceCreatedResponse<
      NetworkVirtualApplianceConnection,
      LroHeaders = ArmAsyncOperationHeader
    > &
      Azure.Core.Foundations.RetryAfterHeader),
    Request = NetworkVirtualApplianceConnection,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieves the details of specified NVA connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkVirtualApplianceConnections_Delete")
  @delete
  networkVirtualApplianceConnectionsDelete is NetworkVirtualApplianceNetworkVirtualApplianceOps.DeleteWithoutOkAsync<
    NetworkVirtualAppliance,
    Response = OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Lists NetworkVirtualApplianceConnections under the NVA.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
