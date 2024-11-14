import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";
import "./models_document_flow.tsp";
import "./models_text_flow.tsp";

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
op deidentifyDocuments is DeidentifyOperations.LongRunningResourceCreateOrReplace<DeidentificationJob>;

@summary("Get a de-identification job.")
op getJob is DeidentifyOperations.ResourceRead<DeidentificationJob>;

@summary("List de-identification jobs.")
@access(Access.internal, "csharp,python")
op listJobs is DeidentifyOperations.ResourceList<
  DeidentificationJob,
  ListQueryParametersTrait<PaginationByTokenQueryParameters>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@summary("List processed documents within a job.")
@route("/jobs/{jobName}/documents")
@access(Access.internal, "csharp,python")
op listJobDocuments is Azure.Core.Foundations.Operation<
  {
    @doc("The name of a job.")
    @maxLength(36)
    @minLength(3) // Must be 3 to match regex
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]+[a-zA-Z0-9]$")
    jobName: string;

    ...PaginationByTokenQueryParameters;
  },
  Page<DocumentDetails>,
  Azure.Core.Foundations.ErrorResponse
>;

@doc("Query parameters for list operation.")
model PaginationByTokenQueryParameters {
  ...MaxPageSizeQueryParameter;

  @query
  @doc("Token to continue a previous query.")
  continuationToken?: string;
}

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
op deidentifyText is Azure.Core.RpcOperation<
  {
    @doc("Request body for de-identification operation.")
    @body
    @clientName("content", "csharp")
    body: DeidentificationContent;
  },
  DeidentificationResult,
  ServiceTraits
>;
