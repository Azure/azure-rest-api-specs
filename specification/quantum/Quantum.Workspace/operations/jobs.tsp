// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models.tsp";
import "../common/models-jobs.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Quantum.Workspace;

/** A Paged List of JobDetails. */ // Used by workspace/jobs and sesssions/{sessionId}/jobs
alias PagedJobDetails = Azure.Core.Page<JobDetails>;

namespace Quantum.Workspace.Services {
  interface Jobs {
    /** Create a new job. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
    create is CreateOperation<JobDetails>;

    /** Update job properties. */
    @added(QuantumWorkspaceAPIVersion.v2025_09_01_preview)
    update is PatchOperation<JobUpdateOptions>;

    /** OLD METHOD: Update job properties. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" """
      There is no support for JsonPatch in Azure.Core.
      The Azure.Core.ResourceUpdate does not support NoContentResponse and the JsonPatchDocument request body.
      See https://github.com/Azure/typespec-azure/issues/475
      """
    @removed(QuantumWorkspaceAPIVersion.v2025_09_01_preview)
    @renamedFrom(QuantumWorkspaceAPIVersion.v2025_09_01_preview, "update")
    updateOld is PatchOperationOld<JobDetails>;

    /** Delete a job by its id. Use for cancellation in versions before 2025-12-01-preview. */
    @renamedFrom(QuantumWorkspaceAPIVersion.v2025_12_01_preview, "cancel")
    delete is DeleteOperation<JobDetails>;

    /** Request the cancellation of an existing job. */
    @added(QuantumWorkspaceAPIVersion.v2025_12_01_preview)
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
