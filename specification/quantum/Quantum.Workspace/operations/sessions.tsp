// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

using OpenAPI;

@doc("Policy controlling the behavior of the Session when a job in the session fails.")
enum SessionJobFailurePolicy {
  @doc("New jobs submitted after a job fails will be rejected.")
  Abort,

  @doc("New jobs submitted after a job fails will be accepted.")
  Continue,
}

@doc("The status of the session.")
enum SessionStatus {
  @doc("The session is waiting in the queue to be executed.")
  Waiting,

  @doc("The session is being executed.")
  Executing,

  @doc("The session completed with success.")
  Succeeded,

  @doc("The session completed with failure.")
  Failed,

  @doc("The session completed with some failures.")
  `Failure(s)`,

  @doc("The session timed out.")
  TimedOut,
}

// Notes:
// - The generated Swagger is not automatically adding the x-ms-discriminator-value
//   so we are adding it manually.
@extension("x-ms-discriminator-value", ItemType.Session)
@doc("Session, a logical grouping of jobs.")
@resource("sessions")
@parentResource(QuantumWorkspace)
model SessionDetails extends ItemDetails {
  @key("sessionId")
  @doc("Id of the session.")
  @visibility("read", "create")
  id: WorkspaceItemId;

  @visibility("read", "create")
  @doc("Type of the Quantum Workspace item is Session.")
  itemType: ItemType.Session;

  @doc("Policy controlling the behavior of the Session when a job in the session fails.")
  @visibility("read", "create")
  jobFailurePolicy: SessionJobFailurePolicy;

  @doc("The status of the session.")
  @visibility("read")
  status?: SessionStatus;
}

#suppress "@azure-tools/typespec-azure-core/spread-discriminated-model" "The discriminator is not used in this scenario"
@doc("A Session Job.")
@resource("jobs")
@parentResource(SessionDetails)
@withVisibility("read")
model SessionJobDetails {
  ...JobDetails;
}

@useDependency(DefaultAzureCoreVersion)
namespace Quantum.Workspace.Operations {
  using Quantum.Workspace.BaseOperations;
  interface SessionOperations {
    @doc("Open a new session")
    open is CreateOperation<SessionDetails>;

    @doc("Close an existing session")
    close is ActionOperation<SessionDetails>;

    @doc("Get Session by its id")
    get is GetOperation<SessionDetails>;

    @doc("List jobs in a session")
    jobsList is ListOperation<SessionJobDetails>;

    @doc("List all Sessions")
    list is ListOperation<SessionDetails>;
  }
}
