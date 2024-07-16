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
@@clientName(QuestionAnsweringParameters, "QustionAnsweringConfig", "csharp");
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
@@clientName(ConversationTaskParameters, "ConversationActionContent", "csharp");
@@clientName(ConversationSummarizationTaskParameters,
  "ConversationSummarizationActionContent",
  "csharp"
);
@@clientName(ConversationPiiTaskParameters,
  "ConversationPiiActionContent",
  "csharp"
);

@@clientName(Conversation, "ConversationInput", "csharp");

@@clientName(ConversationPiiCategoriesExclude,
  "ConversationPiiCategoryExclusions",
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

@@clientName(AnalyzeConversationLROTaskKind,
  "AnalyzeConversationOperationActionKind",
  "csharp"
);

@@clientName(AnalyzeConversationTask, "AnalyzeConversationInput", "csharp");
@@clientName(ConversationalTask, "ConversationInput", "csharp");
@@clientName(AnalyzeConversationJobsInput,
  "AnalyzeConversationOperationInput",
  "csharp"
);
@@clientName(AnalyzeConversationJobsInput.analysisInput,
  "ConversationInput",
  "csharp"
);
@@clientName(AnalyzeConversationJobsInput.tasks, "Actions", "csharp");
