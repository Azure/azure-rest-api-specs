// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models-sessions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using OpenAPI;

using Quantum.Workspace;

/** A Paged List of SessionDetails. */ // Used by workspace/sesssions
alias PagedSessionDetails = Azure.Core.Page<SessionDetails>;

namespace Quantum.Workspace.Services {
  interface Sessions {
    /** Open a new session. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
    open is CreateOperation<SessionDetails>;

    /** Close an existing session. */
    close is ActionOperation<SessionDetails>;

    /** Get Session by its id. */
    get is GetOperation<SessionDetails>;

    /** List all Sessions. */
    @sharedRoute
    @added(QuantumWorkspaceAPIVersion.v2024_03_01_preview)
    @removed(QuantumWorkspaceAPIVersion.v2024_10_01_preview)
    list is ListOperation<SessionDetails>;

    /** List all Sessions. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" """
      We had to use a custom ResourceList to avoid an autoroute bug for workspace/jobs and sesssions/{sessionId}/jobs.
      See https://github.com/Azure/typespec-azure/issues/494
      """
    @sharedRoute
    @added(QuantumWorkspaceAPIVersion.v2024_10_01_preview)
    listv2 is CustomListOperation<
      Resource = SessionDetails,
      Response = PagedSessionDetails,
      Parameters = {
        ...CustomFilterQueryParameter;
        ...CustomSkipQueryParameter;
        ...CustomTopQueryParameter;
        ...CustomOrderByQueryParameter;
      }
    >;

    /** List jobs in a session. */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "The nesting of Jobs under a Session makes the auto-generated ID to be Sessions_JobsList, which is not in a Noun_Verb format."
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
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

        ...CustomFilterQueryParameter;
        ...CustomSkipQueryParameter;
        ...CustomTopQueryParameter;
        ...CustomOrderByQueryParameter;
      }
    >;
  }
}
