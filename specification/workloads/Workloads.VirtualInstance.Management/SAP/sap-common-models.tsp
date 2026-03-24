import "@typespec/http";

using TypeSpec.Versioning;

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

/**
 * Defines the type of component profile.
 */
@added(Versions.v2026_02_01_preview)
union SAPComponentProfileType {
  string,
  
  ComponentProfileType,

  /** SAP Central Services component profile. */
  SAP_CentralServices_Default: "SAP-CentralServices-Default",

  /** SAP Application Server component profile. */
  SAP_ApplicationServer_Default: "SAP-ApplicationServer-Default",

  /** SAP Database Server component profile. */
  SAP_DatabaseServer_Default: "SAP-DatabaseServer-Default",
}