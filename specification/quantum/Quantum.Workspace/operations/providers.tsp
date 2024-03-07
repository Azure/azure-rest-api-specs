// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

@doc("Provider availability.")
enum ProviderAvailability {
  @doc("Provider is available.")
  Available,

  @doc("Provider is available with degraded experience.")
  Degraded,

  @doc("Provider is unavailable.")
  Unavailable,
}

@doc("Target availability.")
enum TargetAvailability {
  @doc("Target is available.")
  Available,

  @doc("Target is available with degraded experience.")
  Degraded,

  @doc("Target is unavailable.")
  Unavailable,
}

@doc("Provider status.")
@resource("providerStatus")
@parentResource(QuantumWorkspace)
model ProviderStatus {
  @visibility("read")
  @doc("Provider id.")
  @key
  id: string;

  @visibility("read")
  @doc("Current provider availability.")
  currentAvailability: ProviderAvailability;

  @visibility("read")
  @doc("Current target statuses.")
  targets: TargetStatus[];
}

@doc("Target status.")
model TargetStatus {
  @visibility("read")
  @doc("Target id.")
  id: string;

  @visibility("read")
  @doc("Current target availability.")
  currentAvailability: TargetAvailability;

  @visibility("read")
  @doc("Average queue time in seconds.")
  averageQueueTime: int64;

  @visibility("read")
  @doc("A page with detailed status of the provider.")
  statusPage?: string;
}

@useDependency(DefaultAzureCoreVersion)
namespace Quantum.Workspace.Operations {
  using Quantum.Workspace.BaseOperations;
  interface ProviderOperations {
    @doc("List all providers in the workspace with their respective status.")
    list is ListOperation<ProviderStatus>;
  }
}
