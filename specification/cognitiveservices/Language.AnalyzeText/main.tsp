import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
// import "@azure-tools/typespec-autorest";
import "./common.tsp";
import "./models/common.models.tsp";
import "./models/custom.text.tsp";
import "./models/entity.linking.tsp";
import "./models/entity.recognition.tsp";
import "./models/healthcare.tsp";
import "./models/key.phrase.extraction.tsp";
import "./models/language.detection.tsp";
import "./models/pii.entity.recognition.tsp";
import "./models/sentiment.analysis.tsp";
import "./models/summarization.tsp";
import "./models/custom.healthcare.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;
// using Autorest;

@useAuth(
  TypeSpec.Http.ApiKeyAuth<
    TypeSpec.Http.ApiKeyLocation.header,
    "Ocp-Apim-Subscription-Key"
  >
)
@doc("The language service API is a suite of natural language processing (NLP) skills built with best-in-class Microsoft machine learning algorithms.  The API can be used to analyze unstructured text for tasks such as sentiment analysis, key phrase extraction, language detection and question answering. Further documentation can be found in <a href=\"https://docs.microsoft.com/azure/cognitive-services/language-service/overview\">https://docs.microsoft.com/azure/cognitive-services/language-service/overview</a>.0")
@service({
  title: "Microsoft Cognitive Language Service - Text Analysis",
})
@server(
  "{Endpoint}/language",
  "Single server endpoint",
  {
    @doc("Supported Cognitive Services endpoint (e.g., https://<resource-name>.api.cognitiveservices.azure.com).")
    Endpoint: string,
  }
)
@versioned(Versions)
namespace Language.AnalyzeText;

@doc("Analyze Conversations Service Versions")
enum Versions {
  @doc("Version 2022-05-01")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2022_05_01: "2022-05-01",

  @doc("Version 2023-04-01")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_01: "2023-04-01",

  @doc("Version 2023-04-15-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_15_preview: "2023-04-15-preview",

  @doc("Version 2023-11-15-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_11_15_preview: "2023-11-15-preview",
}

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@post
@route("/:analyze-text")
@doc("Request text analysis over a collection of documents.")
// @example("./SuccessfulEntityLinkingRequest.json", "SuccessfulEntityLinkingRequest")
// @example("./SuccessfulEntityRecognitionRequest.json", "SuccessfulEntityRecognitionRequest")
// @example("./SuccessfulKeyPhraseExtractionRequest.json", "SuccessfulKeyPhraseExtractionRequest")
// @example("./SuccessfulLanguageDetectionRequest.json", "SuccessfulLanguageDetectionRequest")
// @example("./SuccessfulPiiEntityRecognitionRequest.json", "SuccessfulPiiEntityRecognitionRequest")
// @example("./SuccessfulSentimentAnalysisRequest.json", "SuccessfulSentimentAnalysisRequest")
// @example("./SuccessfulDynamicClassificationRequest.json", "SuccessfulDynamicClassificationRequest")
// @example("./SuccessfulEntityRecognitionExclusionRequest.json", "SuccessfulEntityRecognitionExclusionRequest")
// @example("./SuccessfulEntityRecognitionInclusionRequest.json", "SuccessfulEntityRecognitionInclusionRequest")
// @example("./SuccessfulEntityRecognitionOverlapPolicy.json", "SuccessfulEntityRecognitionOverlapPolicy")
// @example("./SuccessfulPiiEntityRecognitionExclusionRequest.json", "SuccessfulPiiEntityRecognitionExclusionRequest")
// @example("./SuccessfulPiiEntityRecognitionRedactionRequest.json", "SuccessfulPiiEntityRecognitionRedactionRequest")
// @example("./SuccessfulEntityRecognitionInferenceOptionsRequest.json", "SuccessfulEntityRecognitionInferenceOptionsRequest")
op analyzeText(
  @doc("Collection of documents to analyze and a single task to execute.")
  @body
  body: AnalyzeTextTask,

  ...Azure.Core.Foundations.ApiVersionParameter,
): AnalyzeTextTaskResult | Azure.Core.Foundations.ErrorResponse;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get the status of an analysis job. A job can consist of one or more tasks. After all tasks succeed, the job transitions to the succeeded state and results are available for each task.")
@summary("Get analysis status and results")
// @example("./SuccessfulAnalyzeTextJobsMultipleTaskStatusRequest.json", "SuccessfulAnalyzeTextJobsMultipleTaskStatusRequest")
// @example("./SuccessfulAbstractiveSummarizationTaskResult.json", "SuccessfulAbstractiveSummarizationTaskResult")
// @example("./SuccessfulCustomAbstractiveSummarizationTaskResult.json", "SuccessfulCustomAbstractiveSummarizationTaskResult")
// @example("./SuccessfulCustomHealthcareTaskStatusRequest.json", "SuccessfulCustomHealthcareTaskStatusRequest")
// @example("./SuccessfulCustomSentimentAnalysisTaskStatusRequest.json", "SuccessfulCustomSentimentAnalysisTaskStatusRequest")
// @example("./SuccessfulHealthcareDocumentTypeTaskStatusRequest.json", "SuccessfulHealthcareDocumentTypeTaskStatusRequest")
// @example("./SuccessfulHealthcareTaskStatusRequest.json", "SuccessfulHealthcareTaskStatusRequest")
op analyzeTextJobStatus is Operations.ResourceRead<
  AnalyzeTextJobState,
  AnalyzeTextQueryParameters
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Submit a collection of text documents for analysis. Specify one or more unique tasks to be executed as a long-running operation.")
@route("/analyze-text/jobs")
@pollingOperation(analyzeTextJobStatus)
// @example("./SuccessfulAnalyzeTextJobsMultipleTaskSubmitRequest.json", "SuccessfulAnalyzeTextJobsMultipleTaskSubmitRequest")
// @example("./SuccessfulAbstractiveSummarizationTaskSubmit.json", "SuccessfulAbstractiveSummarizationTaskSubmit")
// @example("./SuccessfulCustomAbstractiveSummarizationTaskSubmit.json", "SuccessfulCustomAbstractiveSummarizationTaskSubmit")
// @example("./SuccessfulCustomHealthcarePostRequest.json", "SuccessfulCustomHealthcarePostRequest")
// @example("./SuccessfulCustomSentimentAnalysisTaskSubmit.json", "SuccessfulCustomSentimentAnalysisTaskSubmit")
// @example("./SuccessfulHealthcareDocumentTypePostRequest.json", "SuccessfulHealthcareDocumentTypePostRequest")
// @example("./SuccessfulHealthcarePostRequest.json", "SuccessfulHealthcarePostRequest")
op analyzeTextSubmitJob is LanguageLongRunningOperation<
  AnalyzeTextJobsInput,
  AnalyzeTextJobState
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Cancel a long-running Text Analysis job.")
@summary("Cancel a long-running Text Analysis job.")
@pollingOperation(analyzeTextJobStatus)
@actionSeparator(":")
@action("cancel")
// @example("./SuccessfulAnalyzeTextJobsCancelRequest.json", "SuccessfulAnalyzeTextJobsCancelRequest")
op analyzeTextCancelJob is LanguageLongRunningResourceCancel<AnalyzeTextJobState>;
