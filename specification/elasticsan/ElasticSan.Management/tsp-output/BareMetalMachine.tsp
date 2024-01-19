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
@doc("BareMetalMachine represents the physical machine in the rack.")
model BareMetalMachine is TrackedResource<BareMetalMachineProperties> {
  @doc("The name of the bare metal machine.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
  @path
  @key("bareMetalMachineName")
  @segment("bareMetalMachines")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface BareMetalMachines {
  @doc("Get properties of the provided bare metal machine.")
  get is ArmResourceRead<BareMetalMachine>;

  @doc("Patch properties of the provided bare metal machine, or update tags associated with the bare metal machine. Properties and tag updates can be done independently.")
  update is ArmCustomPatchAsync<
    BareMetalMachine,
    BareMetalMachinePatchParameters,
    BaseParameters<BareMetalMachine>,
    ArmAsyncOperationHeader
  >;

  @doc("Get a list of bare metal machines in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<BareMetalMachine>;

  @doc("Get a list of bare metal machines in the provided subscription.")
  listBySubscription is ArmListBySubscription<BareMetalMachine>;

  @doc("Cordon the provided bare metal machine's Kubernetes node.")
  cordon is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    BareMetalMachineCordonParameters,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  @doc("Power off the provided bare metal machine.")
  powerOff is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    BareMetalMachinePowerOffParameters,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  @doc("Reimage the provided bare metal machine.")
  reimage is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    void,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  @doc("Replace the provided bare metal machine.")
  replace is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    BareMetalMachineReplaceParameters,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  @doc("Restart the provided bare metal machine.")
  restart is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    void,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  @doc("Run the command or the script on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.")
  runCommand is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    BareMetalMachineRunCommandParameters,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  @doc("Run one or more data extractions on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.")
  runDataExtracts is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    BareMetalMachineRunDataExtractsParameters,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  @doc("Run one or more read-only commands on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.")
  runReadCommands is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    BareMetalMachineRunReadCommandsParameters,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  @doc("Start the provided bare metal machine.")
  start is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    void,
    BaseParameters<BareMetalMachine>,
    ArmLroLocationHeader
  >;

  @doc("Uncordon the provided bare metal machine's Kubernetes node.")
  uncordon is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    void,
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
