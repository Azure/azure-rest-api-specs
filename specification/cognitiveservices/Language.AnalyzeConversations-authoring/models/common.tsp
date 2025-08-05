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

namespace Language.Conversations.Authoring;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConversationAuthoringProjectKind", "csharp")
union ProjectKind {
  string,

  /**
   * A project to build natural language into apps, bots, and IoT devices.
   */
  Conversation: "Conversation",

  /**
   * A project to connect and orchestrate Conversation, Custom question answering and LUIS projects together in one single project.
   */
  Orchestration: "Orchestration",

  /**
   * A project to build conversation summarization models which are able to summarize long conversations.
   */
  @added(Versions.v2024_11_15_preview)
  CustomConversationSummarization: "CustomConversationSummarization",
}

/**
 * Human-readable error code.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConversationAuthoringErrorCode", "csharp")
union ErrorCode {
  string,
  InvalidRequest: "InvalidRequest",
  InvalidArgument: "InvalidArgument",
  Unauthorized: "Unauthorized",
  Forbidden: "Forbidden",
  NotFound: "NotFound",
  ProjectNotFound: "ProjectNotFound",
  OperationNotFound: "OperationNotFound",
  AzureCognitiveSearchNotFound: "AzureCognitiveSearchNotFound",
  AzureCognitiveSearchIndexNotFound: "AzureCognitiveSearchIndexNotFound",
  TooManyRequests: "TooManyRequests",
  AzureCognitiveSearchThrottling: "AzureCognitiveSearchThrottling",
  AzureCognitiveSearchIndexLimitReached: "AzureCognitiveSearchIndexLimitReached",
  InternalServerError: "InternalServerError",
  ServiceUnavailable: "ServiceUnavailable",
  Timeout: "Timeout",
  QuotaExceeded: "QuotaExceeded",
  Conflict: "Conflict",
  Warning: "Warning",
}

/**
 * Human-readable error code.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConversationAuthoringInnerErrorCode", "csharp")
union InnerErrorCode {
  string,
  InvalidRequest: "InvalidRequest",
  InvalidParameterValue: "InvalidParameterValue",
  KnowledgeBaseNotFound: "KnowledgeBaseNotFound",
  AzureCognitiveSearchNotFound: "AzureCognitiveSearchNotFound",
  AzureCognitiveSearchThrottling: "AzureCognitiveSearchThrottling",
  ExtractionFailure: "ExtractionFailure",
  InvalidRequestBodyFormat: "InvalidRequestBodyFormat",
  EmptyRequest: "EmptyRequest",
  MissingInputDocuments: "MissingInputDocuments",
  InvalidDocument: "InvalidDocument",
  ModelVersionIncorrect: "ModelVersionIncorrect",
  InvalidDocumentBatch: "InvalidDocumentBatch",
  UnsupportedLanguageCode: "UnsupportedLanguageCode",
  InvalidCountryHint: "InvalidCountryHint",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("StringIndexType", "csharp")
union StringIndexType {
  string,

  /**
   * The offset and length values will correspond to UTF-16 code units. Use this option if your application is written in a language that support Unicode, for example Java, JavaScript.
   */
  Utf16CodeUnit: "Utf16CodeUnit",

  Utf8CodeUnit: "Utf8CodeUnit",
  Utf32CodeUnit: "Utf32CodeUnit",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConversationAuthoringExportedProjectFormat", "csharp")
union ExportedProjectFormat {
  string,

  /**
   * Specifies the format for a conversational project.
   */
  Conversation: "Conversation",

  /**
   * Specifies the format for an application that was exported from LUIS.
   */
  Luis: "Luis",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConversationAuthoringTrainingMode", "csharp")
union TrainingMode {
  string,

  /**
   * Trains using fine-tuned neural network transformer models. Can train multilingual projects.
   */
  advanced: "advanced",

  /**
   * Faster training times for quicker iterations.
   */
  standard: "standard",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConversationAuthoringEvaluationKind", "csharp")
union EvaluationKind {
  string,

  /**
   * Split the data into training and test sets according to user-defined percentages.
   */
  percentage: "percentage",

  /**
   * Split the data according to the chosen dataset for every example in the data.
   */
  manual: "manual",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@lroStatus
@clientName("ConversationAuthoringOperationStatus", "csharp")
union JobStatus {
  string,
  notStarted: "notStarted",
  running: "running",

  @lroSucceeded
  succeeded: "succeeded",

  @lroFailed
  failed: "failed",

  @lroCanceled
  cancelled: "cancelled",

  cancelling: "cancelling",
  partiallyCompleted: "partiallyCompleted",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConversationAuthoringCompositionMode", "csharp")
union CompositionSetting {
  string,

  /**
   * When two or more components are found in the text and overlap, the component with the longest set of characters is returned.
   */
  returnLongestOverlap: "returnLongestOverlap",

  /**
   * All components must overlap at the exact same characters in the text for the entity to return. If one of the defined components is not matched or predicted, the entity will not return.
   */
  requireExactOverlap: "requireExactOverlap",

  /**
   * Every component's match or prediction is returned as a separate instance of the entity.
   */
  separateComponents: "separateComponents",

  /**
   * When two or more components are found in the text and overlap, the components' spans are merged together into one span combining all of them.
   */
  combineComponents: "combineComponents",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("OrchestrationTargetProjectKind", "csharp")
union OrchestrationTargetProjectKind {
  string,
  Luis: "Luis",
  Conversation: "Conversation",
  QuestionAnswering: "QuestionAnswering",
}
