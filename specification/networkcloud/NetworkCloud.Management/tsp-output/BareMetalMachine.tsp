import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
@doc("BareMetalMachine represents the physical machine in the rack.")
model BareMetalMachine is TrackedResource<BareMetalMachineProperties> {
  @doc("The name of the bare metal machine.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
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
    BareMetalMachinePatchParameters
  >;

  @doc("Get a list of bare metal machines in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<BareMetalMachine>;

  @doc("Get a list of bare metal machines in the provided subscription.")
  listBySubscription is ArmListBySubscription<BareMetalMachine>;

  @doc("Cordon the provided bare metal machine's Kubernetes node.")
  cordon is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    BareMetalMachineCordonParameters
  >;

  @doc("Power off the provided bare metal machine.")
  powerOff is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    BareMetalMachinePowerOffParameters
  >;

  @doc("Reimage the provided bare metal machine.")
  reimage is ArmResourceActionNoResponseContentAsync<BareMetalMachine, void>;

  @doc("Replace the provided bare metal machine.")
  replace is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    BareMetalMachineReplaceParameters
  >;

  @doc("Restart the provided bare metal machine.")
  restart is ArmResourceActionNoResponseContentAsync<BareMetalMachine, void>;

  @doc("Run the command or the script on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.")
  runCommand is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    BareMetalMachineRunCommandParameters
  >;

  @doc("Run one or more data extractions on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.")
  runDataExtracts is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    BareMetalMachineRunDataExtractsParameters
  >;

  @doc("Run one or more read-only commands on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.")
  runReadCommands is ArmResourceActionNoResponseContentAsync<
    BareMetalMachine,
    BareMetalMachineRunReadCommandsParameters
  >;

  @doc("Start the provided bare metal machine.")
  start is ArmResourceActionNoResponseContentAsync<BareMetalMachine, void>;

  @doc("Uncordon the provided bare metal machine's Kubernetes node.")
  uncordon is ArmResourceActionNoResponseContentAsync<BareMetalMachine, void>;
}
