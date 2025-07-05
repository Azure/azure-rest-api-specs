import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A virtual machine.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model LabVirtualMachine extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("virtualmachines")
  name: string;

  properties: LabVirtualMachineProperties;
}

@armResourceOperations
interface LabVirtualMachineOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = LabVirtualMachine,
        KeyName = "name",
        SegmentName = "virtualmachines",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface LabVirtualMachines {
  /**
   * Get virtual machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_Get")
  get is LabVirtualMachineOps.Read<
    LabVirtualMachine,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=artifacts,computeVm,networkInterface,applicableSchedule)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_CreateOrUpdate")
  createOrUpdate is LabVirtualMachineOps.CreateOrUpdateAsync<
    LabVirtualMachine,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of virtual machines. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  @operationId("VirtualMachines_Update")
  update is LabVirtualMachineOps.CustomPatchSync<
    LabVirtualMachine,
    PatchModel = LabVirtualMachineFragment
  >;

  /**
   * Delete virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("VirtualMachines_Delete")
  delete is LabVirtualMachineOps.DeleteWithoutOkAsync<
    LabVirtualMachine,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List virtual machines in a given lab.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_List")
  list is LabVirtualMachineOps.List<
    LabVirtualMachine,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=artifacts,computeVm,networkInterface,applicableSchedule)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<LabVirtualMachineList>
  >;

  /**
   * Attach a new or existing data disk to virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_AddDataDisk")
  addDataDisk is LabVirtualMachineOps.ActionAsync<
    LabVirtualMachine,
    DataDiskProperties,
    OkResponse
  >;

  /**
   * Apply artifacts to virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_ApplyArtifacts")
  applyArtifacts is LabVirtualMachineOps.ActionAsync<
    LabVirtualMachine,
    ApplyArtifactsRequest,
    OkResponse
  >;

  /**
   * Take ownership of an existing virtual machine This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_Claim")
  claim is LabVirtualMachineOps.ActionAsync<
    LabVirtualMachine,
    void,
    OkResponse
  >;

  /**
   * Detach the specified disk from the virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_DetachDataDisk")
  detachDataDisk is LabVirtualMachineOps.ActionAsync<
    LabVirtualMachine,
    DetachDataDiskProperties,
    OkResponse
  >;

  /**
   * Gets a string that represents the contents of the RDP file for the virtual machine
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_GetRdpFileContents")
  getRdpFileContents is LabVirtualMachineOps.ActionSync<
    LabVirtualMachine,
    void,
    ArmResponse<RdpConnection>
  >;

  /**
   * Lists the applicable start/stop schedules, if any.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_ListApplicableSchedules")
  listApplicableSchedules is LabVirtualMachineOps.ActionSync<
    LabVirtualMachine,
    void,
    ArmResponse<ApplicableSchedule>
  >;

  /**
   * Redeploy a virtual machine This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_Redeploy")
  redeploy is LabVirtualMachineOps.ActionAsync<
    LabVirtualMachine,
    void,
    OkResponse
  >;

  /**
   * Resize Virtual Machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_Resize")
  resize is LabVirtualMachineOps.ActionAsync<
    LabVirtualMachine,
    ResizeLabVirtualMachineProperties,
    OkResponse
  >;

  /**
   * Restart a virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_Restart")
  restart is LabVirtualMachineOps.ActionAsync<
    LabVirtualMachine,
    void,
    OkResponse
  >;

  /**
   * Start a virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_Start")
  start is LabVirtualMachineOps.ActionAsync<
    LabVirtualMachine,
    void,
    OkResponse
  >;

  /**
   * Stop a virtual machine This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_Stop")
  stop is LabVirtualMachineOps.ActionAsync<LabVirtualMachine, void, OkResponse>;

  /**
   * Transfers all data disks attached to the virtual machine to be owned by the current user. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_TransferDisks")
  transferDisks is LabVirtualMachineOps.ActionAsync<
    LabVirtualMachine,
    void,
    OkResponse
  >;

  /**
   * Release ownership of an existing virtual machine This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_UnClaim")
  unClaim is LabVirtualMachineOps.ActionAsync<
    LabVirtualMachine,
    void,
    OkResponse
  >;
}

@@doc(LabVirtualMachine.name, "The name of the virtual machine.");
@@doc(LabVirtualMachine.properties, "The properties of the resource.");
@@doc(LabVirtualMachines.createOrUpdate::parameters.resource,
  "A virtual machine."
);
@@doc(LabVirtualMachines.update::parameters.properties, "A virtual machine.");
@@doc(LabVirtualMachines.addDataDisk::parameters.body,
  "Request body for adding a new or existing data disk to a virtual machine."
);
@@doc(LabVirtualMachines.applyArtifacts::parameters.body,
  "Request body for applying artifacts to a virtual machine."
);
@@doc(LabVirtualMachines.detachDataDisk::parameters.body,
  "Request body for detaching data disk from a virtual machine."
);
@@doc(LabVirtualMachines.resize::parameters.body,
  "Request body for resizing a virtual machine."
);
