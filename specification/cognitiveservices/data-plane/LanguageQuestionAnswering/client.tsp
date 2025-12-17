import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Language.QuestionAnswering;

@useDependency(Versions.v2025_05_15_preview)
namespace Language.QuestionAnsweringClientCustomizations;

@@clientName(AnswersOptions.confidenceScoreThreshold, "confidenceThreshold");
@@clientName(AnswersOptions.context, "answerContext");
@@clientName(AnswersOptions.rankerType, "rankerKind");
@@clientName(AnswersOptions.answerSpanRequest, "shortAnswerOptions");

@@clientName(KnowledgeBaseAnswerContext.previousUserQuery, "previousQuestion");

@@clientName(ShortAnswerOptions.confidenceScoreThreshold,
  "confidenceThreshold"
);
@@clientName(ShortAnswerOptions.topAnswersWithSpan, "top");

@@clientName(KnowledgeBaseAnswer.confidenceScore, "confidence");
@@clientName(KnowledgeBaseAnswer.id, "qnaId");
@@clientName(KnowledgeBaseAnswer.answerSpan, "shortAnswer");

@@clientName(AnswerSpan.confidenceScore, "confidence");

@@clientName(AnswersFromTextOptions.records, "textDocuments");

@@clientName(TextAnswer.confidenceScore, "confidence");
@@clientName(TextAnswer.answerSpan, "shortAnswer");

@client({
  name: "QuestionAnsweringClient",
  service: Language.QuestionAnswering,
})
interface QuestionAnsweringClientOperations {
  getAnswers is Language.QuestionAnswering.QuestionAnswering.getAnswers;

  getAnswersFromText is Language.QuestionAnswering.QuestionAnswering.getAnswersFromText;
}
