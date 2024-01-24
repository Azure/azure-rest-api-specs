import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Machine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
/**
 * Describes a Run Command
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Machine)
@Azure.ResourceManager.Private.armResourceInternal(MachineRunCommandProperties)
@includeInapplicableMetadataInPayload(false)
model MachineRunCommand extends TrackedResourceBase {
  /**
   * The name of the run command.
   */
  @pattern("[a-zA-Z0-9-_\\.]+")
  @path
  @key("runCommandName")
  @segment("runCommands")
  name: string;

  /**
   * Describes Run Command Properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: MachineRunCommandProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    MachineRunCommand,
    BaseParameters<MachineRunCommand>,
    ArmAsyncOperationHeader
  >;

  /**
   * The operation to delete a run command.
   */
  delete is ArmResourceDeleteAsync<
    MachineRunCommand,
    BaseParameters<MachineRunCommand>,
    ArmLroLocationHeader
  >;

  /**
   * The operation to get all the run commands of a non-Azure machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MachineRunCommands_List")
  list is ArmResourceListByParent<
    MachineRunCommand,
    {
      ...BaseParameters<MachineRunCommand>;

      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@projectedName(MachineRunCommands.createOrUpdate::parameters.resource,
  "json",
  "runCommandProperties"
);
@@extension(MachineRunCommands.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "runCommandProperties"
);
@@doc(MachineRunCommands.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Run Command."
);
