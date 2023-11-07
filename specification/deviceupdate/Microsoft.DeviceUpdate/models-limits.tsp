import "./models-shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.IoT.DeviceUpdate;

/**
 * The list of limits of how many of each resource are currently in use and how
 * many are allowed.
 */
model Limits {
  /**
   * The list of current counts of each limited resource and the maximum quota that are allowed.
   */
  counters: Counters;
}

/**
 * The list of counts of each limited resource with both current usage and overall quota.
 */
model Counters {
  /** The current usage and quota of devices. */
  deviceCount: UsageQuotaCounter;

  /** The current usage and quota of device classes. */
  deviceClassCount: UsageQuotaCounter;

  /** The current usage and quota of device groups. */
  deviceGroupCount: UsageQuotaCounter;

  /** The current usage and quota of active deployments. */
  activeDeploymentCount: UsageQuotaCounter;

  /** The current usage and quota of deployments. */
  deploymentCount: UsageQuotaCounter;
}

/** A counter with both usage and quota information. */
model UsageQuotaCounter {
  /** The current number of the resource that exist */
  usage: int32;

  /** The maximum number of the resource that can be created */
  quota: int32;
}
