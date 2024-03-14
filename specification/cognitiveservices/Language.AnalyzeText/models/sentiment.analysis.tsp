import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;
using Azure.Core;

namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextSentimentAnalysisInput extends AnalyzeTextTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskKind.SentimentAnalysis;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  analysisInput?: MultiLanguageAnalysisInput;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: SentimentAnalysisTaskParameters;
}

@doc("Supported parameters for a Sentiment Analysis task.")
model SentimentAnalysisTaskParameters is PreBuiltTaskParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  opinionMining?: boolean = false;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("An object representing the task definition for a Sentiment Analysis task.")
model SentimentAnalysisLROTask extends AnalyzeTextLROTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROTaskKind.SentimentAnalysis;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: SentimentAnalysisTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model SentimentTaskResult extends AnalyzeTextTaskResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskResultsKind.SentimentAnalysisResults;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: SentimentResponse;
}

#suppress "@azure-tools/typespec-azure-core/use-extensible-enum"
@doc("The predicted Sentiment for the sentence.")
@fixed
enum SentimentValue {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  positive,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  neutral,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  negative,
}

#suppress "@azure-tools/typespec-azure-core/use-extensible-enum"
@doc("The predicted Sentiment for the sentence.")
@fixed
enum TokenSentimentValue {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  positive,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  mixed,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  negative,
}

@doc("Sentiment analysis per document.")
model SentimentResponse is PreBuiltResult {
  @typeChangedFrom(Versions.v2023_04_15_preview, Array<SentimentDocumentResult>)
  @doc("The sentiment analysis results for each document in the input.")
  documents: Array<SentimentDocumentResultWithDetectedLanguage>;
}

@doc("Sentiment analysis per document.")
model SentimentDocumentResultWithDetectedLanguage is SentimentDocumentResult {
...DocumentDetectedLanguage
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model SentimentDocumentResult is DocumentResult {
  @doc("Predicted sentiment for document (Negative, Neutral, Positive, or Mixed).")
  sentiment: Sentiment;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  confidenceScores: SentimentConfidenceScores;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  sentences: Array<SentenceSentiment>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model SentenceSentiment {
  @doc("The sentence text.")
  text: string;

  @doc("The predicted Sentiment for the sentence.")
  sentiment: SentimentValue;

  @doc("The sentiment confidence score between 0 and 1 for the sentence for all classes.")
  confidenceScores: SentimentConfidenceScores;

  @doc("The target offset from the start of the sentence.")
  offset: int32;

  @doc("The length of the target.")
  length: int32;

  @doc("The array of sentence targets for the sentence.")
  targets?: Array<SentenceTarget>;

  @doc("The array of assessments for the sentence.")
  assessments?: Array<SentenceAssessment>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model SentenceTarget {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  sentiment: SentenceTargetSentimentValue;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  confidenceScores: TargetConfidenceScoreLabel;

  @doc("The target offset from the start of the sentence.")
  offset: int32;

  @doc("The length of the target.")
  length: int32;

  @doc("The target text detected.")
  text: string;

  @doc("The array of either assessment or target objects which is related to the target.")
  relations: Array<TargetRelation>;
}

@doc("The predicted Sentiment for the sentence.")
enum SentenceTargetSentimentValue {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  positive,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  mixed,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  negative,
}


#suppress "@azure-tools/typespec-azure-core/documentation-required"
model SentenceAssessment {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  sentiment: TokenSentimentValue;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  confidenceScores: TargetConfidenceScoreLabel;

  @doc("The target offset from the start of the sentence.")
  offset: int32;

  @doc("The length of the target.")
  length: int32;

  @doc("The target text detected.")
  text: string;

  @doc("The indicator representing if the assessment is negated.")
  isNegated: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model TargetRelation {
  @doc("The JSON pointer indicating the linked object.")
  ref: string;

  @doc("The type related to the target.")
  relationType: SentimentRelationType;
}

#suppress "@azure-tools/typespec-azure-core/use-extensible-enum"
@doc("The type related to the target.")
@fixed
enum SentimentRelationType {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  assessment,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  target,
}

@doc("Represents the confidence scores across all sentiment classes: positive and negative.")
model TargetConfidenceScoreLabel {
  @doc("Confidence score for positive sentiment")
  positive: float64;

  @doc("Confidence score for negative sentiment")
  negative: float64;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
model SentimentLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.SentimentAnalysisLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: SentimentResponse;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model CustomSentenceSentiment {
  @doc("The sentence text.")
  text: string;

  @doc("The predicted Sentiment for the sentence.")
  sentiment: SentimentValue;

  @doc("The sentiment confidence score between 0 and 1 for the sentence for all classes.")
  confidenceScores: SentimentConfidenceScores;

  @doc("The target offset from the start of the sentence.")
  offset: int32;

  @doc("The length of the target.")
  length: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model CustomSentimentDocumentResult is DocumentResult {
  @doc("Predicted sentiment for document (Negative, Neutral, Positive, or Mixed).")
  sentiment: Sentiment;

  @doc("The sentiment confidence score between 0 and 1 for the sentence for all classes.")
  confidenceScores: SentimentConfidenceScores;

  sentences: Array<CustomSentenceSentiment>;
}

@added(Versions.v2023_04_15_preview)
@doc("Supported parameters for a Custom Sentiment Analysis task.")
model CustomSentimentAnalysisTaskParameters is CustomTaskParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_15_preview)
@doc("Use custom models to ease the process of sentiment analysis from documents like product reviews")
model CustomSentimentAnalysisLROTask extends AnalyzeTextLROTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROTaskKind.CustomSentimentAnalysis;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: CustomSentimentAnalysisTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model CustomSentimentAnalysisResult is CustomResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  documents: Array<CustomSentimentAnalysisResultDocument>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model CustomSentimentAnalysisResultDocument is CustomSentimentDocumentResult {
  ...DocumentDetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_15_preview)
model CustomSentimentAnalysisLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.CustomSentimentAnalysisLROResults;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: CustomSentimentAnalysisResult;
}
