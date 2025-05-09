// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";
import "./cost-estimates.tsp";
import "./models.tsp";

using TypeSpec.Rest;

namespace Quantum.Workspace;

/** Provider availability. */
union ProviderAvailability {
  string,

  /** Provider is available. */
  Available: "Available",

  /** Provider is available with degraded experience. */
  Degraded: "Degraded",

  /** Provider is unavailable. */
  Unavailable: "Unavailable",
}

/** Target availability. */
union TargetAvailability {
  string,

  /** Target is available. */
  Available: "Available",

  /** Target is available with degraded experience. */
  Degraded: "Degraded",

  /** Target is unavailable. */
  Unavailable: "Unavailable",
}

/** Provider status. */
@resource("providerStatus")
@parentResource(Quantum.Workspace.QuantumWorkspace)
model ProviderStatus {
  /** Provider id. */
  @visibility(Lifecycle.Read)
  @key
  id: string;

  /** Current provider availability. */
  @visibility(Lifecycle.Read)
  currentAvailability: ProviderAvailability;

  /** Current target statuses. */
  @visibility(Lifecycle.Read)
  targets: TargetStatus[];
}

/** Target status. */
model TargetStatus {
  /** Target id. */
  @visibility(Lifecycle.Read)
  id: string;

  /** Current target availability. */
  @visibility(Lifecycle.Read)
  currentAvailability: TargetAvailability;

  /** Average queue time in seconds. */
  @visibility(Lifecycle.Read)
  averageQueueTime: int64;

  /** A page with detailed status of the provider. */
  @visibility(Lifecycle.Read)
  statusPage?: string;
}
