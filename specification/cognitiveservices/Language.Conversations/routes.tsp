import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.Conversations;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias languageOperations = ResourceOperations<ServiceTraits, ErrorResponse>;

/** Analyzes the input conversation utterance. */
@post
@route("/:analyze-conversations")
op analyzeConversations is RpcOperation<
  {
    /** The input for the analyze conversations operation. */
    @bodyRoot
    @clientName("AnalyzeConversationInput", "csharp")
    body: AnalyzeConversationTask;
  },
  AnalyzeConversationTaskResult,
  {},
  ErrorResponse
>;

/** Get the status of an analysis job. A job can consist of one or more tasks. After all tasks succeed, the job transitions to the succeeded state and results are available for each task. */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
@added(Versions.v2023_04_01)
@summary("Get analysis status and results")
op analyzeConversationsJobStatus is languageOperations.ResourceRead<
  AnalyzeConversationJobState,
  ShowStatsQueryParameter
>;

/** Analyzes the input conversation utterance. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.v2023_04_01)
@route("/analyze-conversations/jobs")
@pollingOperation(analyzeConversationsJobStatus)
op analyzeConversationsSubmitJob is Foundations.LongRunningOperation<
  {
    /** The input for the analyze conversations operation. */
    @bodyRoot
    @clientName("AnalyzeConversationOperationInput", "csharp")
    body: AnalyzeConversationJobsInput;
  },
  AcceptedResponse,
  {},
  ErrorResponse
>;

/** Cancel a long-running job for text analysis of conversations. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.v2023_04_01)
@summary("Cancel a long-running Text Analysis conversations job.")
@pollingOperation(analyzeConversationsJobStatus)
@route("/analyze-conversations/jobs/{jobId}:cancel")
@post
op analyzeConversationsCancelJob is Foundations.LongRunningOperation<
  {
    /** The job ID to cancel. */
    @path
    jobId: uuid;
  },
  AcceptedResponse,
  {},
  ErrorResponse
>;
