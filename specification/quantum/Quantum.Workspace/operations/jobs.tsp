// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models.tsp";
import "../common/modes-jobs.tsp";

using Quantum.Workspace;

/** A Paged List of JobDetails. */ // Used by workspace/jobs and sesssions/{sessionId}/jobs
alias PagedJobDetails = Azure.Core.Page<JobDetails>;

namespace Quantum.Workspace.Services {
  interface Jobs {
    /** Create a new job. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
    create is CreateOperation<JobDetails>;

    /** Update job properties. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" """
      There is no support for JsonPatch in Azure.Core.
      The Azure.Core.ResourceUpdate does not support NoContentResponse and the JsonPatchDocument request body.
      See https://github.com/Azure/typespec-azure/issues/475
      """
    update is PatchOperation<JobDetails>;

    /** Request the cancellation of an existing job. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
    cancel is CancelOperation<JobDetails>;

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
