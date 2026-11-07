// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models.tsp";
import "../common/models-jobs.tsp";
import "../common/models-job-storage.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Quantum.Workspace;

/** A Paged List of JobDetails. */ // Used by workspace/jobs and sesssions/{sessionId}/jobs
alias PagedJobDetails = Azure.Core.Page<JobDetails>;

namespace Quantum.Workspace.Services {
  interface Jobs {
    /** Create a new job. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
    @sharedRoute
    @renamedFrom(QuantumWorkspaceAPIVersion.v2026_11_01_preview, "create")
    @removed(QuantumWorkspaceAPIVersion.v2026_11_01_preview)
    createLegacy is CreateOperation<JobDetails>;

    /**
     * Creates and submits a job with a client-generated job ID, JSON properties first,
     * and a binary input part second. The service finalizes the complete
     * multipart and HTTP request body before admitting the job for execution.
     * Accepted input is immutable: a retry must not replace it or schedule the job again.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Multipart create-and-submit requires ordered JSON properties and binary input instead of the standard JSON resource body."
    #suppress "@azure-tools/typespec-azure-core/byos" "Storage remains service-resolved in the workspace's linked account; ordinary clients use job-scoped byte transfer without storage credentials."
    @added(QuantumWorkspaceAPIVersion.v2026_11_01_preview)
    @sharedRoute
    @put
    create is Azure.Core.Foundations.ResourceOperation<
      JobDetails,
      {
        /** The multipart media type; the client supplies the boundary. */
        @header
        contentType: "multipart/form-data";

        /** The ordered properties and binary input parts. */
        @multipartBody
        body: JobSubmission;
      },
      Azure.Core.Foundations.ResourceCreatedResponse<JobDetails>,
      DefaultServiceTraits
    >;

    /** Update job properties. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Uses a custom signature to keep JobUpdateOptions as PATCH request while returning a dedicated JobUpdateResponse on the jobs route."
    @sharedRoute
    update is PatchOperation<JobUpdateOptions, JobUpdateResponse>;

    /** Delete a job by its id. */
    delete is DeleteOperation<JobDetails>;

    /** Request the cancellation of an existing job. */
    cancel is ActionOperation<JobDetails>;

    /** Get job by its id. */
    get is GetOperation<JobDetails>;

    /** List all jobs. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" """
      We had to use a custom ResourceList to avoid an autoroute bug for workspace/jobs and sesssions/{sessionId}/jobs.
      See https://github.com/Azure/typespec-azure/issues/494
      """
    list is CustomListOperation<
      Resource = JobDetails,
      Response = PagedJobDetails,
      Parameters = {
        ...CustomFilterQueryParameter;
        ...CustomSkipQueryParameter;
        ...CustomTopQueryParameter;
        ...CustomOrderByQueryParameter;
      }
    >;
  }
}
