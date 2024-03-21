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
enum SessionJobFailurePolicy {
  /** New jobs submitted after a job fails will be rejected. */
  Abort,

  /** New jobs submitted after a job fails will be accepted. */
  Continue,
}

/** The status of the session. */
enum SessionStatus {
  /** The session is waiting in the queue to be executed. */
  Waiting,

  /** The session is being executed. */
  Executing,

  /** The session completed with success. */
  Succeeded,

  /** The session completed with failure. */
  Failed,

  /** The session completed with some failures. */
  `Failure(s)`,

  /** The session timed out. */
  TimedOut,
}

// Notes:
// - The generated Swagger is not automatically adding the x-ms-discriminator-value
//   so we are adding it manually.
/** Session, a logical grouping of jobs. */
@extension("x-ms-discriminator-value", ItemType.Session)
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

/** A Session Job. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@resource("jobs")
@parentResource(SessionDetails)
@withVisibility("read")
model SessionJobDetails extends JobDetails {}

@useDependency(DefaultAzureCoreVersion)
namespace Quantum.Workspace.Operations {
  /** A Paged List of JobDetails. */
  // This is used in the session.listJobs workaround
  @encodedName("application/json", "PagedJobDetails")
  model PagedSessionJobDetails {
    ...Azure.Core.Page<JobDetails>;
  }

  using Quantum.Workspace.BaseOperations;
  interface SessionOperations {
    /** Open a new session. */
    open is CreateOperation<SessionDetails>;

    /** Close an existing session. */
    close is ActionOperation<SessionDetails>;

    /** Get Session by its id. */
    get is GetOperation<SessionDetails>;

    /** List jobs in a session. */
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "The nesting of Jobs under a Session makes the auto-generated ID to be Sessions_JobsList, which is not in a Noun_Verb format."
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "When using Azure.Core.ResourceList<>, the autoroute is not adding the parent resource id to the path"
    @operationId("SessionsJobs_List")
    jobsList is Azure.Core.Foundations.ResourceList<
      Resource = JobDetails,
      Parameters = {
        /** The Azure subscription ID. */
        @path
        @segment("sessions")
        sessionId: string;
      },
      Response = PagedSessionJobDetails
    >;

    /** List all Sessions. */
    list is ListOperation<SessionDetails>;
  }
}
