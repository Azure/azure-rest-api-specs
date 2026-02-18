import "@typespec/http";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

/**
 * Defines the high availability configuration for SAP components.
 */
@added(Versions.v2026_02_01_preview)
model SapHighAvailabilityConfiguration {
  /**
   * Indicates whether high availability is active.
   */
  isHaActive?: boolean;

  /**
   * The list of high availability node names.
   */
  haNodes?: string[];
}

/**
 * Defines the gateway configuration for SAP components.
 */
@added(Versions.v2026_02_01_preview)
model SapGatewayConfiguration {
  /**
   * The gateway port.
   */
  gwPort?: int32;
}
