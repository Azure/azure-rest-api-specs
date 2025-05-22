import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Language.Conversations;

namespace Language.ConversationsClientCustomizations;

@@clientName(Conversations, "ConversationAnalysis", "csharp");
@@clientName(analyzeConversations, "AnalyzeConversation", "csharp");

@@clientName(ConversationEntity.confidenceScore, "confidence", "csharp");
@@clientName(ConversationIntent.confidenceScore, "confidence", "csharp");
@@clientName(TargetIntentResult.confidenceScore, "confidence", "csharp");
@@clientName(KnowledgeBaseAnswer.confidenceScore, "confidence", "csharp");
@@clientName(KnowledgeBaseAnswer.id, "qnaId", "csharp");
@@clientName(KnowledgeBaseAnswer.answerSpan, "shortAnswer", "csharp");
@@clientName(KnowledgeBaseAnswer.confidenceScore, "confidence", "csharp");
@@clientName(KnowledgeBaseAnswerContext.previousUserQuery,
  "previousQuestion",
  "csharp"
);

@@clientName(AnswersOptions.confidenceScoreThreshold,
  "confidenceThreshold",
  "csharp"
);
@@clientName(AnswersOptions.context, "answerContext", "csharp");
@@clientName(AnswersOptions.rankerType, "rankerKind", "csharp");
@@clientName(AnswersOptions.answerSpanRequest, "shortAnswerOptions", "csharp");

@@clientName(ShortAnswerOptions.confidenceScoreThreshold,
  "confidenceThreshold",
  "csharp"
);
@@clientName(ShortAnswerOptions.topAnswersWithSpan, "top", "csharp");

@@clientName(AnalyzeConversationLROTask,
  "AnalyzeConversationOperationAction",
  "csharp"
);

@@clientName(AnalyzeConversationLROTask.taskName, "Name", "csharp");

@@clientName(BasePrediction, "PredictionBase", "csharp");

@@clientName(LengthUnit.Pt, "Point", "csharp");
@@clientName(LogicalOperationKind.AND, "And", "csharp");
@@clientName(LogicalOperationKind.OR, "Or", "csharp");

@@clientName(redactionCharacter.perCent, "Percent", "csharp");

@@clientName(TemporalModifier.AfterApprox, "AfterApproximate", "csharp");
@@clientName(TemporalModifier.BeforeApprox, "BeforeApproximate", "csharp");
@@clientName(TemporalModifier.Approx, "Approximate", "csharp");

@@clientName(RedactedTranscriptContent.itn, "InverseTextNormalized", "csharp");
@@clientName(RedactedTranscriptContent.maskedItn,
  "MaskedInverseTextNormalized",
  "csharp"
);
@@clientName(Error, "ConversationError", "csharp");

@@clientName(AnalysisParameters, "AnalysisConfig", "csharp");
@@clientName(LuisParameters, "LuisConfig", "csharp");
@@clientName(ConversationParameters, "ConversationConfig", "csharp");
@@clientName(QuestionAnsweringParameters, "QuestionAnsweringConfig", "csharp");
@@clientName(AnswersOptions, "QuestionAnswersConfig", "csharp");
@@clientName(ShortAnswerOptions, "ShortAnswerConfig", "csharp");
@@clientName(ConversationCallingOptions, "ConversationCallingConfig", "csharp");
@@clientName(LuisCallingOptions, "LuisCallingConfig", "csharp");

@@clientName(ConversationAnalysisOptions,
  "ConversationAnalysisInput",
  "csharp"
);

@@clientName(Tasks, "ConversationActions", "csharp");
@@clientName(State, "ConversationActionState", "csharp");
@@clientName(role, "ParticipantRole", "csharp");

@@clientName(Entity, "NamedEntity", "csharp");

@@clientName(CustomConversationSummarizationTaskParameters,
  "CustomConversationSummarizationActionContent",
  "csharp"
);

@@clientName(ConversationTaskParameters,
  "ConversationLanguageUnderstandingActionContent",
  "csharp"
);

@@clientName(ConversationSummarizationTaskParameters,
  "ConversationSummarizationActionContent",
  "csharp"
);
@@clientName(ConversationPiiTaskParameters,
  "ConversationPiiActionContent",
  "csharp"
);

@@clientName(Conversation, "ConversationInput", "csharp");

@@clientName(ConversationPiiCategories.USSocialSecurityNumber,
  "UsSocialSecurityNumber",
  "csharp"
);
@@clientName(ConversationPiiCategoriesExclude,
  "ConversationPiiCategoryExclusions",
  "csharp"
);
@@clientName(ConversationPiiCategoriesExclude.USSocialSecurityNumber,
  "UsSocialSecurityNumber",
  "csharp"
);
@@clientName(ErrorCode, "ConversationErrorCode", "csharp");

