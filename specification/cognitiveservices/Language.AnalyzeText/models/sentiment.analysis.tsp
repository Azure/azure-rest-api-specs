import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Azure.Core;

namespace Language.AnalyzeText;

@doc("Contains the analyze text SentimentAnalysis task input.")
model AnalyzeTextSentimentAnalysisInput extends AnalyzeTextTask {
  @doc("Kind of the task.")
  kind: AnalyzeTextTaskKind.SentimentAnalysis;

  @doc("Contains the input documents.")
  analysisInput?: MultiLanguageAnalysisInput;

  @doc("Sentiment Analysis task parameters.")
  parameters?: SentimentAnalysisTaskParameters;
}

@doc("Supported parameters for a Sentiment Analysis task.")
model SentimentAnalysisTaskParameters is PreBuiltTaskParameters {
  @doc("Whether to use opinion mining in the request or not.")
  opinionMining?: boolean = false;

  @doc("Specifies the method used to interpret string offsets.")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("An object representing the task definition for a Sentiment Analysis task.")
model SentimentAnalysisLROTask extends AnalyzeTextLROTask {
  @doc("The Sentiment Analysis kind of the long running task.")
  kind: AnalyzeTextLROTaskKind.SentimentAnalysis;

  @doc("Parameters for the Sentiment Analysis task.")
  parameters?: SentimentAnalysisTaskParameters;
}

@doc("Contains the analyze text SentimentAnalysis LRO task result.")
model SentimentTaskResult extends AnalyzeTextTaskResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextTaskResultsKind.SentimentAnalysisResults;

  @doc("The sentiment analysis results")
  results: SentimentResponse;
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
@doc("The predicted Sentiment for the sentence.")
union SentenceSentimentValue {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  positive: "positive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  neutral: "neutral",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  negative: "negative",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
@doc("The predicted Sentiment for the sentence.")
union TokenSentimentValue {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  positive: "positive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  mixed: "mixed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  negative: "negative",
}

@doc("Sentiment analysis results for the input documents.")
model SentimentResponse is PreBuiltResult {
  @typeChangedFrom(Versions.v2023_11_15_preview, Array<SentimentDocumentResult>)
  @doc("The sentiment analysis results for each document in the input.")
  documents: Array<SentimentDocumentResultWithDetectedLanguage>;
}

@doc("Sentiment analysis per document.")
model SentimentDocumentResultWithDetectedLanguage {
  ...SentimentDocumentResult;
  ...DocumentDetectedLanguage;
}

@doc("An object representing the pre-built Sentiment Analysis results of each document.")
model SentimentDocumentResult is DocumentResult {
  @doc("Predicted sentiment for document (Negative, Neutral, Positive, or Mixed).")
  sentiment: DocumentSentimentValue;

  @doc("The sentiment confidence score between 0 and 1 for the sentence for all classes.")
  confidenceScores: SentimentConfidenceScores;

  @doc("The document's sentences sentiment.")
  sentences: Array<SentenceSentiment>;
}

@doc("A document's sentence sentiment.")
model SentenceSentiment {
  @doc("The sentence text.")
  text: string;

  @doc("The predicted Sentiment for the sentence.")
  sentiment: SentenceSentimentValue;

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

@doc("Represents a sentence target and the assessments or target objects related to it.")
model SentenceTarget {
  @doc("The sentiment of the sentence.")
  sentiment: TokenSentimentValue;

  @doc("Represents the confidence scores across all sentiment classes: positive and negative.")
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

@doc("Represents a sentence assessment and the assessments or target objects related to it.")
model SentenceAssessment {
  @doc("The sentiment of the sentence.")
  sentiment: TokenSentimentValue;

  @doc("Represents the confidence scores across all sentiment classes: positive and negative.")
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

@doc("Represents the relation between assessments and/or targets.")
model TargetRelation {
  @doc("The JSON pointer indicating the linked object.")
  ref: string;

  @doc("The type related to the target.")
  relationType: TargetRelationType;
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
@doc("The type related to the target.")
union TargetRelationType {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  assessment: "assessment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  target: "target",
}

@doc("Represents the confidence scores across all sentiment classes: positive and negative.")
model TargetConfidenceScoreLabel {
  @doc("Confidence score for positive sentiment")
  positive: float64;

  @doc("Confidence score for negative sentiment")
  negative: float64;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the Sentiment Analysis LRO results.")
model SentimentLROResult extends AnalyzeTextLROResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind.SentimentAnalysisLROResults;

  @doc("The sentiment analysis results")
  results: SentimentResponse;
}

@doc("A document's sentence custom sentiment.")
@added(Versions.v2023_11_15_preview)
model CustomSentenceSentiment {
  @doc("The sentence text.")
  text: string;

  @doc("The predicted Sentiment for the sentence.")
  sentiment: SentenceSentimentValue;

  @doc("The sentiment confidence score between 0 and 1 for the sentence for all classes.")
  confidenceScores: SentimentConfidenceScores;

  @doc("The target offset from the start of the sentence.")
  offset: int32;

  @doc("The length of the target.")
  length: int32;
}

@doc("An object representing the Custom Sentiment Analysis results of each document.")
@added(Versions.v2023_11_15_preview)
model CustomSentimentDocumentResult is DocumentResult {
  @doc("Predicted sentiment for document (Negative, Neutral, Positive, or Mixed).")
  sentiment: DocumentSentimentValue;

  @doc("The sentiment confidence score between 0 and 1 for the sentence for all classes.")
  confidenceScores: SentimentConfidenceScores;

  @doc("The document's sentences sentiment.")
  sentences: Array<CustomSentenceSentiment>;
}

@added(Versions.v2023_11_15_preview)
@doc("Supported parameters for a Custom Sentiment Analysis task.")
model CustomSentimentAnalysisTaskParameters is CustomTaskParameters {
  @doc("Specifies the method used to interpret string offsets.")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_11_15_preview)
@doc("Use custom models to ease the process of sentiment analysis from documents like product reviews")
model CustomSentimentAnalysisLROTask extends AnalyzeTextLROTask {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROTaskKind.CustomSentimentAnalysis;

  @doc("Custom Sentiment Analysis task parameters.")
  parameters?: CustomSentimentAnalysisTaskParameters;
}

@doc("Custom Sentiment analysis results for the input documents.")
@added(Versions.v2023_11_15_preview)
model CustomSentimentAnalysisResult is CustomResult {
  @doc("The custom sentiment analysis results for each document in the input.")
  documents: Array<CustomSentimentAnalysisResultDocument>;
}

@doc("Custom Sentiment analysis result for a specific document.")
@added(Versions.v2023_11_15_preview)
model CustomSentimentAnalysisResultDocument {
  ...CustomSentimentDocumentResult;
  ...DocumentDetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Custom Sentiment Analysis Analyze Text long tunning operation result object.")
@added(Versions.v2023_11_15_preview)
model CustomSentimentAnalysisLROResult extends AnalyzeTextLROResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind.CustomSentimentAnalysisLROResults;

  @doc("Results of the task.")
  results: CustomSentimentAnalysisResult;
}
