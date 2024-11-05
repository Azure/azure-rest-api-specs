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

  @doc("Displays the provisioning state of the standby pool")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
@doc("Displays the counts of container groups in each state, as known by the StandbyPool resource provider.")
model ContainerGroupInstanceCountSummary {
  @doc("The count of pooled resources in each state.")
  @extension("x-ms-identifiers", ["state"])
  instanceCountsByState: PoolResourceStateCount[];
}

@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
@armResourceOperations
interface StandbyContainerGroupPoolRuntimeViews {
  get is ArmResourceRead<StandbyContainerGroupPoolRuntimeViewResource>;
  listByStandbyPool is ArmResourceListByParent<StandbyContainerGroupPoolRuntimeViewResource>;
}
