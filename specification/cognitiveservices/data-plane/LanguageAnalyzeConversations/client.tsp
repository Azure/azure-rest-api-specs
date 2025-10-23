import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Language.Conversations;

namespace Language.ConversationsClientCustomizations;

@@clientName(Conversations, "ConversationAnalysis");
@@clientName(analyzeConversations, "AnalyzeConversation");

@@clientName(ConversationEntity.confidenceScore, "confidence");
@@clientName(ConversationIntent.confidenceScore, "confidence");
@@clientName(TargetIntentResult.confidenceScore, "confidence");
@@clientName(KnowledgeBaseAnswer.confidenceScore, "confidence");
@@clientName(KnowledgeBaseAnswer.id, "qnaId");
@@clientName(KnowledgeBaseAnswer.answerSpan, "shortAnswer");
@@clientName(KnowledgeBaseAnswer.confidenceScore, "confidence");
@@clientName(KnowledgeBaseAnswerContext.previousUserQuery, "previousQuestion");

@@clientName(AnswersOptions.confidenceScoreThreshold, "confidenceThreshold");
@@clientName(AnswersOptions.context, "answerContext");
@@clientName(AnswersOptions.rankerType, "rankerKind");
@@clientName(AnswersOptions.answerSpanRequest, "shortAnswerOptions");

@@clientName(ShortAnswerOptions.confidenceScoreThreshold,
  "confidenceThreshold"
);
@@clientName(ShortAnswerOptions.topAnswersWithSpan, "top");

@@clientName(AnalyzeConversationLROTask, "AnalyzeConversationOperationAction");

@@clientName(AnalyzeConversationLROTask.taskName, "Name");

@@clientName(BasePrediction, "PredictionBase");

@@clientName(LengthUnit.Pt, "Point");
@@clientName(LogicalOperationKind.AND, "And");
@@clientName(LogicalOperationKind.OR, "Or");

@@clientName(redactionCharacter.perCent, "Percent");

@@clientName(TemporalModifier.AfterApprox, "AfterApproximate");
@@clientName(TemporalModifier.BeforeApprox, "BeforeApproximate");
@@clientName(TemporalModifier.Approx, "Approximate");

@@clientName(RedactedTranscriptContent.itn, "InverseTextNormalized");
@@clientName(RedactedTranscriptContent.maskedItn,
  "MaskedInverseTextNormalized"
);
@@clientName(Error, "ConversationError");

@@clientName(AnalysisParameters, "AnalysisConfig");
@@clientName(LuisParameters, "LuisConfig");
@@clientName(ConversationParameters, "ConversationConfig");
@@clientName(QuestionAnsweringParameters, "QuestionAnsweringConfig");
@@clientName(AnswersOptions, "QuestionAnswersConfig");
@@clientName(ShortAnswerOptions, "ShortAnswerConfig");
@@clientName(ConversationCallingOptions, "ConversationCallingConfig");
@@clientName(LuisCallingOptions, "LuisCallingConfig");

@@clientName(ConversationAnalysisOptions, "ConversationAnalysisInput");

@@clientName(Tasks, "ConversationActions");
@@clientName(Tasks.items, "taskResults", "python");
@@clientName(State, "ConversationActionState");
@@clientName(role, "ParticipantRole");
@@clientName(NoneLinkedTargetIntentResult,
  "NonLinkedTargetIntentResult",
  "python"
);

@@clientName(Entity, "NamedEntity");

@@clientName(CustomConversationSummarizationTaskParameters,
  "CustomConversationSummarizationActionContent"
);

@@clientName(ConversationTaskParameters,
  "ConversationLanguageUnderstandingActionContent"
);

@@clientName(ConversationTaskParameters, "ConversationActionContent", "python");

@@clientName(ConversationalAIInputParameters,
  "AIConversationLanguageUnderstandingActionContent"
);
@@clientName(ConversationalAIInputParameters,
  "ConversationalAIActionContent",
  "python"
);

@@clientName(ConversationSummarizationTaskParameters,
  "ConversationSummarizationActionContent"
);
@@clientName(ConversationPiiTaskParameters, "ConversationPiiActionContent");

@@clientName(Conversation, "ConversationInput");

