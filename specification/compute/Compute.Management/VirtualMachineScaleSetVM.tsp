import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineScaleSet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Describes a virtual machine scale set virtual machine.
 */
@parentResource(VirtualMachineScaleSet)
model VirtualMachineScaleSetVM
  is Azure.ResourceManager.TrackedResource<VirtualMachineScaleSetVMProperties> {
  ...ResourceNameParameter<
    Resource = VirtualMachineScaleSetVM,
    KeyName = "instanceId",
    SegmentName = "virtualMachines",
    NamePattern = ""
  >;

  /**
   * The virtual machine instance ID.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read)
  instanceId?: string;

  /**
   * The virtual machine SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read)
  sku?: Sku;

  /**
   * Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use.  In the Azure portal, find the marketplace image that you want to use and then click **Want to deploy programmatically, Get Started ->**. Enter any required information and then click **Save**.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  plan?: Plan;

  /**
   * The virtual machine child extension resources.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read)
  resources?: VirtualMachineExtension[];

  /**
   * The virtual machine zones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read)
  zones?: string[];

  /**
   * The identity of the virtual machine, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  identity?: VirtualMachineIdentity;

  /**
   * Etag is property returned in Update/Get response of the VMSS VM, so that customer can supply it in the header to ensure optimistic updates.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias VirtualMachineScaleSetPath = {
  ...Azure.ResourceManager.Legacy.BasePath;
  ...KeysOf<ResourceNameParameter<
    VirtualMachineScaleSet,
    SegmentName = "virtualMachineScaleSets",
    KeyName = "virtualMachineScaleSetName",
    NamePattern = ""
  >>;
};

@armResourceOperations
interface VirtualMachineScaleSetVMSOps
  extends Azure.ResourceManager.Legacy.ComputeLegacyOperations<
      VirtualMachineScaleSetPath,
      KeysOf<{
        ...ResourceNameParameter<
          VirtualMachineScaleSetVM,
          SegmentName = "virtualMachines"
        >,
      }>
    > {}

@armResourceOperations
interface VirtualMachineScaleSetVMS {
  /**
   * Gets a virtual machine from a VM scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_Get")
  get is ComputeResourceRead<
    VirtualMachineScaleSetVM,
    Parameters = {
      /**
       * The expand expression to apply on the operation. 'InstanceView' will retrieve the instance view of the virtual machine. 'UserData' will retrieve the UserData of the virtual machine.
       */
      @query("$expand")
      $expand?: InstanceViewTypes;
    }
  >;

  /**
   * Updates a virtual machine of a VM scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("VirtualMachineScaleSetVMs_Update")
  update is ComputeResourceCreateOrReplaceAsync<
    VirtualMachineScaleSetVM,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header("If-Match")
      IfMatch?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing record set. Other values will result in error from server as they are not supported.
       */
      @header("If-None-Match")
      IfNoneMatch?: string;
    },
    Response = ArmResourceUpdatedResponse<VirtualMachineScaleSetVM> | (ArmAcceptedLroResponse & {
      @bodyRoot _: VirtualMachineScaleSetVM;
    })
  >;

  /**
   * Deletes a virtual machine from a VM scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "deprecated" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
  @operationId("VirtualMachineScaleSetVMs_Delete")
  delete is ComputeResourceDeleteAsync<
    VirtualMachineScaleSetVM,
    Parameters = {
      /**
       * Optional parameter to force delete a virtual machine from a VM scale set. (Feature in Preview)
       */
      @query("forceDeletion")
      forceDeletion?: boolean;
    }
  >;

  /**
   * Gets a list of all virtual machines in a VM scale sets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_List")
  list is VirtualMachineScaleSetVMSOps.List<
    VirtualMachineScaleSetVM,
    Parameters = {
      /**
       * The filter to apply to the operation. Allowed values are 'startswith(instanceView/statuses/code, 'PowerState') eq true', 'properties/latestModelApplied eq true', 'properties/latestModelApplied eq false'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The list parameters. Allowed values are 'instanceView', 'instanceView/statuses'.
       */
      @query("$select")
      $select?: string;

      /**
       * The expand expression to apply to the operation. Allowed values are 'instanceView'.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = VirtualMachineScaleSetVMListResult
  >;

  /**
   * Approve upgrade on deferred rolling upgrade for OS disk on a VM scale set instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_ApproveRollingUpgrade")
  approveRollingUpgrade is ComputeResourceActionNoResponseContentAsync<
    VirtualMachineScaleSetVM,
    void,
    Error = CloudError
  >;

  /**
   * Deallocates a specific virtual machine in a VM scale set. Shuts down the virtual machine and releases the compute resources it uses. You are not billed for the compute resources of this virtual machine once it is deallocated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_Deallocate")
  deallocate is ComputeResourceActionAsync<
    VirtualMachineScaleSetVM,
    void,
    OkResponse
  >;

  /**
   * Gets the status of a virtual machine from a VM scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("instanceView")
  @operationId("VirtualMachineScaleSetVMs_GetInstanceView")
  getInstanceView is ComputeResourceActionSync<
    VirtualMachineScaleSetVM,
    void,
    VirtualMachineScaleSetVMInstanceView
  >;

  /**
   * Reimages (upgrade the operating system) a specific virtual machine in a VM scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_Reimage")
  reimage is ComputeResourceActionAsync<
    VirtualMachineScaleSetVM,
    {
      /**
       * Parameters for the Reimaging Virtual machine in ScaleSet.
       */
      @bodyRoot
      vmScaleSetVMReimageInput?: VirtualMachineScaleSetVMReimageParameters;
    },
    OkResponse
  >;

  /**
   * Allows you to re-image all the disks ( including data disks ) in the a VM scale set instance. This operation is only supported for managed disks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("reimageall")
  @operationId("VirtualMachineScaleSetVMs_ReimageAll")
  reimageAll is ComputeResourceActionAsync<
    VirtualMachineScaleSetVM,
    void,
    OkResponse
  >;

  /**
   * The operation to simulate the eviction of spot virtual machine in a VM scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_SimulateEviction")
  simulateEviction is ComputeResourceActionSync<
    VirtualMachineScaleSetVM,
    void,
    void
  >;

  /**
   * Attach and detach data disks to/from a virtual machine in a VM scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_AttachDetachDataDisks")
  attachDetachDataDisks is ComputeResourceActionAsync<
    VirtualMachineScaleSetVM,
    AttachDetachDataDisksRequest,
    StorageProfile
  >;

  /**
   * Performs maintenance on a virtual machine in a VM scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_PerformMaintenance")
  performMaintenance is ComputeResourceActionAsync<
    VirtualMachineScaleSetVM,
    void,
    OkResponse
  >;

  /**
   * Power off (stop) a virtual machine in a VM scale set. Note that resources are still attached and you are getting charged for the resources. Instead, use deallocate to release resources and avoid charges.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_PowerOff")
  powerOff is ComputeResourceActionAsync<
    VirtualMachineScaleSetVM,
    void,
    OkResponse,
    Parameters = {
      /**
       * The parameter to request non-graceful VM shutdown. True value for this flag indicates non-graceful shutdown whereas false indicates otherwise. Default value for this flag is false if not specified
       */
      @query("skipShutdown")
      skipShutdown?: boolean;
    }
  >;

  /**
   * Shuts down the virtual machine in the virtual machine scale set, moves it to a new node, and powers it back on.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_Redeploy")
  redeploy is ComputeResourceActionAsync<
    VirtualMachineScaleSetVM,
    void,
    OkResponse
  >;

  /**
   * Restarts a virtual machine in a VM scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_Restart")
  restart is ComputeResourceActionAsync<
    VirtualMachineScaleSetVM,
    void,
    OkResponse
  >;

  /**
   * The operation to retrieve SAS URIs of boot diagnostic logs for a virtual machine in a VM scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_RetrieveBootDiagnosticsData")
  retrieveBootDiagnosticsData is ComputeResourceActionSync<
    VirtualMachineScaleSetVM,
    void,
    RetrieveBootDiagnosticsDataResult,
    Parameters = {
      /**
       * Expiration duration in minutes for the SAS URIs with a value between 1 to 1440 minutes. **Note:** If not specified, SAS URIs will be generated with a default expiration duration of 120 minutes.
       */
      @query("sasUriExpirationTimeInMinutes")
      sasUriExpirationTimeInMinutes?: int32;
    }
  >;

  /**
   * Starts a virtual machine in a VM scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_Start")
  start is ComputeResourceActionAsync<
    VirtualMachineScaleSetVM,
    void,
    OkResponse
  >;

  /**
   * Run command on a virtual machine in a VM scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMs_RunCommand")
  runCommand is ComputeResourceActionAsync<
    VirtualMachineScaleSetVM,
    RunCommandInput,
    RunCommandResult
  >;
}

@@doc(VirtualMachineScaleSetVM.name, "The instance ID of the virtual machine.");
@@doc(VirtualMachineScaleSetVM.properties,
  "Describes the properties of a virtual machine scale set virtual machine."
);
@@doc(VirtualMachineScaleSetVMS.update::parameters.resource,
  "Parameters supplied to the Update Virtual Machine Scale Sets VM operation."
);
@@doc(VirtualMachineScaleSetVMS.reimage::parameters.body,
  "Parameters for the Reimaging Virtual machine in ScaleSet."
);
@@doc(VirtualMachineScaleSetVMS.attachDetachDataDisks::parameters.body,
  "Parameters supplied to the attach and detach data disks operation on a Virtual Machine Scale Sets VM."
);
@@doc(VirtualMachineScaleSetVMS.runCommand::parameters.body,
  "Parameters supplied to the Run command operation."
);
