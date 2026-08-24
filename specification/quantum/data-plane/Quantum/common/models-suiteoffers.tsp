// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Quantum.Workspace;

/** The scope at which the suite offer quota usage is applied. */
@added(QuantumWorkspaceAPIVersion.v2026_01_15_preview)
union SuiteOfferScope {
  string,

  /** The usage is applied at the job level. */
  Job: "Job",

  /** The usage is applied at the Quantum Workspace level. */
  Workspace: "Workspace",

  /** The usage is applied at the Azure Subscription level. */
  Subscription: "Subscription",

  /** The usage is applied at the target level. */
  Target: "Target",

  /** The usage is applied at the subscription target level. */
  SubscriptionTarget: "SubscriptionTarget",

  /** The usage is applied at the workspace target level. */
  WorkspaceTarget: "WorkspaceTarget",
}

/** The accumulated quota usage values for a suite offer provider. */
@added(QuantumWorkspaceAPIVersion.v2026_01_15_preview)
model QuotaUsage {
  /** The accumulated standard-priority minutes used over the lifetime. */
  @visibility(Lifecycle.Read)
  standardMinutesLifetime?: float64;

  /** The accumulated high-priority minutes used over the lifetime. */
  @visibility(Lifecycle.Read)
  highMinutesLifetime?: float64;
}

/** Quota usage data for a suite offer provider. */
@added(QuantumWorkspaceAPIVersion.v2026_01_15_preview)
model QuotaUsageData {
  /** The unique identifier for the quota usage record. */
  @visibility(Lifecycle.Read)
  id: string;

  /** The unique identifier for the provider. */
  @visibility(Lifecycle.Read)
  providerId: string;

  /** The scope at which the quota usage is applied. */
  @visibility(Lifecycle.Read)
  scope: SuiteOfferScope;

  /** The unique identifier for the target, when the usage is scoped to a target. */
  @visibility(Lifecycle.Read)
  targetId?: string;

  /** The accumulated quota usage values. */
  @visibility(Lifecycle.Read)
  usage: QuotaUsage;

  /** The time when the quota usage was last modified. */
  @visibility(Lifecycle.Read)
  lastModifiedTime: utcDateTime;

  /** Additional metadata associated with the quota usage. */
  @visibility(Lifecycle.Read)
  metadata?: Record<string>;
}
