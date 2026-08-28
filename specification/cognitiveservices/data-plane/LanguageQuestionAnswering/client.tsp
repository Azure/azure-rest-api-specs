import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Language.QuestionAnswering;

@useDependency(Versions.v2025_05_15_preview)
namespace Language.QuestionAnsweringClientCustomizations;

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
  KnowledgeBaseAnswerContext.previousUserQuery,
  "previousQuestion",
  "!autorest"
);

@@clientName(
  ShortAnswerOptions.confidenceScoreThreshold,
  "confidenceThreshold",
  "!autorest"
);
@@clientName(ShortAnswerOptions.topAnswersWithSpan, "top", "!autorest");

@@clientName(KnowledgeBaseAnswer.confidenceScore, "confidence", "!autorest");
@@clientName(KnowledgeBaseAnswer.id, "qnaId", "!autorest");
@@clientName(KnowledgeBaseAnswer.answerSpan, "shortAnswer", "!autorest");

@@clientName(AnswerSpan.confidenceScore, "confidence", "!autorest");

@@clientName(AnswersFromTextOptions.records, "textDocuments", "!autorest");

@@clientName(TextAnswer.confidenceScore, "confidence", "!autorest");
@@clientName(TextAnswer.answerSpan, "shortAnswer", "!autorest");

@client({
  name: "QuestionAnsweringClient",
  service: Language.QuestionAnswering,
})
interface QuestionAnsweringClientOperations {
  getAnswers is Language.QuestionAnswering.QuestionAnswering.getAnswers;

  getAnswersFromText is Language.QuestionAnswering.QuestionAnswering.getAnswersFromText;
}
