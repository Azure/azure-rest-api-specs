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
  @visibility("read")
  @doc("The unique identifier for the runtime view. The input string should be the word 'latest', which will get the latest runtime view of the pool, otherwise the request will fail with NotFound exception.")
  @path
  name: string;
}

@doc("Contains information about a standby pool as last known by the StandbyPool resource provider.")
@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
model StandbyContainerGroupPoolRuntimeViewResourceProperties {
  @doc("A list containing the counts of container groups in each possible state, as known by the StandbyPool resource provider.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  instanceCountSummary: ContainerGroupInstanceCountSummary[];

  @added(Microsoft.StandbyPool.Versions.`2024-08-01-preview`)
  @doc("Display status of the standby pool")
  @visibility("read")
  status?: PoolStatus;

  @doc("Displays the provisioning state of the standby pool")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
@doc("Displays the counts of container groups in each state, as known by the StandbyPool resource provider.")
model ContainerGroupInstanceCountSummary {
  @added(Microsoft.StandbyPool.Versions.`2024-08-01-preview`)
  @doc("The zone that the provided counts are in. This is null if zones are not enabled.")
  zone?: int64;

  @doc("The count of pooled resources in each state.")
  @extension("x-ms-identifiers", ["state"])
  @removed(Microsoft.StandbyPool.Versions.`2024-08-01-preview`)
  @renamedFrom(Microsoft.StandbyPool.Versions.`2024-08-01-preview`, "instanceCountsByState")
  oldinstanceCountsByState: PoolResourceStateCount[];

  @doc("The count of pooled resources in each state for the given zone.")
  @extension("x-ms-identifiers", ["state"])
  @added(Microsoft.StandbyPool.Versions.`2024-08-01-preview`)
  instanceCountsByState: PoolContainerGroupStateCount[];
}

@added(Microsoft.StandbyPool.Versions.`2024-08-01-preview`)
@doc("The state that the pooled resources.")
union PoolContainerGroupState {
  @doc("The resource is up and running.")
  Running: "Running",

  @doc("The resource is creating.")
  Creating: "Creating",

  @doc("The resource is Deleting.")
  Deleting: "Deleting",

  string,
}

@added(Microsoft.StandbyPool.Versions.`2024-08-01-preview`)
@doc("Displays the counts of pooled resources in each state, as known by the StandbyPool resource provider.")
model PoolContainerGroupStateCount {
  @doc("The state that the pooled resources count is for.")
  state: PoolContainerGroupState;

  @doc("The count of pooled resources in the given state.")
  count: int64;
}

@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
@armResourceOperations
interface StandbyContainerGroupPoolRuntimeViews {
  get is ArmResourceRead<StandbyContainerGroupPoolRuntimeViewResource>;
  listByStandbyContainerGroupPoolResource is ArmResourceListByParent<StandbyContainerGroupPoolRuntimeViewResource>;
}
