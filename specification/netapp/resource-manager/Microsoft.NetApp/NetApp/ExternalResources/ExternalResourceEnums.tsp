import "@typespec/versioning";

using Versioning;

namespace Microsoft.NetApp;

/**
 * SVM peer relationship type enum
 */
@added(Versions.v2026_08_15_preview)
union SvmPeerType {
  string,

  /**
   * Replication peer
   */
  Replication: "Replication",

  /**
   * Cache peer
   */
  Cache: "Cache",
}

/**
 * Cluster Peer status enum
 */
@added(Versions.v2026_08_15_preview)
union ClusterPeerStatus {
  string,

  /**
   * Active peering
   */
  Active: "Active",

  /**
   * Error state, an error occurred during peering, the error details can be seen by running this command on the external ONTAP cluster for more details (command: cluster peer show)
   */
  Error: "Error",

  /**
   * Pending state, the peering needs to be accepted on your cluster
   */
  Pending: "Pending",
}

/**
 * SVM Peer status enum
 */
@added(Versions.v2026_08_15_preview)
union SvmPeerStatus {
  string,

  /**
   * Active peering
   */
  Active: "Active",

  /**
   * Error state, use command on your cluster for more details(command: vserver peer show)
   */
  Error: "Error",

  /**
   * Pending state, the peering needs to be accepted on your SVM (command: vserver peer accept)
   */
  Pending: "Pending",
}

/**
 * Provides a machine-readable value for the status of the external connection setup.
 */
@added(Versions.v2026_08_15_preview)
union ExternalConnectionSetupState {
  string,

  /**
   * The peering needs to be accepted on your cluster before the setup can proceed. see the command in 'SetupInformation.command' property
   */
  ClusterPeerPending: "ClusterPeerPending",

  /**
   * Need to accept the returned 'vserver peer accept' command on your cluster to finish SVM peering. See the command in 'SetupInformation.command' property
   */
  VServerPeerRequired: "VServerPeerRequired",

  /**
   * External cache connection setup is complete.
   */
  NoActionRequired: "NoActionRequired",
}

/**
 * Setup Information for External Connection Setups
 */
@added(Versions.v2026_08_15_preview)
model SetupInformation {
  /**
   * Setup status indicating the current step in the setup process
   */
  @visibility(Lifecycle.Read)
  setupStatus?: ExternalConnectionSetupState;

  /**
   * Additional status information
   */
  @visibility(Lifecycle.Read)
  statusInformation?: string;

  /**
   * Command to execute
   */
  @visibility(Lifecycle.Read)
  command?: string;
}

/**
 * Represents the status of an external cache connection
 */
@added(Versions.v2026_08_15_preview)
union ExternalCacheConnectionStatus {
  string,

  /**
   * The cache connection is pending
   */
  Pending: "Pending",

  /**
   * The cache is connected
   */
  Connected: "Connected",

  /**
   * The cache is disconnected
   */
  Disconnected: "Disconnected",

  /**
   * The cache status is unknown. This is a transient state and should change to either connected or disconnected.
   */
  Unknown: "Unknown",

  /**
   * The cache was discovered on-premises but has no corresponding ExternalCacheConnection resource
   */
  Unsupported: "Unsupported",
}

/**
 * State of a remote cache volume on an external ONTAP system
 */
@added(Versions.v2026_08_15_preview)
union ExternalCacheState {
  string,

  /**
   * The remote cache volume is in an error state
   */
  Error: "error",

  /**
   * The remote cache volume is in a mixed state
   */
  Mixed: "mixed",

  /**
   * The remote cache volume is offline
   */
  Offline: "offline",

  /**
   * The remote cache volume is online
   */
  Online: "online",

  /**
   * The remote cache volume is in a pending state
   */
  Pending: "pending",

  /**
   * The remote cache volume is in an unsupported state
   */
  Unsupported: "unsupported",
}
