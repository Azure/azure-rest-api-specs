// -----------------------------------------------------------------------
// <copyright file="standbyContainerGroupPoolRuntimeView.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./service.tsp";
import "./standbyContainerGroupPool.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.StandbyPool;

@doc("Contains information about a standby container group pool as last known by the StandbyPool resource provider.")
@parentResource(StandbyContainerGroupPoolResource)
@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
model StandbyContainerGroupPoolRuntimeViewResource
  is ProxyResource<StandbyContainerGroupPoolRuntimeViewResourceProperties> {
  @pattern("^[a-zA-Z0-9-]{0,24}$")
  @key("runtimeView")
  @segment("runtimeViews")
  @visibility(Lifecycle.Read)
  @doc("The unique identifier for the runtime view. The input string should be the word 'latest', which will get the latest runtime view of the pool, otherwise the request will fail with NotFound exception.")
  @path
  name: string;
}

@doc("Contains information about a standby pool as last known by the StandbyPool resource provider.")
@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
model StandbyContainerGroupPoolRuntimeViewResourceProperties {
  @doc("A list containing the counts of container groups in each possible state, as known by the StandbyPool resource provider.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  instanceCountSummary: ContainerGroupInstanceCountSummary[];

  @added(Microsoft.StandbyPool.Versions.`2025-03-01`)
  @doc("Display status of the standby pool")
  @visibility(Lifecycle.Read)
  status?: PoolStatus;

  @doc("Displays the provisioning state of the standby pool")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @added(Microsoft.StandbyPool.Versions.`2025-03-01`)
  @doc("Displays prediction information of the standby pool")
  @visibility(Lifecycle.Read)
  prediction?: StandbyContainerGroupPoolPrediction;
}

@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
@doc("Displays the counts of container groups in each state, as known by the StandbyPool resource provider.")
model ContainerGroupInstanceCountSummary {
  @added(Microsoft.StandbyPool.Versions.`2025-03-01`)
  @doc("The zone that the provided counts are in. It will not have a value if zones are not enabled.")
  zone?: int64;

  @doc("The count of pooled resources in each state.")
  @extension("x-ms-identifiers", #["state"])
  @removed(Microsoft.StandbyPool.Versions.`2025-03-01`)
  @renamedFrom(
    Microsoft.StandbyPool.Versions.`2025-03-01`,
    "instanceCountsByState"
  )
  oldinstanceCountsByState: PoolResourceStateCount[];

  @doc("The count of pooled container groups in each state for the given zone.")
  @extension("x-ms-identifiers", #["state"])
  @added(Microsoft.StandbyPool.Versions.`2025-03-01`)
  instanceCountsByState: PoolContainerGroupStateCount[];
}

@added(Microsoft.StandbyPool.Versions.`2025-03-01`)
@doc("The state of the pooled container groups.")
union PoolContainerGroupState {
  @doc("The container group is up and running.")
  Running: "Running",

  @doc("The container group is creating.")
  Creating: "Creating",

  @doc("The container group is deleting.")
  Deleting: "Deleting",

  string,
}

@added(Microsoft.StandbyPool.Versions.`2025-03-01`)
@doc("Displays the counts of pooled container groups in each state, as known by the StandbyPool resource provider.")
model PoolContainerGroupStateCount {
  @doc("The state that the pooled container groups count is for.")
  state: PoolContainerGroupState;

  @doc("The count of pooled container groups in the given state.")
  count: int64;
}

@added(Microsoft.StandbyPool.Versions.`2025-03-01`)
@doc("Displays prediction information of the standby pool.")
model StandbyContainerGroupPoolPrediction {
  @doc("Displays the forecast information of the standby pool.")
  @visibility(Lifecycle.Read)
  forecastValues: StandbyContainerGroupPoolForecastValues;

  @doc("Displays the UTC timestamp of when the prediction was retrieved for the standby pool.")
  @visibility(Lifecycle.Read)
  forecastStartTime: utcDateTime;

  @doc("Displays additional information for the prediction of the standby pool.")
  @visibility(Lifecycle.Read)
  forecastInfo: string;
}

@added(Microsoft.StandbyPool.Versions.`2025-03-01`)
@doc("Displays the forecast information of the standby pool.")
model StandbyContainerGroupPoolForecastValues {
  @doc("Displays the predicted count of instances to be requested from the standby pool.")
  @visibility(Lifecycle.Read)
  instancesRequestedCount: int64[];
}

@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
@armResourceOperations
interface StandbyContainerGroupPoolRuntimeViews {
  get is ArmResourceRead<StandbyContainerGroupPoolRuntimeViewResource>;
  listByStandbyPool is ArmResourceListByParent<StandbyContainerGroupPoolRuntimeViewResource>;
}
