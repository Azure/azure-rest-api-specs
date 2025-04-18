import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Describes a Virtual Machine.
 */
model VirtualMachine
  is Azure.ResourceManager.TrackedResource<VirtualMachineProperties> {
  ...ResourceNameParameter<
    Resource = VirtualMachine,
    KeyName = "vmName",
    SegmentName = "virtualMachines",
    NamePattern = ""
  >;

  /**
   * Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use.  In the Azure portal, find the marketplace image that you want to use and then click **Want to deploy programmatically, Get Started ->**. Enter any required information and then click **Save**.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  plan?: Plan;

  /**
   * The virtual machine child extension resources.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  resources?: VirtualMachineExtension[];

  /**
   * The identity of the virtual machine, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: VirtualMachineIdentity;

  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The extended location of the Virtual Machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  /**
   * ManagedBy is set to Virtual Machine Scale Set(VMSS) flex ARM resourceID, if the VM is part of the VMSS. This property is used by platform for internal resource group delete optimization.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  managedBy?: string;

  /**
   * Etag is property returned in Create/Update/Get response of the VM, so that customer can supply it in the header to ensure optimistic updates.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Placement section specifies the user-defined constraints for virtual machine hardware placement. This property cannot be changed once VM is provisioned. Minimum api-version: 2024-11-01.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  placement?: Placement;
}

@armResourceOperations
interface VirtualMachines {
  /**
   * Retrieves information about the model view or the instance view of a virtual machine.
   */
  get is ComputeResourceRead<
    VirtualMachine,
    Parameters = {
      /**
       * The expand expression to apply on the operation. 'InstanceView' retrieves a snapshot of the runtime properties of the virtual machine that is managed by the platform and can change outside of control plane operations. 'UserData' retrieves the UserData property as part of the VM model view that was provided by the user during the VM Create/Update operation.
       */
      @query("$expand")
      $expand?: InstanceViewTypes;
    }
  >;

  /**
   * The operation to create or update a virtual machine. Please note some properties can be set only during virtual machine creation.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  createOrUpdate is ComputeResourceCreateOrReplaceAsync<
    VirtualMachine,
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
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update a virtual machine.
   */
  @patch(#{ implicitOptionality: false })
  update is ComputeCustomPatchAsync<
    VirtualMachine,
    VirtualMachineUpdate,
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
    Response = ArmResponse<VirtualMachine> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to delete a virtual machine.
   */
  #suppress "deprecated" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
  delete is ComputeResourceDeleteAsync<
    VirtualMachine,
    Parameters = {
      /**
       * Optional parameter to force delete virtual machines.
       */
      @query("forceDeletion")
      forceDeletion?: boolean;
    }
  >;

  /**
   * Lists all of the virtual machines in the specified resource group. Use the nextLink property in the response to get the next page of virtual machines.
   */
  list is ComputeResourceListByParent<
    VirtualMachine,
    Parameters = {
      /**
       * The system query option to filter VMs returned in the response. Allowed value is 'virtualMachineScaleSet/id' eq /subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}'
       */
      @query("$filter")
      $filter?: string;

      /**
       * The expand expression to apply on operation. 'instanceView' enables fetching run time status of all Virtual Machines, this can only be specified if a valid $filter option is specified
       */
      @query("$expand")
      $expand?: ExpandTypeForListVMs;
    },
    Response = VirtualMachineListResult
  >;

  /**
   * Lists all of the virtual machines in the specified subscription. Use the nextLink property in the response to get the next page of virtual machines.
   */
  listAll is ComputeListBySubscription<
    VirtualMachine,
    Parameters = {
      /**
       * statusOnly=true enables fetching run time status of all Virtual Machines in the subscription.
       */
      @query("statusOnly")
      statusOnly?: string;

      /**
       * The system query option to filter VMs returned in the response. Allowed value is 'virtualMachineScaleSet/id' eq /subscriptions/{subId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}'
       */
      @query("$filter")
      $filter?: string;

      /**
       * The expand expression to apply on operation. 'instanceView' enables fetching run time status of all Virtual Machines, this can only be specified if a valid $filter option is specified
       */
      @query("$expand")
      $expand?: ExpandTypesForListVMs;
    },
    Response = VirtualMachineListResult
  >;

  /**
   * Assess patches on the VM.
   */
  assessPatches is ComputeResourceActionAsync<
    VirtualMachine,
    void,
    VirtualMachineAssessPatchesResult
  >;

  /**
   * Attach and detach data disks to/from the virtual machine.
   */
  attachDetachDataDisks is ComputeResourceActionAsync<
    VirtualMachine,
    AttachDetachDataDisksRequest,
    StorageProfile
  >;

  /**
   * Captures the VM by copying virtual hard disks of the VM and outputs a template that can be used to create similar VMs.
   */
  capture is ComputeResourceActionAsync<
    VirtualMachine,
    VirtualMachineCaptureParameters,
    VirtualMachineCaptureResult
  >;

  /**
   * Converts virtual machine disks from blob-based to managed disks. Virtual machine must be stop-deallocated before invoking this operation.
   */
  convertToManagedDisks is ComputeResourceActionAsync<
    VirtualMachine,
    void,
    Response = OkResponse
  >;

  /**
   * Shuts down the virtual machine and releases the compute resources. You are not billed for the compute resources that this virtual machine uses.
   */
  deallocate is ComputeResourceActionAsync<
    VirtualMachine,
    void,
    OkResponse,
    Parameters = {
      /**
       * Optional parameter to hibernate a virtual machine.
       */
      @query("hibernate")
      hibernate?: boolean;
    }
  >;

  /**
   * Sets the OS state of the virtual machine to generalized. It is recommended to sysprep the virtual machine before performing this operation. For Windows, please refer to [Create a managed image of a generalized VM in Azure](https://docs.microsoft.com/azure/virtual-machines/windows/capture-image-resource). For Linux, please refer to [How to create an image of a virtual machine or VHD](https://docs.microsoft.com/azure/virtual-machines/linux/capture-image).
   */
  generalize is ComputeResourceActionSync<VirtualMachine, void, OkResponse>;

  /**
   * Installs patches on the VM.
   */
  installPatches is ComputeResourceActionAsync<
    VirtualMachine,
    VirtualMachineInstallPatchesParameters,
    VirtualMachineInstallPatchesResult
  >;

  /**
   * Retrieves information about the run-time state of a virtual machine.
   */
  @get
  instanceView is ComputeResourceActionSync<
    VirtualMachine,
    void,
    VirtualMachineInstanceView
  >;

  /**
   * The operation to perform maintenance on a virtual machine.
   */
  performMaintenance is ComputeResourceActionAsync<
    VirtualMachine,
    void,
    OkResponse
  >;

  /**
   * The operation to power off (stop) a virtual machine. The virtual machine can be restarted with the same provisioned resources. You are still charged for this virtual machine.
   */
  powerOff is ComputeResourceActionAsync<
    VirtualMachine,
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
   * The operation to reapply a virtual machine's state.
   */
  reapply is ComputeResourceActionAsync<VirtualMachine, void, OkResponse>;

  /**
   * Shuts down the virtual machine, moves it to a new node, and powers it back on.
   */
  redeploy is ComputeResourceActionAsync<VirtualMachine, void, OkResponse>;

  /**
   * Reimages (upgrade the operating system) a virtual machine which don't have a ephemeral OS disk, for virtual machines who have a ephemeral OS disk the virtual machine is reset to initial state. NOTE: The retaining of old OS disk depends on the value of deleteOption of OS disk. If deleteOption is detach, the old OS disk will be preserved after reimage. If deleteOption is delete, the old OS disk will be deleted after reimage. The deleteOption of the OS disk should be updated accordingly before performing the reimage.
   */
  reimage is ComputeResourceActionAsync<
    VirtualMachine,
    {
      /**
       * Parameters supplied to the Reimage Virtual Machine operation.
       */
      @bodyRoot parameters?: VirtualMachineReimageParameters;
    },
    OkResponse
  >;

  /**
   * The operation to restart a virtual machine.
   */
  restart is ComputeResourceActionAsync<VirtualMachine, void, OkResponse>;

  /**
   * The operation to retrieve SAS URIs for a virtual machine's boot diagnostic logs.
   */
  retrieveBootDiagnosticsData is ComputeResourceActionSync<
    VirtualMachine,
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
   * The operation to simulate the eviction of spot virtual machine.
   */
  simulateEviction is ComputeResourceActionSync<
    VirtualMachine,
    void,
    NoContentResponse
  >;

  /**
   * The operation to start a virtual machine.
   */
  start is ComputeResourceActionAsync<VirtualMachine, void, OkResponse>;

  /**
   * Lists all available virtual machine sizes to which the specified virtual machine can be resized.
   */
  @get
  @action("vmSizes")
  listAvailableSizes is ComputeResourceActionSync<
    VirtualMachine,
    void,
    VirtualMachineSizeListResult
  >;

  /**
   * Run command on the VM.
   */
  runCommand is ComputeResourceActionAsync<
    VirtualMachine,
    RunCommandInput,
    RunCommandResult
  >;

  /**
   * Migrate a virtual machine from availability set to Flexible Virtual Machine Scale Set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("migrateToVirtualMachineScaleSet")
  @operationId("VirtualMachines_migrateToVMScaleSet")
  migrateToVMScaleSet is ArmResourceActionAsyncBase<
    VirtualMachine,
    {
      /**
       * Parameters supplied to the Migrate Virtual Machine operation.
       */
      @bodyRoot
      parameters?: MigrateVMToVirtualMachineScaleSetInput;
    },
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualMachine>,
    Error = CloudError
  >;
}

@@doc(VirtualMachine.name, "The name of the virtual machine.");
@@doc(VirtualMachine.properties,
  "Describes the properties of a Virtual Machine."
);
@@doc(VirtualMachines.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Virtual Machine operation."
);
@@doc(VirtualMachines.update::parameters.properties,
  "Parameters supplied to the Update Virtual Machine operation."
);
@@doc(VirtualMachines.attachDetachDataDisks::parameters.body,
  "Parameters supplied to the attach and detach data disks operation on the virtual machine."
);
@@doc(VirtualMachines.capture::parameters.body,
  "Parameters supplied to the Capture Virtual Machine operation."
);
@@doc(VirtualMachines.installPatches::parameters.body,
  "Input for InstallPatches as directly received by the API"
);
@@doc(VirtualMachines.reimage::parameters.body,
  "Parameters supplied to the Reimage Virtual Machine operation."
);
@@doc(VirtualMachines.runCommand::parameters.body,
  "Parameters supplied to the Run command operation."
);
