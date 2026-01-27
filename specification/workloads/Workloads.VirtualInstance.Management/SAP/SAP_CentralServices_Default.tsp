import "@typespec/http";
import "./sap-common-models.tsp";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

/**
 * Defines the message server configuration for SAP Central Services.
 */
@added(Versions.v2026_02_01_preview)
model SapMessageServerConfiguration {
  /**
   * The message server port.
   */
  msPort?: int32;

  /**
   * The internal port for the message server.
   */
  internalPort?: int32;

  /**
   * The HTTP port for the message server.
   */
  httpPort?: int32;

  /**
   * The HTTPS port for the message server.
   */
  httpsPort?: int32;
}

/**
 * Defines the enqueue server configuration for SAP Central Services.
 */
@added(Versions.v2026_02_01_preview)
model SapEnqueueServerConfiguration {
  /**
   * The enqueue server port.
   */
  esPort?: int32;
}

/**
 * Defines the SAP Central Services default component profile.
 */
@added(Versions.v2026_02_01_preview)
model SapCentralServicesDefaultComponentProfile extends ComponentProfile {
  /**
   * The component profile type.
   */
  profileType: ComponentProfileType.SAP_CentralServices_Default;

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
   * The high availability configuration.
   */
  highAvailability?: SapHighAvailabilityConfiguration;

  /**
   * The message server configuration.
   */
  messageServer?: SapMessageServerConfiguration;

  /**
   * The enqueue server configuration.
   */
  enqueueServer?: SapEnqueueServerConfiguration;

  /**
   * The gateway configuration.
   */
  gateway?: SapGatewayConfiguration;
}
