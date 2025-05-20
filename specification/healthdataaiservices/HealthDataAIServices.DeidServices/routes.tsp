import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";
import "./models_document_flow.tsp";
import "./models_text_flow.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AI Casing style to match OpenAI"
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
op listJobs is DeidentifyOperations.ResourceList<
  DeidentificationJob,
  ListQueryParametersTrait<PaginationByTokenQueryParameters>
>;

@summary("List processed documents within a job.")
op listJobDocuments is DeidentifyOperations.ResourceList<
  DeidentificationDocumentDetails,
  ListQueryParametersTrait<PaginationByTokenQueryParameters>
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

alias DeidentifyTextRequest = {
  @doc("Request body for de-identification operation.")
  @body
  body: DeidentificationContent;
};

@summary("De-identify text.")
@route("/deid")
@post
op deidentifyText is Azure.Core.RpcOperation<
  DeidentifyTextRequest,
  DeidentificationResult,
  ServiceTraits
>;
