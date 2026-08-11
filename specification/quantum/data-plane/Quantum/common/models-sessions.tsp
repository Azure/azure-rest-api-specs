// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";
import "./models.tsp";
import "./models-items.tsp";

using TypeSpec.Rest;

namespace Quantum.Workspace;

/** Policy controlling the behavior of the Session when a job in the session fails. */
union SessionJobFailurePolicy {
  string,

  /** New jobs submitted after a job fails will be rejected. */
  Abort: "Abort",

  /** New jobs submitted after a job fails will be accepted. */
  Continue: "Continue",
}

/** The status of the session. */
union SessionStatus {
  string,

  /** The session is waiting in the queue to be executed. */
  Waiting: "Waiting",

  /** The session is being executed. */
  Executing: "Executing",

  /** The session completed with success. */
  Succeeded: "Succeeded",

  /** The session completed with failure. */
  Failed: "Failed",

  /** The session completed with some failures. */
  `Failure(s)`: "Failure(s)",

  /** The session timed out. */
  TimedOut: "TimedOut",
}

/** Session, a logical grouping of jobs. */
@resource("sessions")
@parentResource(Quantum.Workspace.QuantumWorkspace)
model SessionDetails extends ItemDetails {
  /** Id of the session. */
  @key("sessionId")
  @visibility(Lifecycle.Read)
  id: WorkspaceItemId;

  /** Type of the Quantum Workspace item is Session. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  itemType: ItemType.Session;

  /** Policy controlling the behavior of the Session when a job in the session fails. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobFailurePolicy: SessionJobFailurePolicy;

  /** The status of the session. */
  @visibility(Lifecycle.Read)
  status?: SessionStatus;
}
