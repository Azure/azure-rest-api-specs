import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Language.Conversations;

namespace Language.ConversationsClientCustomizations;

@@clientName(Conversations, "ConversationAnalysis", "!autorest");
@@clientName(analyzeConversations, "AnalyzeConversation", "!autorest");

@@clientName(ConversationEntity.confidenceScore, "confidence", "!autorest");
@@clientName(ConversationIntent.confidenceScore, "confidence", "!autorest");
@@clientName(TargetIntentResult.confidenceScore, "confidence", "!autorest");
@@clientName(KnowledgeBaseAnswer.confidenceScore, "confidence", "!autorest");
@@clientName(KnowledgeBaseAnswer.id, "qnaId", "!autorest");
@@clientName(KnowledgeBaseAnswer.answerSpan, "shortAnswer", "!autorest");
@@clientName(KnowledgeBaseAnswer.confidenceScore, "confidence", "!autorest");
@@clientName(
  KnowledgeBaseAnswerContext.previousUserQuery,
  "previousQuestion",
  "!autorest"
);

@@clientName(
  AnswersOptions.confidenceScoreThreshold,
  "confidenceThreshold",
  "!autorest"
);
@@clientName(AnswersOptions.context, "answerContext", "!autorest");
@@clientName(AnswersOptions.rankerType, "rankerKind", "!autorest");
@@clientName(
  AnswersOptions.answerSpanRequest,
  "shortAnswerOptions",
  "!autorest"
);

@@clientName(
  ShortAnswerOptions.confidenceScoreThreshold,
  "confidenceThreshold",
  "!autorest"
);
@@clientName(ShortAnswerOptions.topAnswersWithSpan, "top", "!autorest");

@@clientName(
  AnalyzeConversationLROTask,
  "AnalyzeConversationOperationAction",
  "!autorest"
);

@@clientName(AnalyzeConversationLROTask.taskName, "Name", "!autorest");

@@clientName(BasePrediction, "PredictionBase", "!autorest");

@@clientName(LengthUnit.Pt, "Point", "!autorest");
@@clientName(LogicalOperationKind.AND, "And", "!autorest");
@@clientName(LogicalOperationKind.OR, "Or", "!autorest");

@@clientName(redactionCharacter.perCent, "Percent", "!autorest");

@@clientName(TemporalModifier.AfterApprox, "AfterApproximate", "!autorest");
@@clientName(TemporalModifier.BeforeApprox, "BeforeApproximate", "!autorest");
@@clientName(TemporalModifier.Approx, "Approximate", "!autorest");

@@clientName(
  RedactedTranscriptContent.itn,
  "InverseTextNormalized",
  "!autorest"
);
@@clientName(
  RedactedTranscriptContent.maskedItn,
  "MaskedInverseTextNormalized",
  "!autorest"
);
@@clientName(Error, "ConversationError", "!autorest");

@@clientName(AnalysisParameters, "AnalysisConfig", "!autorest");
@@clientName(LuisParameters, "LuisConfig", "!autorest");
@@clientName(ConversationParameters, "ConversationConfig", "!autorest");
@@clientName(
  QuestionAnsweringParameters,
  "QuestionAnsweringConfig",
  "!autorest"
);
@@clientName(AnswersOptions, "QuestionAnswersConfig", "!autorest");
@@clientName(ShortAnswerOptions, "ShortAnswerConfig", "!autorest");
@@clientName(
  ConversationCallingOptions,
  "ConversationCallingConfig",
  "!autorest"
);
@@clientName(LuisCallingOptions, "LuisCallingConfig", "!autorest");

@@clientName(
  ConversationAnalysisOptions,
  "ConversationAnalysisInput",
  "!autorest"
);

@@clientName(Tasks, "ConversationActions", "!autorest");
@@clientName(Tasks.items, "taskResults", "python");
@@clientName(State, "ConversationActionState", "!autorest");
@@clientName(role, "ParticipantRole", "!autorest");
@@clientName(
  NoneLinkedTargetIntentResult,
  "NonLinkedTargetIntentResult",
  "python"
);

@@clientName(Entity, "NamedEntity", "!autorest");

@@clientName(
  CustomConversationSummarizationTaskParameters,
  "CustomConversationSummarizationActionContent",
  "!autorest"
);

@@clientName(
  ConversationTaskParameters,
  "ConversationLanguageUnderstandingActionContent",
  "!autorest"
);

@@clientName(ConversationTaskParameters, "ConversationActionContent", "python");

@@clientName(
  ConversationalAIInputParameters,
  "AIConversationLanguageUnderstandingActionContent",
  "!autorest"
);
@@clientName(
  ConversationalAIInputParameters,
  "ConversationalAIActionContent",
  "python"
);

@@clientName(
  ConversationSummarizationTaskParameters,
  "ConversationSummarizationActionContent",
  "!autorest"
);
@@clientName(
  ConversationPiiTaskParameters,
  "ConversationPiiActionContent",
  "!autorest"
);

@@clientName(Conversation, "ConversationInput", "!autorest");

@@clientName(
  ConversationPiiCategoriesExclude.USSocialSecurityNumber,
  "UsSocialSecurityNumber",
  "!autorest"
);
@@clientName(
  ConversationPiiCategoriesExclude,
  "ConversationPiiCategoryExclusions",
  "!autorest"
);
@@clientName(
  ConversationPiiCategoriesExclude.USSocialSecurityNumber,
  "UsSocialSecurityNumber",
  "!autorest"
);
@@clientName(ErrorCode, "ConversationErrorCode", "!autorest");

