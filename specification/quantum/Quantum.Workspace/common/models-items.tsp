// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";
import "./cost-estimates.tsp";
import "./models.tsp";

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
}
