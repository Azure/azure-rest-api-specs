import "@typespec/http";
import "../models.tsp";

using TypeSpec.Versioning;

namespace Microsoft.Workloads;

/**
 * Defines the type of discovery configuration.
 */
@added(Versions.v2026_02_01_preview)
union SAPDiscoveryConfigurationType {
  string,

  DiscoveryConfigurationType,

  /** SAP API discovery type for discovering SAP systems via sapcontrol API calls. */
  SAPAPI: "SAPAPI",
}

/**
 * Defines the SAP API discovery configuration for discovering SAP systems via API calls.
 */
@added(Versions.v2026_02_01_preview)
model SapApiDiscoveryConfiguration extends DiscoveryConfiguration<SAPDiscoveryConfigurationType> {
  /**
   * The discovery type.
   */
  discoveryType: SAPDiscoveryConfigurationType.SAPAPI;

  /**
   * The Azure resource ID of the virtual machine to use for SAP API discovery.
   * Only application server or central server Vm Resource Id supported as input.
   */
  vmResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    }
  ]>;
}

/**
 * Defines the update configuration for SAP API discovery.
 */
@added(Versions.v2026_02_01_preview)
model UpdateSapApiDiscoveryConfiguration extends UpdateDiscoveryConfiguration<SAPDiscoveryConfigurationType> {
  /**
   * The discovery type.
   */
  discoveryType: SAPDiscoveryConfigurationType.SAPAPI;

  /**
   * The Azure resource ID of the virtual machine to use for SAP API discovery.
   * Only application server or central server Vm Resource Id supported as input.
   */
  vmResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    }
  ]>;
}
