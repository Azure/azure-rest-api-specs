import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AI Casing style to match OpenAI"
@client({
  name: "DeidentificationClient",
})
namespace HealthDataAIServices.DeidServices;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  SupportsClientRequestId;

alias DeidentifyOperations = ResourceOperations<
  ServiceTraits,
  Azure.Core.Foundations.ErrorResponse
>;

// Text-Deidentification Operations

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
@summary("Create a de-identification job.")
@pollingOperation(getJob)
op createJob is DeidentifyOperations.LongRunningResourceCreateOrReplace<DeidentificationJob>;

@summary("Get a de-identification job.")
op getJob is DeidentifyOperations.ResourceRead<DeidentificationJob>;

@summary("List de-identification jobs.")
op listJobs is DeidentifyOperations.ResourceList<
  DeidentificationJob,
  ListQueryParametersTrait<PaginationByTokenQueryParameters>
>;

@summary("List processed documents within a job.")
op listJobDocuments is DeidentifyOperations.ResourceList<
  DocumentDetails,
  ListQueryParametersTrait<PaginationByTokenQueryParameters>
>;

#suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" ""
@summary("Cancel a de-identification job.")
@doc("""
  Cancels a job that is in progress. 
  
  The job will be marked as canceled and the service will stop processing the job. The service will not delete any documents that have already been processed.
  
  If the job is already complete, this will have no effect. 
  """)
@action("cancel")
op cancelJob is DeidentifyOperations.ResourceAction<
  DeidentificationJob,
  {},
  DeidentificationJob
>;

@summary("Delete a de-identification job.")
@doc("Removes the record of the job from the service. Does not delete any documents.")
op deleteJob is DeidentifyOperations.ResourceDelete<DeidentificationJob>;

@summary("De-identify text.")
@route("/deid")
@post
op deidentify is Azure.Core.RpcOperation<
  {
    @doc("Request body for de-identification operation.")
    @body
    body: DeidentificationContent;
  },
  DeidentificationResult
>;
