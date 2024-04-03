// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

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
@parentResource(QuantumWorkspace)
model ProviderStatus {
  /** Provider id. */
  @visibility("read")
  @key
  id: string;

  /** Current provider availability. */
  @visibility("read")
  currentAvailability: ProviderAvailability;

  /** Current target statuses. */
  @visibility("read")
  targets: TargetStatus[];
}

/** Target status. */
model TargetStatus {
  /** Target id. */
  @visibility("read")
  id: string;

  /** Current target availability. */
  @visibility("read")
  currentAvailability: TargetAvailability;

  /** Average queue time in seconds. */
  @visibility("read")
  averageQueueTime: int64;

  /** A page with detailed status of the provider. */
  @visibility("read")
  statusPage?: string;
}

@useDependency(DefaultAzureCoreVersion)
namespace Quantum.Workspace.Operations {
  using Quantum.Workspace.BaseOperations;
  interface ProviderOperations {
    /** List all providers in the workspace with their respective status. */
    list is ListOperation<ProviderStatus>;
  }
}
