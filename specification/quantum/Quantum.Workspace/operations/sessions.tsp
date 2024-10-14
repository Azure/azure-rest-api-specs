// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using OpenAPI;

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
@parentResource(QuantumWorkspace)
model SessionDetails extends ItemDetails {
  /** Id of the session. */
  @key("sessionId")
  @visibility("read")
  id: WorkspaceItemId;

  /** Type of the Quantum Workspace item is Session. */
  @visibility("read", "create")
  itemType: ItemType.Session;

  /** Policy controlling the behavior of the Session when a job in the session fails. */
  @visibility("read", "create")
  jobFailurePolicy: SessionJobFailurePolicy;

  /** The status of the session. */
  @visibility("read")
  status?: SessionStatus;
}

@useDependency(DefaultAzureCoreVersion)
namespace Quantum.Workspace.Operations {
  using Quantum.Workspace.BaseOperations;
  interface SessionOperations {
    /** Open a new session. */
    open is CreateOperation<SessionDetails>;

    /** Close an existing session. */
    close is ActionOperation<SessionDetails>;

    /** Get Session by its id. */
    get is GetOperation<SessionDetails>;

    /** List all Sessions. */
    list is ListOperation<SessionDetails>;

    /** List jobs in a session. */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "The nesting of Jobs under a Session makes the auto-generated ID to be Sessions_JobsList, which is not in a Noun_Verb format."
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" """
      We had to use a custom ResourceList to avoid an autoroute bug for workspace/jobs and sesssions/{sessionId}/jobs.
      See https://github.com/Azure/typespec-azure/issues/494
      """
    @operationId("SessionsJobs_List")
    jobsList is CustomListOperation<
      Resource = JobDetails,
      Response = PagedJobDetails,
      Parameters = {
        /** Id of the session to list jobs from. */
        @path
        @segment("sessions")
        sessionId: WorkspaceItemId;
      }
    >;
  }
}
