import "@typespec/http";
import "../models.tsp";

using TypeSpec.Versioning;

namespace Microsoft.Workloads;

/**
 * Defines the SAP API discovery configuration for discovering SAP systems via API calls.
 */
@added(Versions.v2026_02_01_preview)
model SapApiDiscoveryConfiguration extends DiscoveryConfiguration {
  /**
   * The discovery type.
   */
  discoveryType: DiscoveryConfigurationType.SAPAPI;

  /**
   * The Azure resource ID of the virtual machine to use for SAP API discovery.
   * Required on create, optional on update.
   * Only application server or central server Vm Resource Id supported as input.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  vmResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    }
  ]>;
}
