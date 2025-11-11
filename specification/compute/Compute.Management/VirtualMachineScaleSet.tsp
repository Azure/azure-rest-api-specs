import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Versioning;

namespace Microsoft.Compute;
/**
 * Describes a Virtual Machine Scale Set.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
#suppress "@azure-tools/typespec-azure-core/no-private-usage"
@Azure.ResourceManager.Private.armResourceInternal(
  VirtualMachineScaleSetProperties
)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VirtualMachineScaleSet extends Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = VirtualMachineScaleSet,
    KeyName = "vmScaleSetName",
    SegmentName = "virtualMachineScaleSets",
    NamePattern = ""
  >;

  /**
   * The virtual machine scale set sku.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;

  /**
   * Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use.  In the Azure portal, find the marketplace image that you want to use and then click **Want to deploy programmatically, Get Started ->**. Enter any required information and then click **Save**.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  plan?: Plan;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  #suppress "@azure-tools/typespec-azure-core/no-private-usage"
  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineScaleSetProperties;

  /**
   * The identity of the virtual machine scale set, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: VirtualMachineScaleSetIdentity;

  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The extended location of the Virtual Machine Scale Set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  /**
   * Etag is property returned in Create/Update/Get response of the VMSS, so that customer can supply it in the header to ensure optimistic updates
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Placement section specifies the user-defined constraints for virtual machine scale set hardware placement. This property cannot be changed once VMSS is provisioned. Minimum api-version: 2025-04-01.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @added(Versions.v2025_04_01)
  placement?: Placement;
}

@armResourceOperations
interface VirtualMachineScaleSets {
  /**
   * Display information about a virtual machine scale set.
   */
  get is ComputeResourceRead<
    VirtualMachineScaleSet,
    Parameters = {
      /**
       * The expand expression to apply on the operation. 'UserData' retrieves the UserData property of the VM scale set that was provided by the user during the VM scale set Create/Update operation
       */
      @query("$expand")
      $expand?: ExpandTypesForGetVMScaleSets;
    }
  >;

  /**
   * Create or update a VM scale set.
   */
  createOrUpdate is ComputeResourceCreateOrReplaceAsync<
    VirtualMachineScaleSet,
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
   * Update a VM scale set.
   */
  @patch(#{ implicitOptionality: false })
  update is ComputeCustomPatchAsync<
    VirtualMachineScaleSet,
    VirtualMachineScaleSetUpdate,
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
    Response = ArmResponse<VirtualMachineScaleSet> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a VM scale set.
   */
  #suppress "deprecated" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
  delete is ComputeResourceDeleteAsync<
    VirtualMachineScaleSet,
    Parameters = {
      /**
       * Optional parameter to force delete a VM scale set. (Feature in Preview)
       */
      @query("forceDeletion")
      forceDeletion?: boolean;
    }
  >;

  /**
   * Gets a list of all VM scale sets under a resource group.
   */
  list is ComputeResourceListByParent<
    VirtualMachineScaleSet,
    Response = VirtualMachineScaleSetListResult
  >;

  /**
   * Gets a list of all VM Scale Sets in the subscription, regardless of the associated resource group. Use nextLink property in the response to get the next page of VM Scale Sets. Do this till nextLink is null to fetch all the VM Scale Sets.
   */
  listAll is ComputeListBySubscription<
    VirtualMachineScaleSet,
    Response = VirtualMachineScaleSetListWithLinkResult
  >;

  /**
   * Approve upgrade on deferred rolling upgrades for OS disks in the virtual machines in a VM scale set.
   */
  approveRollingUpgrade is ComputeResourceActionNoResponseContentAsync<
    VirtualMachineScaleSet,
    {
      /**
       * A list of virtual machine instance IDs from the VM scale set.
       */
      @bodyRoot vmInstanceIDs?: VirtualMachineScaleSetVMInstanceIDs;
    },
    Error = CloudError
  >;

  /**
   * Converts SinglePlacementGroup property to false for a existing virtual machine scale set.
   */
  convertToSinglePlacementGroup is ComputeResourceActionSync<
    VirtualMachineScaleSet,
    VMScaleSetConvertToSinglePlacementGroupInput,
    OkResponse
  >;

  /**
   * Deallocates specific virtual machines in a VM scale set. Shuts down the virtual machines and releases the compute resources. You are not billed for the compute resources that this virtual machine scale set deallocates.
   */
  deallocate is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    {
      /**
       * A list of virtual machine instance IDs from the VM scale set.
       */
      @bodyRoot vmInstanceIDs?: VirtualMachineScaleSetVMInstanceIDs;
    },
    Response = OkResponse,
    Parameters = {
      /**
       * Optional parameter to hibernate a virtual machine from the VM scale set. (This feature is available for VMSS with Flexible OrchestrationMode only)
       */
      @query("hibernate")
      hibernate?: boolean;
    }
  >;

  /**
   * Deletes virtual machines in a VM scale set.
   */
  @action("delete")
  deleteInstances is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    VirtualMachineScaleSetVMInstanceRequiredIDs,
    OkResponse,
    Parameters = {
      /**
       * Optional parameter to force delete virtual machines from the VM scale set. (Feature in Preview)
       */
      @query("forceDeletion")
      forceDeletion?: boolean;
    }
  >;

  /**
   * Manual platform update domain walk to update virtual machines in a service fabric virtual machine scale set.
   */
  forceRecoveryServiceFabricPlatformUpdateDomainWalk is ComputeResourceActionSync<
    VirtualMachineScaleSet,
    void,
    RecoveryWalkResponse,
    Parameters = {
      /**
       * The platform update domain for which a manual recovery walk is requested
       */
      @query("platformUpdateDomain")
      platformUpdateDomain: int32;

      /**
       * The zone in which the manual recovery walk is requested for cross zone virtual machine scale set
       */
      @query("zone")
      zone?: string;

      /**
       * The placement group id for which the manual recovery walk is requested.
       */
      @query("placementGroupId")
      placementGroupId?: string;
    }
  >;

  /**
   * Gets the status of a VM scale set instance.
   */
  @get
  @action("instanceView")
  getInstanceView is ComputeResourceActionSync<
    VirtualMachineScaleSet,
    void,
    VirtualMachineScaleSetInstanceView
  >;

  /**
   * Upgrades one or more virtual machines to the latest SKU set in the VM scale set model.
   */
  @action("manualupgrade")
  updateInstances is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    VirtualMachineScaleSetVMInstanceRequiredIDs,
    OkResponse
  >;

  /**
   * Gets list of OS upgrades on a VM scale set instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @operationId("VirtualMachineScaleSets_GetOSUpgradeHistory")
  @action("osUpgradeHistory")
  @list
  getOSUpgradeHistory is ComputeResourceActionSync<
    VirtualMachineScaleSet,
    void,
    VirtualMachineScaleSetListOSUpgradeHistory
  >;

  /**
   * Perform maintenance on one or more virtual machines in a VM scale set. Operation on instances which are not eligible for perform maintenance will be failed. Please refer to best practices for more details: https://docs.microsoft.com/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-maintenance-notifications
   */
  performMaintenance is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    {
      /**
       * A list of virtual machine instance IDs from the VM scale set.
       */
      @bodyRoot vmInstanceIDs?: VirtualMachineScaleSetVMInstanceIDs;
    },
    Response = OkResponse
  >;

  /**
   * Power off (stop) one or more virtual machines in a VM scale set. Note that resources are still attached and you are getting charged for the resources. Instead, use deallocate to release resources and avoid charges.
   */
  @action("poweroff")
  powerOff is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    {
      /**
       * A list of virtual machine instance IDs from the VM scale set.
       */
      @bodyRoot vmInstanceIDs?: VirtualMachineScaleSetVMInstanceIDs;
    },
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
   * Reapplies the Virtual Machine Scale Set Virtual Machine Profile to the Virtual Machine Instances
   */
  reapply is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    void,
    OkResponse
  >;

  /**
   * Shuts down all the virtual machines in the virtual machine scale set, moves them to a new node, and powers them back on.
   */
  redeploy is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    {
      /**
       * A list of virtual machine instance IDs from the VM scale set.
       */
      @bodyRoot vmInstanceIDs?: VirtualMachineScaleSetVMInstanceIDs;
    },
    OkResponse
  >;

  /**
   * Reimages (upgrade the operating system) one or more virtual machines in a VM scale set which don't have a ephemeral OS disk, for virtual machines who have a ephemeral OS disk the virtual machine is reset to initial state.
   */
  reimage is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    {
      /**
       * Parameters for Reimaging VM ScaleSet.
       */
      @bodyRoot
      vmScaleSetReimageInput?: VirtualMachineScaleSetReimageParameters;
    },
    OkResponse
  >;

  /**
   * Reimages all the disks ( including data disks ) in the virtual machines in a VM scale set. This operation is only supported for managed disks.
   */
  @action("reimageall")
  reimageAll is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    {
      /**
       * A list of virtual machine instance IDs from the VM scale set.
       */
      @bodyRoot vmInstanceIDs?: VirtualMachineScaleSetVMInstanceIDs;
    },
    OkResponse
  >;

  /**
   * Restarts one or more virtual machines in a VM scale set.
   */
  restart is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    {
      /**
       * A list of virtual machine instance IDs from the VM scale set.
       */
      @bodyRoot vmInstanceIDs?: VirtualMachineScaleSetVMInstanceIDs;
    },
    OkResponse
  >;

  /**
   * Changes ServiceState property for a given service
   */
  setOrchestrationServiceState is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    OrchestrationServiceStateInput,
    OkResponse
  >;

  /**
   * Gets a list of SKUs available for your VM scale set, including the minimum and maximum VM instances allowed for each SKU.
   */
  @get
  @action("skus")
  @list
  listSkus is ComputeResourceActionSync<
    VirtualMachineScaleSet,
    void,
    VirtualMachineScaleSetListSkusResult
  >;

  /**
   * Starts one or more virtual machines in a VM scale set.
   */
  start is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    {
      /**
       * A list of virtual machine instance IDs from the VM scale set.
       */
      @bodyRoot vmInstanceIDs?: VirtualMachineScaleSetVMInstanceIDs;
    },
    OkResponse
  >;

  /**
   * Starts a rolling upgrade to move all extensions for all virtual machine scale set instances to the latest available extension version. Instances which are already running the latest extension versions are not affected.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("extensionRollingUpgrade")
  @operationId("VirtualMachineScaleSetRollingUpgrades_StartExtensionUpgrade")
  startExtensionUpgrade is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    void,
    Response = OkResponse
  >;

  /**
   * Starts a rolling upgrade to move all virtual machine scale set instances to the latest available Platform Image OS version. Instances which are already running the latest available OS version are not affected.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("osRollingUpgrade")
  @operationId("VirtualMachineScaleSetRollingUpgrades_StartOSUpgrade")
  startOSUpgrade is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    void,
    Response = OkResponse
  >;

  /**
   * Cancels the current virtual machine scale set rolling upgrade.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("rollingUpgrades/cancel")
  @operationId("VirtualMachineScaleSetRollingUpgrades_Cancel")
  cancel is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    void,
    Response = OkResponse
  >;

  /**
   * Scales out one or more virtual machines in a VM scale set.
   */
  @added(Versions.v2025_04_01)
  @action("scaleOut")
  scaleOut is ComputeResourceActionAsync<
    VirtualMachineScaleSet,
    VMScaleSetScaleOutInput,
    Response = OkResponse
  >;
}

