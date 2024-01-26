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
 * BareMetalMachine represents the physical machine in the rack.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(BareMetalMachineProperties)
model BareMetalMachine extends TrackedResourceBase {
  /**
   * The name of the bare metal machine.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
  @path
  @key("bareMetalMachineName")
  @segment("bareMetalMachines")
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
  properties: BareMetalMachineProperties;
}

@armResourceOperations
interface BareMetalMachines {
  /**
   * Get properties of the provided bare metal machine.
   */
  get is ArmResourceRead<BareMetalMachine>;

  /**
   * Patch properties of the provided bare metal machine, or update tags associated with the bare metal machine. Properties and tag updates can be done independently.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    BareMetalMachine,
    BareMetalMachinePatchParameters,
    BaseParameters<BareMetalMachine>,
    ArmAsyncOperationHeader
  >;

  /**
   * Get a list of bare metal machines in the provided resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BareMetalMachines_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<BareMetalMachine>;

  /**
   * Get a list of bare metal machines in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<BareMetalMachine>;

  /**
   * Cordon the provided bare metal machine's Kubernetes node.
   */
  cordon is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachineCordonParameters,
    OperationStatusResult,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Power off the provided bare metal machine.
   */
  powerOff is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachinePowerOffParameters,
    OperationStatusResult,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Reimage the provided bare metal machine.
   */
  reimage is ArmResourceActionAsync<
    BareMetalMachine,
    void,
    OperationStatusResult,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Replace the provided bare metal machine.
   */
  replace is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachineReplaceParameters,
    OperationStatusResult,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Restart the provided bare metal machine.
   */
  restart is ArmResourceActionAsync<
    BareMetalMachine,
    void,
    OperationStatusResult,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Run the command or the script on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runCommand is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachineRunCommandParameters,
    OperationStatusResult,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Run one or more data extractions on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runDataExtracts is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachineRunDataExtractsParameters,
    OperationStatusResult,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Run one or more read-only commands on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runReadCommands is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachineRunReadCommandsParameters,
    OperationStatusResult,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Start the provided bare metal machine.
   */
  start is ArmResourceActionAsync<
    BareMetalMachine,
    void,
    OperationStatusResult,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Uncordon the provided bare metal machine's Kubernetes node.
   */
  uncordon is ArmResourceActionAsync<
    BareMetalMachine,
    void,
    OperationStatusResult,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;
}

@@projectedName(BareMetalMachines.update::parameters.properties,
  "json",
  "bareMetalMachineUpdateParameters"
);
@@extension(BareMetalMachines.update::parameters.properties,
  "x-ms-client-name",
  "bareMetalMachineUpdateParameters"
);
@@doc(BareMetalMachines.update::parameters.properties, "The request body.");
@@projectedName(BareMetalMachines.cordon::parameters.body,
  "json",
  "bareMetalMachineCordonParameters"
);
@@extension(BareMetalMachines.cordon::parameters.body,
  "x-ms-client-name",
  "bareMetalMachineCordonParameters"
);
@@doc(BareMetalMachines.cordon::parameters.body, "The request body.");
@@projectedName(BareMetalMachines.powerOff::parameters.body,
  "json",
  "bareMetalMachinePowerOffParameters"
);
@@extension(BareMetalMachines.powerOff::parameters.body,
  "x-ms-client-name",
  "bareMetalMachinePowerOffParameters"
);
@@doc(BareMetalMachines.powerOff::parameters.body, "The request body.");
@@projectedName(BareMetalMachines.replace::parameters.body,
  "json",
  "bareMetalMachineReplaceParameters"
);
@@extension(BareMetalMachines.replace::parameters.body,
  "x-ms-client-name",
  "bareMetalMachineReplaceParameters"
);
@@doc(BareMetalMachines.replace::parameters.body, "The request body.");
@@projectedName(BareMetalMachines.runCommand::parameters.body,
  "json",
  "bareMetalMachineRunCommandParameters"
);
@@extension(BareMetalMachines.runCommand::parameters.body,
  "x-ms-client-name",
  "bareMetalMachineRunCommandParameters"
);
@@doc(BareMetalMachines.runCommand::parameters.body, "The request body.");
@@projectedName(BareMetalMachines.runDataExtracts::parameters.body,
  "json",
  "bareMetalMachineRunDataExtractsParameters"
);
@@extension(BareMetalMachines.runDataExtracts::parameters.body,
  "x-ms-client-name",
  "bareMetalMachineRunDataExtractsParameters"
);
@@doc(BareMetalMachines.runDataExtracts::parameters.body, "The request body.");
@@projectedName(BareMetalMachines.runReadCommands::parameters.body,
  "json",
  "bareMetalMachineRunReadCommandsParameters"
);
@@extension(BareMetalMachines.runReadCommands::parameters.body,
  "x-ms-client-name",
  "bareMetalMachineRunReadCommandsParameters"
);
@@doc(BareMetalMachines.runReadCommands::parameters.body, "The request body.");