@@clientName(BaseResolution, "ResolutionBase", "csharp");
@@clientName(BaseExtraInformation,
  "ConversationEntityExtraInformation",
  "csharp"
);

@@clientName(TranscriptConversationItem.itn, "InverseTextNormalized", "csharp");
@@clientName(TranscriptConversationItem.maskedItn,
  "MaskedInverseTextNormalized",
  "csharp"
);

@@clientName(AnalyzeConversationTask, "AnalyzeConversationInput", "csharp");
@@clientName(AnalyzeConversationTaskKind,
  "AnalyzeConversationInputKind",
  "csharp"
);

@@clientName(ConversationalTask,
  "ConversationLanguageUnderstandingInput",
  "csharp"
);

@@clientName(ConversationalTask.analysisInput, "ConversationInput", "csharp");
@@clientName(ConversationalTask.parameters, "ActionContent", "csharp");
@@clientName(ConversationTaskParameters, "ConversationActionContent", "csharp");

@@clientName(AnalyzeConversationTaskResult,
  "AnalyzeConversationActionResult",
  "csharp"
);
@@clientName(AnalyzeConversationTaskResultsKind,
  "AnalyzeConversationResultKind",
  "csharp"
);

@@clientName(ConversationalTaskResult, "ConversationActionResult", "csharp");

@@clientName(MultiLanguageConversationAnalysisInput,
  "MultiLanguageConversationInput"
);

@@clientName(AnalyzeConversationJobsInput,
  "AnalyzeConversationOperationInput",
  "csharp"
);
@@clientName(AnalyzeConversationJobsInput.analysisInput,
  "ConversationInput",
  "csharp"
);
@@clientName(AnalyzeConversationJobsInput.tasks, "Actions", "csharp");

@@clientName(AnalyzeConversationLROTask, "AnalyzeConversationOperationAction");
@@clientName(AnalyzeConversationLROTask.taskName, "Name", "csharp");

@@clientName(AnalyzeConversationLROTaskKind,
  "AnalyzeConversationOperationActionKind",
  "csharp"
);

@@clientName(AnalyzeConversationPiiTask, "PiiOperationAction", "csharp");
@@clientName(AnalyzeConversationPiiTask.parameters, "ActionContent", "csharp");
@@clientName(ConversationPiiTaskParameters, "PiiActionContent", "csharp");

@@clientName(AnalyzeCustomConversationSummarizationTask,
  "CustomSummarizationOperationAction",
  "csharp"
);
@@clientName(AnalyzeCustomConversationSummarizationTask.parameters,
  "ActionContent",
  "csharp"
);
@@clientName(CustomConversationSummarizationTaskParameters,
  "CustomConversationSummarizationActionContent",
  "csharp"
);

@@clientName(AnalyzeConversationSummarizationTask,
  "SummarizationOperationAction",
  "csharp"
);
@@clientName(AnalyzeConversationSummarizationTask.parameters,
  "ActionContent",
  "csharp"
);
@@clientName(ConversationSummarizationTaskParameters,
  "ConversationSummarizationActionContent",
  "csharp"
);

@@clientName(AnalyzeConversationJobState,
  "AnalyzeConversationOperationState",
  "csharp"
);
@@clientName(AnalyzeConversationJobState.tasks, "Actions", "csharp");

@@clientName(AnalyzeConversationJobResult,
  "AnalyzeConversationOperationResult",
  "csharp"
);
@@clientName(AnalyzeConversationJobResult.taskName, "Name", "csharp");

@@clientName(AnalyzeConversationResultsKind,
  "AnalyzeConversationOperationResultsKind",
  "csharp"
);
@@clientName(AnalyzeConversationResultsKind.ConversationalSummarizationResults,
  "SummarizationOperationResults",
  "csharp"
);
@@clientName(AnalyzeConversationResultsKind.ConversationalPIIResults,
  "PiiOperationResults",
  "csharp"
);
@@clientName(AnalyzeConversationResultsKind.CustomConversationalSummarizationResults,
  "CustomSummarizationOperationResults",
  "csharp"
);

@@clientName(AnalyzeConversationConversationPiiResult,
  "ConversationPiiOperationResult",
  "csharp"
);
@@clientName(AnalyzeConversationSummarizationResult,
  "SummarizationOperationResult",
  "csharp"
);
@@clientName(AnalyzeCustomConversationSummarizationResult,
  "CustomSummarizationOperationResult",
  "csharp"
);

@@clientName(analyzeConversationsSubmitJob,
  "AnalyzeConversationSubmitOperation",
  "csharp"
);
@@clientName(analyzeConversationsJobStatus,
  "GetAnalyzeConversationJobStatus",
  "csharp"
);
@@clientName(analyzeConversationsCancelJob,
  "CancelAnalyzeConversations",
  "csharp"
);

@@clientName(ConversationalPiiResultWithResultBase,
  "ConversationalPiiResult",
  "csharp"
);
