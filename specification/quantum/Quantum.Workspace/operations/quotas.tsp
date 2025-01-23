// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

/** The scope at which the quota is applied to. */
union DimensionScope {
  string,

  /** The quota is applied to the Quantum Workspace. */
  Workspace: "Workspace",

  /** The quota is applied to the Azure Subscription. */
  Subscription: "Subscription",
}

/** The time period in which the quota's underlying meter is accumulated. Based on calendar year. 'None' is used for concurrent quotas. */
union MeterPeriod {
  string,

  /** The meter period is instantaneous. Used for concurrent quotas. */
  None: "None",

  /** The meter period is per month. */
  Monthly: "Monthly",
}

/** Quota information. */
@resource("quotas")
@parentResource(QuantumWorkspace)
model Quota {
  /** Quota faux key. */
  @key
  @visibility("read")
  // A faux key is needed to tag the Quota as a resource.
  key: never;

  /** The name of the dimension associated with the quota. */
  @visibility("read")
  dimension: string;

  /** The scope at which the quota is applied. */
  @visibility("read")
  scope: DimensionScope;

  /** The unique identifier for the provider. */
  @visibility("read")
  providerId: string;

  /** The amount of the usage that has been applied for the current period. */
  @visibility("read")
  utilization: float32;

  /** The amount of the usage that has been reserved but not applied for the current period. */
  @visibility("read")
  holds: float32;

  /** The maximum amount of usage allowed for the current period. */
  @visibility("read")
  limit: float32;

  /** The time period in which the quota's underlying meter is accumulated. Based on calendar year. 'None' is used for concurrent quotas. */
  @visibility("read")
  period: MeterPeriod;
}

@useDependency(DefaultAzureCoreVersion)
namespace Quantum.Workspace.Operations {
  using Quantum.Workspace.BaseOperations;
  interface QuotaOperations {
    /** List quotas for the given workspace. */
    list is ListOperation<Quota>;
  }
}
