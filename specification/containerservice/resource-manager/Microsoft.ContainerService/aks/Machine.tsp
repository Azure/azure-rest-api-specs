import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AgentPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;
/**
 * A machine. Contains details about the underlying virtual machine. A machine may be visible here but not in kubectl get nodes; if so it may be because the machine has not been registered with the Kubernetes API Server yet.
 */
@parentResource(AgentPool)
model Machine is Azure.ResourceManager.ProxyResource<MachineProperties> {
  ...ResourceNameParameter<
    Resource = Machine,
    KeyName = "machineName",
    SegmentName = "machines",
    NamePattern = "^[a-z][a-z0-9]{0,11}$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,39}$"
  >;

  /**
   * The Availability zone in which machine is located.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  zones?: string[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface Machines {
  /**
   * Get a specific machine in the specified agent pool.
   */
  get is ArmResourceRead<Machine>;

  /**
   * Creates or updates a machine in the specified agent pool.
   */
  @added(Versions.v2025_10_02_preview)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Machine,
    Parameters = {
      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;

      /**
       * The request should only proceed if no entity matches this string.
       */
      @header
      ifNoneMatch?: string;
    }
  >;

  /**
   * Gets a list of machines in the specified agent pool.
   */
  list is ArmResourceListByParent<Machine>;
}

@@doc(Machine.name, "Host name of the machine.");
@@doc(Machine.properties, "The properties of the machine");
@@doc(Machines.createOrUpdate::parameters.resource,
  "The machine to create or update."
);