@@clientName(ConversationPiiCategoriesExclude.USSocialSecurityNumber,
  "UsSocialSecurityNumber"
);
@@clientName(ConversationPiiCategoriesExclude,
  "ConversationPiiCategoryExclusions"
);
@@clientName(ConversationPiiCategoriesExclude.USSocialSecurityNumber,
  "UsSocialSecurityNumber"
);
@@clientName(ErrorCode, "ConversationErrorCode");

@@clientName(BaseResolution, "ResolutionBase");
@@clientName(BaseExtraInformation, "ConversationEntityExtraInformation");

@@clientName(TranscriptConversationItem.itn, "InverseTextNormalized");
@@clientName(TranscriptConversationItem.maskedItn,
  "MaskedInverseTextNormalized"
);

@@clientName(AnalyzeConversationTask, "AnalyzeConversationInput");
@@clientName(AnalyzeConversationTaskKind, "AnalyzeConversationInputKind");

@@clientName(ConversationalTask, "ConversationLanguageUnderstandingInput");

@@clientName(ConversationalTask.analysisInput, "ConversationInput");
@@clientName(ConversationalTask.parameters, "ActionContent");

@@clientName(AnalyzeConversationTaskResult, "AnalyzeConversationActionResult");
@@clientName(AnalyzeConversationTaskResultsKind,
  "AnalyzeConversationResultKind"
);

@@clientName(ConversationalTaskResult, "ConversationActionResult");

@@clientName(MultiLanguageConversationAnalysisInput,
  "MultiLanguageConversationInput"
);

@@clientName(AnalyzeConversationJobsInput, "AnalyzeConversationOperationInput");
@@clientName(AnalyzeConversationJobsInput.analysisInput, "ConversationInput");
@@clientName(AnalyzeConversationJobsInput.tasks, "Actions");

@@clientName(AnalyzeConversationLROTask, "AnalyzeConversationOperationAction");
@@clientName(AnalyzeConversationLROTask.taskName, "Name");

@@clientName(AnalyzeConversationLROTaskKind,
  "AnalyzeConversationOperationActionKind"
);

@@clientName(AnalyzeConversationPiiTask, "PiiOperationAction");
@@clientName(AnalyzeConversationPiiTask.parameters, "ActionContent");

@@clientName(AnalyzeCustomConversationSummarizationTask,
  "CustomSummarizationOperationAction"
);
@@clientName(AnalyzeCustomConversationSummarizationTask.parameters,
  "ActionContent"
);

@@clientName(AnalyzeConversationSummarizationTask,
  "SummarizationOperationAction"
);
@@clientName(AnalyzeConversationSummarizationTask.parameters, "ActionContent");

@@clientName(AnalyzeConversationJobState, "AnalyzeConversationOperationState");
@@clientName(AnalyzeConversationJobState.tasks, "Actions");

@@clientName(AnalyzeConversationJobResult,
  "AnalyzeConversationOperationResult"
);
@@clientName(AnalyzeConversationJobResult.taskName, "Name");

@@clientName(AnalyzeConversationResultsKind,
  "AnalyzeConversationOperationResultsKind"
);
@@clientName(AnalyzeConversationResultsKind.ConversationalSummarizationResults,
  "SummarizationOperationResults"
);
@@clientName(AnalyzeConversationResultsKind.ConversationalPIIResults,
  "PiiOperationResults"
);
@@clientName(AnalyzeConversationResultsKind.CustomConversationalSummarizationResults,
  "CustomSummarizationOperationResults"
);

@@clientName(AnalyzeConversationConversationPiiResult,
  "ConversationPiiOperationResult"
);
@@clientName(AnalyzeConversationSummarizationResult,
  "SummarizationOperationResult"
);
@@clientName(AnalyzeCustomConversationSummarizationResult,
  "CustomSummarizationOperationResult"
);

@@clientName(analyzeConversationsSubmitJob,
  "AnalyzeConversationSubmitOperation"
);
@@clientName(analyzeConversationsSubmitJob, "AnalyzeConversationJob", "python");

@@clientName(analyzeConversationsJobStatus, "GetAnalyzeConversationJobStatus");

@@clientName(analyzeConversationsJobStatus, "getJobStatus", "python");

@@clientName(analyzeConversationsCancelJob, "CancelAnalyzeConversations");

@@clientName(analyzeConversationsCancelJob, "cancelJob", "python");

@@clientName(ConversationalPiiResultWithResultBase, "ConversationalPiiResult");
