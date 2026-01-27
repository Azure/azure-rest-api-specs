import "@typespec/http";
import "./sap-common-models.tsp";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

/**
 * Defines the database instance configuration for SAP Database Server.
 */
@added(Versions.v2026_02_01_preview)
model SapDatabaseInstanceConfiguration {
  /**
   * The name of the database.
   */
  databaseName?: string;

  /**
   * The port of the database.
   */
  databasePort?: int32;
}

/**
 * Defines the HANA database specific properties.
 */
@added(Versions.v2026_02_01_preview)
model HanaDbProperties {
  /**
   * The SAP HANA instance number. Must be a two-digit number from 00 to 99.
   */
  @pattern("^[0-9]{2}$")
  instanceNumber?: string;

  /**
   * The database architecture (e.g., Scale-Out, Scale-Up).
   */
  architecture?: string;

  /**
   * The list of HANA database instances.
   */
  @Azure.ResourceManager.identifiers(#[])
  databases?: SapDatabaseInstanceConfiguration[];
}

/**
 * Defines the SAP Database Server default component profile.
 */
@added(Versions.v2026_02_01_preview)
model SapDatabaseServerDefaultComponentProfile extends ComponentProfile {
  /**
   * The component profile type.
   */
  profileType: ComponentProfileType.SAP_DatabaseServer_Default;

  /**
   * The hostname of the database server.
   */
  hostname?: string;

  /**
   * The IP address of the database server.
   */
  ipAddress?: string;

  /**
   * The database version.
   */
  version?: string;

  /**
   * The HANA database specific properties.
   */
  hanaDbProperties?: HanaDbProperties;

  /**
   * The high availability configuration.
   */
  highAvailability?: SapHighAvailabilityConfiguration;
}
