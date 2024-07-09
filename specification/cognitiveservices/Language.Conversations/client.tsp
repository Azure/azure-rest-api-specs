import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Language.Conversations;

namespace Language.ConversationsClientCustomizations;

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