@@clientName(BaseResolution, "ResolutionBase", "!autorest");
@@clientName(
  BaseExtraInformation,
  "ConversationEntityExtraInformation",
  "!autorest"
);

@@clientName(
  TranscriptConversationItem.itn,
  "InverseTextNormalized",
  "!autorest"
);
@@clientName(
  TranscriptConversationItem.maskedItn,
  "MaskedInverseTextNormalized",
  "!autorest"
);

@@clientName(AnalyzeConversationTask, "AnalyzeConversationInput", "!autorest");
@@clientName(
  AnalyzeConversationTaskKind,
  "AnalyzeConversationInputKind",
  "!autorest"
);

@@clientName(
  ConversationalTask,
  "ConversationLanguageUnderstandingInput",
  "!autorest"
);

@@clientName(
  ConversationalTask.analysisInput,
  "ConversationInput",
  "!autorest"
);
@@clientName(ConversationalTask.parameters, "ActionContent", "!autorest");

@@clientName(
  AnalyzeConversationTaskResult,
  "AnalyzeConversationActionResult",
  "!autorest"
);
@@clientName(
  AnalyzeConversationTaskResultsKind,
  "AnalyzeConversationResultKind",
  "!autorest"
);

@@clientName(ConversationalTaskResult, "ConversationActionResult", "!autorest");

@@clientName(
  MultiLanguageConversationAnalysisInput,
  "MultiLanguageConversationInput",
  "!autorest"
);

@@clientName(
  AnalyzeConversationJobsInput,
  "AnalyzeConversationOperationInput",
  "!autorest"
);
@@clientName(
  AnalyzeConversationJobsInput.analysisInput,
  "ConversationInput",
  "!autorest"
);
@@clientName(AnalyzeConversationJobsInput.tasks, "Actions", "!autorest");

@@clientName(
  AnalyzeConversationLROTask,
  "AnalyzeConversationOperationAction",
  "!autorest"
);
@@clientName(AnalyzeConversationLROTask.taskName, "Name", "!autorest");

@@clientName(
  AnalyzeConversationLROTaskKind,
  "AnalyzeConversationOperationActionKind",
  "!autorest"
);

@@clientName(AnalyzeConversationPiiTask, "PiiOperationAction", "!autorest");
@@clientName(
  AnalyzeConversationPiiTask.parameters,
  "ActionContent",
  "!autorest"
);

@@clientName(
  AnalyzeCustomConversationSummarizationTask,
  "CustomSummarizationOperationAction",
  "!autorest"
);
@@clientName(
  AnalyzeCustomConversationSummarizationTask.parameters,
  "ActionContent",
  "!autorest"
);

@@clientName(
  AnalyzeConversationSummarizationTask,
  "SummarizationOperationAction",
  "!autorest"
);
@@clientName(
  AnalyzeConversationSummarizationTask.parameters,
  "ActionContent",
  "!autorest"
);

@@clientName(
  AnalyzeConversationJobState,
  "AnalyzeConversationOperationState",
  "!autorest"
);
@@clientName(AnalyzeConversationJobState.tasks, "Actions", "!autorest");

@@clientName(
  AnalyzeConversationJobResult,
  "AnalyzeConversationOperationResult",
  "!autorest"
);
@@clientName(AnalyzeConversationJobResult.taskName, "Name", "!autorest");

@@clientName(
  AnalyzeConversationResultsKind,
  "AnalyzeConversationOperationResultsKind",
  "!autorest"
);
@@clientName(
  AnalyzeConversationResultsKind.ConversationalSummarizationResults,
  "SummarizationOperationResults",
  "!autorest"
);
@@clientName(
  AnalyzeConversationResultsKind.ConversationalPIIResults,
  "PiiOperationResults",
  "!autorest"
);
@@clientName(
  AnalyzeConversationResultsKind.CustomConversationalSummarizationResults,
  "CustomSummarizationOperationResults",
  "!autorest"
);

@@clientName(
  AnalyzeConversationConversationPiiResult,
  "ConversationPiiOperationResult",
  "!autorest"
);
@@clientName(
  AnalyzeConversationSummarizationResult,
  "SummarizationOperationResult",
  "!autorest"
);
@@clientName(
  AnalyzeCustomConversationSummarizationResult,
  "CustomSummarizationOperationResult",
  "!autorest"
);

@@clientName(
  analyzeConversationsSubmitJob,
  "AnalyzeConversationSubmitOperation",
  "!autorest"
);
@@clientName(analyzeConversationsSubmitJob, "AnalyzeConversationJob", "python");

@@clientName(
  analyzeConversationsJobStatus,
  "GetAnalyzeConversationJobStatus",
  "!autorest"
);

@@clientName(analyzeConversationsJobStatus, "getJobStatus", "python");

@@clientName(
  analyzeConversationsCancelJob,
  "CancelAnalyzeConversations",
  "!autorest"
);

@@clientName(analyzeConversationsCancelJob, "cancelJob", "python");

@@clientName(
  ConversationalPiiResultWithResultBase,
  "ConversationalPiiResult",
  "!autorest"
);
