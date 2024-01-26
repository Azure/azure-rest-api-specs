import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * VirtualMachine represents the on-premises Network Cloud virtual machine.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(VirtualMachineProperties)
model VirtualMachine extends TrackedResourceBase {
  /**
   * The name of the virtual machine.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
  @path
  @key("virtualMachineName")
  @segment("virtualMachines")
  @visibility("read")
  name: string;

  /**
   * The extended location of the cluster associated with the resource.
   */
  extendedLocation: ExtendedLocation;

  /**
   * The list of the resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: VirtualMachineProperties;
}

@armResourceOperations
interface VirtualMachines {
  /**
   * Get properties of the provided virtual machine.
   */
  get is ArmResourceRead<VirtualMachine>;

  /**
   * Create a new virtual machine or update the properties of the existing virtual machine.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualMachine,
    BaseParameters<VirtualMachine>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch the properties of the provided virtual machine, or update the tags associated with the virtual machine. Properties and tag updates can be done independently.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    VirtualMachine,
    VirtualMachinePatchParameters,
    BaseParameters<VirtualMachine>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete the provided virtual machine.
   */
  delete is ArmResourceDeleteAsync<
    VirtualMachine,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Get a list of virtual machines in the provided resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualMachines_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VirtualMachine>;

  /**
   * Get a list of virtual machines in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<VirtualMachine>;

  /**
   * Power off the provided virtual machine.
   */
  powerOff is ArmResourceActionAsync<
    VirtualMachine,
    VirtualMachinePowerOffParameters,
    OperationStatusResult,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Reimage the provided virtual machine.
   */
  reimage is ArmResourceActionAsync<
    VirtualMachine,
    void,
    OperationStatusResult,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Restart the provided virtual machine.
   */
  restart is ArmResourceActionAsync<
    VirtualMachine,
    void,
    OperationStatusResult,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Start the provided virtual machine.
   */
  start is ArmResourceActionAsync<
    VirtualMachine,
    void,
    OperationStatusResult,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;
}

@@projectedName(VirtualMachines.createOrUpdate::parameters.resource,
  "json",
  "virtualMachineParameters"
);
@@extension(VirtualMachines.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "virtualMachineParameters"
);
@@doc(VirtualMachines.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(VirtualMachines.update::parameters.properties,
  "json",
  "virtualMachineUpdateParameters"
);
@@extension(VirtualMachines.update::parameters.properties,
  "x-ms-client-name",
  "virtualMachineUpdateParameters"
);
@@doc(VirtualMachines.update::parameters.properties, "The request body.");
@@projectedName(VirtualMachines.powerOff::parameters.body,
  "json",
  "virtualMachinePowerOffParameters"
);
@@extension(VirtualMachines.powerOff::parameters.body,
  "x-ms-client-name",
  "virtualMachinePowerOffParameters"
);
@@doc(VirtualMachines.powerOff::parameters.body, "The request body.");
