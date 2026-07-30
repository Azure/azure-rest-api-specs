// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";
import "./cost-estimates.tsp";
import "./models.tsp";

using TypeSpec.Versioning;
using TypeSpec.Rest;

namespace Quantum.Workspace;

/** The type of the workspace item. */
union ItemType {
  string,

  /** A program, problem, or application submitted for processing. */
  Job: "Job",

  /** A logical grouping of jobs. */
  Session: "Session",
}

/** Job priority levels. */
@added(QuantumWorkspaceAPIVersion.v2025_09_01_preview)
union Priority {
  string,

  /** The job's base priority. */
  Standard: "Standard",

  /** The job's priority is elevated. */
  High: "High",
}

/** The type of identity that created the item. */
@added(QuantumWorkspaceAPIVersion.v2025_12_01_preview)
union CreatedByType {
  string,

  /** The item is created by user */
  User: "User",

  /** The item is created by application */
  Application: "Application",

  /** The item is created using managed identity */
  ManagedIdentity: "ManagedIdentity",

  /** The item is created using key */
  Key: "Key",
}

/** Id of the workspace item. */
@pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
@maxLength(36)
scalar WorkspaceItemId extends string;

/** A workspace item. */
@discriminator("itemType")
@resource("topLevelItems")
@parentResource(QuantumWorkspace)
model ItemDetails {
  /** Id of the item. */
  @key
  @visibility(Lifecycle.Read)
  id: WorkspaceItemId;

  /** The name of the item. It is not required for the name to be unique and it's only used for display purposes. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  /** The unique identifier for the provider. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  providerId: string;

  /** The target identifier to run the job. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  target: string;

  /** Type of the Quantum Workspace item */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  itemType: ItemType;

  /** The creation time of the item. */
  @visibility(Lifecycle.Read)
  creationTime?: utcDateTime;

  /** The identity that created the item. */
  @added(QuantumWorkspaceAPIVersion.v2025_12_01_preview)
  @visibility(Lifecycle.Read)
  createdBy?: string;

  /** The type of identity that created the item. */
  @added(QuantumWorkspaceAPIVersion.v2025_12_01_preview)
  @visibility(Lifecycle.Read)
  createdByType?: CreatedByType;

  /** The timestamp of the item last modification initiated by the customer. */
  @added(QuantumWorkspaceAPIVersion.v2025_12_01_preview)
  @visibility(Lifecycle.Read)
  lastModifiedTime?: utcDateTime;

  /** The identity that last modified the item. */
  @added(QuantumWorkspaceAPIVersion.v2025_12_01_preview)
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;

  /** The type of identity that last modified the item. */
  @added(QuantumWorkspaceAPIVersion.v2025_12_01_preview)
  @visibility(Lifecycle.Read)
  lastModifiedByType?: CreatedByType;

  /** The last time the item was updated by the system. */
  @added(QuantumWorkspaceAPIVersion.v2025_12_01_preview)
  @visibility(Lifecycle.Read)
  lastUpdatedTime?: utcDateTime;

  /** The time when the item began execution. */
  @visibility(Lifecycle.Read)
  beginExecutionTime?: utcDateTime;

  /** The time when the item finished execution. */
  @visibility(Lifecycle.Read)
  endExecutionTime?: utcDateTime;

  /** Cost estimate. */
  @visibility(Lifecycle.Read)
  costEstimate?: CostEstimate;

  /** Error information. */
  @visibility(Lifecycle.Read)
  errorData?: Errors.WorkspaceItemError;

  /** Priority of job or session. */
  @added(QuantumWorkspaceAPIVersion.v2025_09_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  priority?: Priority;

  /** List of user-supplied tags associated with the job. */
  @added(QuantumWorkspaceAPIVersion.v2025_09_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: string[];

  /** Resource consumption metrics containing provider-specific usage data such as execution time, quantum shots consumed etc. */
  @added(QuantumWorkspaceAPIVersion.v2025_09_01_preview)
  @visibility(Lifecycle.Read)
  usage?: Usage;
}

/** Resource usage metrics represented as key-value pairs. Keys are provider-defined metric names (e.g. "standardMinutes", "shots") and values are the corresponding consumption amounts. The specific metrics available depend on the quantum provider and target used. */
@added(QuantumWorkspaceAPIVersion.v2025_09_01_preview)
model Usage is Record<float64>;
