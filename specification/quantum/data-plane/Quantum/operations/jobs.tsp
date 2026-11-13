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
     * Creates and submits a job, or returns an equivalent existing committed job, using a
     * client-generated job ID, JSON properties first, and a binary input part second.
     * For a new job, the service finalizes the complete multipart and HTTP request
     * body before committing the job and admitting it for execution, then returns 201.
     * If the ID identifies an existing committed job, returns 200 only when the input
     * bytes and normalized submission properties match the accepted submission.
     * Returns 409 when they differ or equivalence cannot be verified, including
     * previously committed jobs without a saved submission fingerprint.
     * The fingerprint is computed and stored by the service; clients do not supply it.
     * The accepted input is never overwritten, and a retry does not create another
     * job or duplicate scheduling. Any required publication repair must succeed before
     * returning 200. Both the complete MIME body and HTTP framing must validate before 200.
     *
     * Compared properties are name, providerId, target, sessionId, inputDataFormat,
     * outputDataFormat, inputParams, metadata, tags, and priority where supported.
     * JSON object member order and whitespace in properties are ignored; array order
     * and values are preserved, except tags are a case-insensitive deduplicated set.
     * Provider, target, and format identifiers are case-insensitive, and GUID spellings
     * are canonicalized. Omitted inputParams, metadata, and tags are empty.
     * Omitted inputDataFormat is qir.v1; omitted outputDataFormat uses the original
     * accepted target-selected default. DPv2 defaults omitted priority to Standard.
     * Job type is derived by admission; jobType, storage URI fields, and lifecycle
     * fields do not participate in comparison. Input bytes are not JSON-normalized.
     *
     * An in-flight submission or cleanup that has not committed a job does not qualify
     * for a successful retry response.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Multipart create-and-submit requires ordered JSON properties and binary input instead of the standard JSON resource body."
    #suppress "@azure-tools/typespec-azure-core/byos" "Storage remains service-resolved in the workspace's linked account; ordinary clients use job-scoped byte transfer without storage credentials."
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This create-once PUT returns an existing committed job without replacement; createOrReplace would misrepresent its immutable properties and input."
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
      Azure.Core.Foundations.ResourceCreatedOrOkResponse<JobDetails>,
      DefaultServiceTraits,
      Azure.Core.Foundations.ErrorResponse | JobSubmissionConflictResult
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
