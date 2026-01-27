import "@typespec/http";
import "./sap-common-models.tsp";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

/**
 * Defines the dispatcher configuration for SAP Application Server.
 */
@added(Versions.v2026_02_01_preview)
model SapDispatcherConfiguration {
  /**
   * The dispatcher port.
   */
  dispPort?: int32;
}

/**
 * Defines the ICM (Internet Communication Manager) configuration for SAP Application Server.
 */
@added(Versions.v2026_02_01_preview)
model SapIcmConfiguration {
  /**
   * The HTTP port for ICM.
   */
  httpPort?: int32;

  /**
   * The HTTPS port for ICM.
   */
  httpsPort?: int32;

  /**
   * The SMTP port for ICM.
   */
  smtpPort?: int32;
}

/**
 * Defines the SAP Application Server default component profile.
 */
@added(Versions.v2026_02_01_preview)
model SapApplicationServerDefaultComponentProfile extends ComponentProfile {
  /**
   * The component profile type.
   */
  profileType: ComponentProfileType.SAP_ApplicationServer_Default;

  /**
   * The SAP instance number. Must be a two-digit number from 00 to 99.
   */
  @pattern("^[0-9]{2}$")
  instanceNumber?: string;

  /**
   * The SAP kernel version.
   */
  kernelVersion?: string;

  /**
   * The SAP kernel patch level.
   */
  kernelPatch?: string;

  /**
   * The hostname of the SAP instance.
   */
  hostname?: string;

  /**
   * The IP address of the SAP instance.
   */
  ipAddress?: string;

  /**
   * The dispatcher configuration.
   */
  dispatcher?: SapDispatcherConfiguration;

  /**
   * The gateway configuration.
   */
  gateway?: SapGatewayConfiguration;

  /**
   * The ICM (Internet Communication Manager) configuration.
   */
  icm?: SapIcmConfiguration;
}
