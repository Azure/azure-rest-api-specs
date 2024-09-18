import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ScVmm;
/** Define the virtualMachineInstance. */
@singleton
model VirtualMachineInstance
  is ExtensionResource<VirtualMachineInstanceProperties> {
  /** Name of the virtual machine instance. */
  @key
  @segment("virtualMachineInstances")
  @visibility("read")
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  name: string;

  /** Gets or sets the extended location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is allowed but not recognized by the linter"
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

/** The type used for update operations of the VirtualMachineInstance. */
model VirtualMachineInstanceUpdate
  is UpdateableProperties<OmitProperties<
    VirtualMachineInstance,
    "properties"
  >> {
  /** The update properties of the VirtualMachineInstance. */
  #suppress "deprecated" "Legacy flatten"
  @Azure.ClientGenerator.Core.flattenProperty
  properties?: VirtualMachineInstanceUpdateProperties;
}

/** Delete From Host */
union DeleteFromHost {
  /** Enable delete from host. */
  `true`: "true",

  /** Disable delete from host. */
  `false`: "false",

  string,
}

@armResourceOperations
interface VirtualMachineInstances {
  /** Retrieves information about a virtual machine instance. */
  @summary("Gets a virtual machine.")
  get is ArmResourceRead<VirtualMachineInstance>;
  /** The operation to create or update a virtual machine instance. Please note some properties can be set only during virtual machine instance creation. */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @summary("Implements virtual machine PUT method.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VirtualMachineInstance,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  /** The operation to update a virtual machine instance. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @summary("Updates a virtual machine.")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  update is ArmCustomPatchAsync<
    VirtualMachineInstance,
    VirtualMachineInstanceUpdate
  >;
  /** The operation to delete a virtual machine instance. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @summary("Deletes an virtual machine.")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachineInstance,
    {
      ...Foundations.BaseParameters<VirtualMachineInstance>;
      ...QueryForceDelete;

      /** Whether to disable the VM from azure and also delete it from Vmm. */
      @query("deleteFromHost")
      deleteFromHost?: DeleteFromHost;
    }
  >;
  /** Lists all of the virtual machine instances within the specified parent resource. */
  @summary("Implements List virtual machine instances.")
  list is ArmResourceListByParent<VirtualMachineInstance>;
  /** The operation to power off (stop) a virtual machine instance. */
  @summary("Implements the operation to stop a virtual machine.")
  stop is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    StopVirtualMachineOptions
  >;
  /** The operation to start a virtual machine instance. */
  @summary("Implements the operation to start a virtual machine.")
  start is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    void
  >;
  /** The operation to restart a virtual machine instance. */
  @summary("Implements the operation to restart a virtual machine.")
  restart is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    void
  >;
  /** Creates a checkpoint in virtual machine instance. */
  @summary("Implements the operation to creates a checkpoint in a virtual machine instance.")
  createCheckpoint is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    VirtualMachineCreateCheckpoint
  >;
  /** Deletes a checkpoint in virtual machine instance. */
  @summary("Implements the operation to delete a checkpoint in a virtual machine instance.")
  deleteCheckpoint is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    VirtualMachineDeleteCheckpoint
  >;
  /** Restores to a checkpoint in virtual machine instance. */
  @summary("Implements the operation to restores to a checkpoint in a virtual machine instance.")
  restoreCheckpoint is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    VirtualMachineRestoreCheckpoint
  >;
}
