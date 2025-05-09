// -----------------------------------------------------------------------
// <copyright file="service.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

@armProviderNamespace("Microsoft.StandbyPool")
@service(#{ title: "Microsoft.StandbyPool" })
@versioned(Microsoft.StandbyPool.Versions)
namespace Microsoft.StandbyPool;

@doc("Supported API Versions for Microsoft.StandbyPool")
enum Versions {
  @doc("API Version 2023-12-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2023-12-01-preview`,

  @doc("API Version 2024-03-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-03-01-preview`,

  @doc("API Version 2024-03-01.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-03-01`,

  @doc("API Version 2025-03-01.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2025-03-01`,
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning state")
@lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is being deleted.")
  Deleting: "Deleting",
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
