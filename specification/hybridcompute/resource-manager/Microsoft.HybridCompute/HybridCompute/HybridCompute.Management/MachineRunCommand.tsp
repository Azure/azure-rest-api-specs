import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Machine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
/**
 * Describes a Run Command
 */
@parentResource(Machine)
model MachineRunCommand
  is Azure.ResourceManager.TrackedResource<MachineRunCommandProperties> {
  ...ResourceNameParameter<
    Resource = MachineRunCommand,
    KeyName = "runCommandName",
    SegmentName = "runCommands",
    NamePattern = "[a-zA-Z0-9-_\\.]+"
  >;
}

@armResourceOperations
interface MachineRunCommands {
  /**
   * The operation to get a run command.
   */
  get is ArmResourceRead<MachineRunCommand>;

  /**
   * The operation to create or update a run command.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MachineRunCommand>;

  /**
   * The operation to delete a run command.
   */
  delete is ArmResourceDeleteWithoutOkAsync<MachineRunCommand>;

  /**
   * The operation to get all the run commands of a non-Azure machine.
   */
  list is ArmResourceListByParent<
    MachineRunCommand,
    Parameters = {
      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@doc(MachineRunCommand.name, "The name of the run command.");
@@doc(MachineRunCommand.properties, "Describes Run Command Properties");
@@doc(MachineRunCommands.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Run Command."
);
