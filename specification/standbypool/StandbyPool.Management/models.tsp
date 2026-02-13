// -----------------------------------------------------------------------
// <copyright file="models.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.StandbyPool;

@added(Microsoft.StandbyPool.Versions.`2025-10-01`)
@doc("Specifies the dynamic sizing configuration.")
model DynamicSizing {
  @doc("Indicates whether dynamic sizing is enabled for the standby pool.")
  enabled?: boolean;
}

@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
@removed(Microsoft.StandbyPool.Versions.`2025-03-01`)
@doc("Displays the counts of pooled resources in each state, as known by the StandbyPool resource provider.")
model PoolResourceStateCount {
  @doc("The state that the pooled resources count is for.")
  state: string;

  @doc("The count of pooled resources in the given state.")
  count: int64;
}

@added(Microsoft.StandbyPool.Versions.`2025-03-01`)
@doc("Displays StandbyPool status.")
model PoolStatus {
  @doc("Displays the healthy state of the StandbyPool.")
  @visibility(Lifecycle.Read)
  code: HealthStateCode;

  @doc("Displays the StandbyPool health state details.")
  @visibility(Lifecycle.Read)
  message?: string;
}

@added(Microsoft.StandbyPool.Versions.`2025-03-01`)
@doc("StandbyPool health state.")
union HealthStateCode {
  string,

  @doc("StandbyPool is in healthy state.")
  healthy: "HealthState/healthy",

  @doc("StandbyPool is in degraded state.")
  degraded: "HealthState/degraded",
}
