// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";
import "./items.tsp";
import "./operations.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Rest.Resource;
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
model SessionDetails extends ItemDetails {
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

@doc("List of workspace sessions.")
model SessionDetailsList extends CollectionWithNextLink<SessionDetails> {}

@doc("Id of the session.")
@pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
@maxLength(36)
scalar SessionId extends WorkspaceItemId;

alias SessionIdParam = {
  @path
  @segment("sessions")
  @doc("Id of the session.")
  sessionId: SessionId;
};

alias SessionParam = {
  @path
  @segment("sessions")
  @doc("Id of the session.")
  sessionId: SessionId;

  @body
  @doc("The session data.")
  session: SessionDetails;
};

interface SessionOperations {
  @doc("Open a new session")
  @put
  @createsResource(SessionDetails)
  @operationId("Sessions_Open")
  open is CreateOperation<SessionDetails, SessionParam>;

  @doc("Close an existing session")
  @post
  @action
  @actionSeparator(":")
  @operationId("Sessions_Close")
  close is ActionOperation<SessionDetails, SessionIdParam>;

  @doc("Get Session by its id")
  @get
  @readsResource(SessionDetails)
  @operationId("Sessions_Get")
  get is GetOperation<SessionDetails, SessionIdParam>;

  @doc("List jobs in a session")
  @get
  @readsResource(JobDetails)
  @operationId("Sessions_JobsList")
  @segment("jobs")
  jobs is ListOperation<JobDetailsList, SessionIdParam>;

  @doc("List all Sessions")
  @get
  @listsResource(SessionDetails)
  @operationId("Sessions_List")
  @segment("sessions")
  list is ListOperation<SessionDetailsList>;
}
