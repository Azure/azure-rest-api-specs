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
    }
  >;

  /**
   * Creates or updates the specified Network Virtual Appliance.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NetworkVirtualAppliance>;

  /**
   * Updates a Network Virtual Appliance.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    NetworkVirtualAppliance,
    PatchModel = TagsObject
  >;

  /**
   * Deletes the specified Network Virtual Appliance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkVirtualAppliance,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Network Virtual Appliances in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<NetworkVirtualAppliance>;

  /**
   * Gets all Network Virtual Appliances in a subscription.
   */
  list is ArmListBySubscription<NetworkVirtualAppliance>;

  /**
   * Restarts one or more VMs belonging to the specified Network Virtual Appliance.
   */
  restart is ArmResourceActionAsync<
    NetworkVirtualAppliance,
    NetworkVirtualApplianceInstanceIds,
    ArmResponse<NetworkVirtualApplianceInstanceIds>,
    OptionalRequestBody = true
  >;

  /**
   * Reimages one VM belonging to the specified Network Virtual Appliance.
   */
  reimage is ArmResourceActionAsync<
    NetworkVirtualAppliance,
    NetworkVirtualApplianceInstanceIds,
    ArmResponse<NetworkVirtualApplianceInstanceIds>,
    OptionalRequestBody = true
  >;

  /**
   * Retrieves the boot diagnostic logs for a VM instance belonging to the specified Network Virtual Appliance.
   */
  getBootDiagnosticLogs is ArmResourceActionAsync<
    NetworkVirtualAppliance,
    NetworkVirtualApplianceBootDiagnosticParameters,
    ArmResponse<NetworkVirtualApplianceInstanceId>
  >;

  /**
   * Creates a connection to Network Virtual Appliance, if it doesn't exist else updates the existing NVA connection'
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkVirtualApplianceConnections_CreateOrUpdate")
  @put
  @action("{connectionName}")
  networkVirtualApplianceConnectionsCreateOrUpdate is ArmResourceActionAsyncBase<
    NetworkVirtualAppliance,
    NetworkVirtualApplianceConnection,
    ArmResponse<NetworkVirtualApplianceConnection> | ArmResourceCreatedResponse<NetworkVirtualApplianceConnection>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkVirtualAppliance>,
    Parameters = {
      /**
       * The name of the NVA connection.
       */
      @pattern("^[A-Za-z0-9_]+")
      @path
      connectionName: string;
    }
  >;

  /**
   * Retrieves the details of specified NVA connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkVirtualApplianceConnections_Get")
  @get
  @action("{connectionName}")
  networkVirtualApplianceConnectionsGet is ArmResourceActionSync<
    NetworkVirtualAppliance,
    void,
    ArmResponse<NetworkVirtualApplianceConnection>,
    Parameters = {
      /**
       * The name of the NVA connection.
       */
      @path
      connectionName: string;
    }
  >;

  /**
   * Deletes a NVA connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkVirtualApplianceConnections_Delete")
  @delete
  @action("{connectionName}")
  networkVirtualApplianceConnectionsDelete is ArmResourceActionAsync<
    NetworkVirtualAppliance,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * The name of the NVA connection.
       */
      @path
      connectionName: string;
    }
  >;

  /**
   * Lists NetworkVirtualApplianceConnections under the NVA.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkVirtualApplianceConnections_List")
  @list
  @get
  @action("networkVirtualApplianceConnections")
  networkVirtualApplianceConnectionsList is ArmResourceActionSync<
    NetworkVirtualAppliance,
    void,
    ArmResponse<NetworkVirtualApplianceConnectionList>
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
@@doc(NetworkVirtualAppliances.networkVirtualApplianceConnectionsCreateOrUpdate::parameters.body,
  "Parameters supplied in an NetworkVirtualApplianceConnection PUT operation."
);
