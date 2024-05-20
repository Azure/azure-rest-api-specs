import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace HealthDataAIServices.Deidentification;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  SupportsClientRequestId;

alias DeidentifyOperations = ResourceOperations<
  ServiceTraits,
  Azure.Core.Foundations.ErrorResponse
>;

// interface Deidentification {
@summary("Create a De-Identify Job")
@pollingOperation(getJob)
op createJob is DeidentifyOperations.LongRunningResourceCreateOrReplace<DeidentifyJob>;

@summary("Get a De-Identify Job")
op getJob is DeidentifyOperations.ResourceRead<DeidentifyJob>;

@summary("List De-Identify Jobs")
op listJobs is DeidentifyOperations.ResourceList<
  DeidentifyJob,
  ListQueryParametersTrait<PaginationByTokenQueryParameters>
>;

@summary("List processed files within a Job")
op listJobFiles is DeidentifyOperations.ResourceList<
  HealthFileDetails,
  ListQueryParametersTrait<PaginationByTokenQueryParameters>
>;

#suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" ""
@summary("Cancel a De-Identify Job")
@doc("""
  Cancels a job that is in progress. 
  
  The job will be marked as canceled and the service will stop processing the job. The service will not delete any files that have already been processed.

  If the job is already complete, this will have no effect. 
  """)
@action("cancel")
op cancelJob is DeidentifyOperations.ResourceAction<
  DeidentifyJob,
  {},
  DeidentifyJob
>;

@summary("Delete a De-Identify Job")
@doc("Removes the record of the job from the service. Does not delete any files.")
op deleteJob is DeidentifyOperations.ResourceDelete<DeidentifyJob>;

@summary("Realtime Synchronous Deidentification.")
@route("/deid")
@post
op deidentify is Azure.Core.RpcOperation<
  {
    @doc("The request body for realtime deidentification.")
    @body
    body: DeidentifyOptions;
  },
  DeidentifyResult
>;
// }