@@doc(VirtualMachineScaleSet.name, "The name of the VM scale set.");
@@doc(VirtualMachineScaleSet.properties,
  "Describes the properties of a Virtual Machine Scale Set."
);
@@doc(VirtualMachineScaleSets.createOrUpdate::parameters.resource,
  "The scale set object."
);
@@doc(VirtualMachineScaleSets.update::parameters.properties,
  "The scale set object."
);
@@doc(VirtualMachineScaleSets.approveRollingUpgrade::parameters.body,
  "A list of virtual machine instance IDs from the VM scale set."
);
@@doc(VirtualMachineScaleSets.convertToSinglePlacementGroup::parameters.body,
  "The input object for ConvertToSinglePlacementGroup API."
);
@@doc(VirtualMachineScaleSets.deallocate::parameters.body,
  "A list of virtual machine instance IDs from the VM scale set."
);
@@doc(VirtualMachineScaleSets.deleteInstances::parameters.body,
  "A list of virtual machine instance IDs from the VM scale set."
);
@@doc(VirtualMachineScaleSets.updateInstances::parameters.body,
  "A list of virtual machine instance IDs from the VM scale set."
);
@@doc(VirtualMachineScaleSets.performMaintenance::parameters.body,
  "A list of virtual machine instance IDs from the VM scale set."
);
@@doc(VirtualMachineScaleSets.powerOff::parameters.body,
  "A list of virtual machine instance IDs from the VM scale set."
);
@@doc(VirtualMachineScaleSets.redeploy::parameters.body,
  "A list of virtual machine instance IDs from the VM scale set."
);
@@doc(VirtualMachineScaleSets.reimage::parameters.body,
  "Parameters for Reimaging VM ScaleSet."
);
@@doc(VirtualMachineScaleSets.reimageAll::parameters.body,
  "A list of virtual machine instance IDs from the VM scale set."
);
@@doc(VirtualMachineScaleSets.restart::parameters.body,
  "A list of virtual machine instance IDs from the VM scale set."
);
@@doc(VirtualMachineScaleSets.setOrchestrationServiceState::parameters.body,
  "The input object for SetOrchestrationServiceState API."
);
@@doc(VirtualMachineScaleSets.start::parameters.body,
  "A list of virtual machine instance IDs from the VM scale set."
);
@@doc(VirtualMachineScaleSets.scaleOut::parameters.body,
  "The input object for ScaleOut API."
);
