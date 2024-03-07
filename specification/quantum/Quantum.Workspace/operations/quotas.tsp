// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

@doc("The scope at which the quota is applied to.")
enum DimensionScope {
  @doc("The quota is applied to the Quantum Workspace.")
  Workspace,

  @doc("The quota is applied to the Azure Subscription.")
  Subscription,
}

@doc("The time period in which the quota's underlying meter is accumulated. Based on calendar year. 'None' is used for concurrent quotas.")
enum MeterPeriod {
  @doc("The meter period is instantaneous. Used for concurrent quotas.")
  None,

  @doc("The meter period is per month.")
  Monthly,
}

@doc("Quota information.")
@resource("quotas")
@parentResource(QuantumWorkspace)
model Quota {
  @key
  @visibility("read")
  // A faux key is needed to tag the Quota as a resource.
  @doc("Quota faux key.")
  key: never;

  @visibility("read")
  @doc("The name of the dimension associated with the quota.")
  dimension: string;

  @visibility("read")
  @doc("The scope at which the quota is applied.")
  scope: DimensionScope;

  @visibility("read")
  @doc("The unique identifier for the provider.")
  providerId: string;

  @visibility("read")
  @doc("The amount of the usage that has been applied for the current period.")
  utilization: float32;

  @visibility("read")
  @doc("The amount of the usage that has been reserved but not applied for the current period.")
  holds: float32;

  @visibility("read")
  @doc("The maximum amount of usage allowed for the current period.")
  limit: float32;

  @visibility("read")
  @doc("The time period in which the quota's underlying meter is accumulated. Based on calendar year. 'None' is used for concurrent quotas.")
  period: MeterPeriod;
}

@useDependency(DefaultAzureCoreVersion)
namespace Quantum.Workspace.Operations {
  using Quantum.Workspace.BaseOperations;
  interface QuotaOperations {
    @doc("List quotas for the given workspace.")
    list is ListOperation<Quota>;
  }
}
