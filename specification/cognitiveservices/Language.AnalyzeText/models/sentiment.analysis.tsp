import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Azure.Core;

namespace Language.Text;

/** Contains the analyze text SentimentAnalysis task input. */
model AnalyzeTextSentimentAnalysisInput extends AnalyzeTextTask {
  /** Kind of the task. */
  kind: AnalyzeTextTaskKind.SentimentAnalysis;

  /** Contains the input documents. */
  analysisInput?: MultiLanguageAnalysisInput;

  /** Sentiment Analysis task parameters. */
  parameters?: SentimentAnalysisTaskParameters;
}

/** Supported parameters for a Sentiment Analysis task. */
model SentimentAnalysisTaskParameters is PreBuiltTaskParameters {
  /** Whether to use opinion mining in the request or not. */
  opinionMining?: boolean = false;

  /** Specifies the method used to interpret string offsets. */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

/** An object representing the task definition for a Sentiment Analysis task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model SentimentAnalysisLROTask extends AnalyzeTextLROTask {
  /** The Sentiment Analysis kind of the long running task. */
  kind: AnalyzeTextLROTaskKind.SentimentAnalysis;

  /** Parameters for the Sentiment Analysis task. */
  parameters?: SentimentAnalysisTaskParameters;
}

/** Contains the analyze text SentimentAnalysis LRO task result. */
model SentimentTaskResult extends AnalyzeTextTaskResult {
  /** Kind of the task. */
  kind: AnalyzeTextTaskResultsKind.SentimentAnalysisResults;

  /** The sentiment analysis results */
  results: SentimentResponse;
}

/** The predicted Sentiment for the sentence. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
union SentenceSentimentValue {
  /** Positive sentiment */
  positive: "positive",

  /** Neutral sentiment */
  neutral: "neutral",

  /** Negative sentiment */
  negative: "negative",
}

/** The predicted Sentiment for the sentence. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
union TokenSentimentValue {
  /** Positive sentiment */
  positive: "positive",

  /** Mixed sentiment */
  mixed: "mixed",

  /** Negative sentiment */
  negative: "negative",
}

/** Sentiment analysis results for the input documents. */
model SentimentResponse is PreBuiltResult {
  /** The sentiment analysis results for each document in the input. */
  @typeChangedFrom(Versions.v2023_11_15_preview, Array<SentimentDocumentResult>)
  documents: Array<SentimentDocumentResultWithDetectedLanguage>;
}

/** Sentiment analysis per document. */
model SentimentDocumentResultWithDetectedLanguage {
  ...SentimentDocumentResult;
  ...DocumentDetectedLanguage;
}

/** An object representing the pre-built Sentiment Analysis results of each document. */
model SentimentDocumentResult is DocumentResult {
  /** Predicted sentiment for document (Negative, Neutral, Positive, or Mixed). */
  sentiment: DocumentSentimentValue;

  /** The sentiment confidence score between 0 and 1 for the sentence for all classes. */
  confidenceScores: SentimentConfidenceScores;

  /** The document's sentences sentiment. */
  sentences: Array<SentenceSentiment>;
}

/** A document's sentence sentiment. */
model SentenceSentiment {
  /** The sentence text. */
  text: string;

  /** The predicted Sentiment for the sentence. */
  sentiment: SentenceSentimentValue;

  /** The sentiment confidence score between 0 and 1 for the sentence for all classes. */
  confidenceScores: SentimentConfidenceScores;

  /** The target offset from the start of the sentence. */
  offset: int32;

  /** The length of the target. */
  length: int32;

  /** The array of sentence targets for the sentence. */
  targets?: Array<SentenceTarget>;

  /** The array of assessments for the sentence. */
  assessments?: Array<SentenceAssessment>;
}

/** Represents a sentence target and the assessments or target objects related to it. */
model SentenceTarget {
  /** The sentiment of the sentence. */
  sentiment: TokenSentimentValue;

  /** Represents the confidence scores across all sentiment classes: positive and negative. */
  confidenceScores: TargetConfidenceScoreLabel;

  /** The target offset from the start of the sentence. */
  offset: int32;

  /** The length of the target. */
  length: int32;

  /** The target text detected. */
  text: string;

  /** The array of either assessment or target objects which is related to the target. */
  relations: Array<TargetRelation>;
}

/** Represents a sentence assessment and the assessments or target objects related to it. */
model SentenceAssessment {
  /** The sentiment of the sentence. */
  sentiment: TokenSentimentValue;

  /** Represents the confidence scores across all sentiment classes: positive and negative. */
  confidenceScores: TargetConfidenceScoreLabel;

  /** The target offset from the start of the sentence. */
  offset: int32;

  /** The length of the target. */
  length: int32;

  /** The target text detected. */
  text: string;

  /** The indicator representing if the assessment is negated. */
  isNegated: boolean;
}

/** Represents the relation between assessments and/or targets. */
model TargetRelation {
  /** The JSON pointer indicating the linked object. */
  ref: string;

  /** The type related to the target. */
  relationType: TargetRelationType;
}

/** The type related to the target. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
union TargetRelationType {
  /** Assessment relation. */
  assessment: "assessment",

  /** Target relation. */
  target: "target",
}

/** Represents the confidence scores across all sentiment classes: positive and negative. */
model TargetConfidenceScoreLabel {
  /** Confidence score for positive sentiment */
  positive: float64;

  /** Confidence score for negative sentiment */
  negative: float64;
}

/** Contains the Sentiment Analysis LRO results. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model SentimentLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.SentimentAnalysisLROResults;

  /** The sentiment analysis results */
  results: SentimentResponse;
}

/** A document's sentence custom sentiment. */
@added(Versions.v2023_11_15_preview)
model CustomSentenceSentiment {
  /** The sentence text. */
  text: string;

  /** The predicted Sentiment for the sentence. */
  sentiment: SentenceSentimentValue;

  /** The sentiment confidence score between 0 and 1 for the sentence for all classes. */
  confidenceScores: SentimentConfidenceScores;

  /** The target offset from the start of the sentence. */
  offset: int32;

  /** The length of the target. */
  length: int32;
}

/** An object representing the Custom Sentiment Analysis results of each document. */
@added(Versions.v2023_11_15_preview)
model CustomSentimentDocumentResult is DocumentResult {
  /** Predicted sentiment for document (Negative, Neutral, Positive, or Mixed). */
  sentiment: DocumentSentimentValue;

  /** The sentiment confidence score between 0 and 1 for the sentence for all classes. */
  confidenceScores: SentimentConfidenceScores;

  /** The document's sentences sentiment. */
  sentences: Array<CustomSentenceSentiment>;
}

/** Supported parameters for a Custom Sentiment Analysis task. */
@added(Versions.v2023_11_15_preview)
model CustomSentimentAnalysisTaskParameters is CustomTaskParameters {
  /** Specifies the method used to interpret string offsets. */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

/** Use custom models to ease the process of sentiment analysis from documents like product reviews */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_11_15_preview)
model CustomSentimentAnalysisLROTask extends AnalyzeTextLROTask {
  /** Kind of the task. */
  kind: AnalyzeTextLROTaskKind.CustomSentimentAnalysis;

  /** Custom Sentiment Analysis task parameters. */
  parameters?: CustomSentimentAnalysisTaskParameters;
}

/** Custom Sentiment analysis results for the input documents. */
@added(Versions.v2023_11_15_preview)
model CustomSentimentAnalysisResult is CustomResult {
  /** The custom sentiment analysis results for each document in the input. */
  documents: Array<CustomSentimentAnalysisResultDocument>;
}

/** Custom Sentiment analysis result for a specific document. */
@added(Versions.v2023_11_15_preview)
model CustomSentimentAnalysisResultDocument {
  ...CustomSentimentDocumentResult;
  ...DocumentDetectedLanguage;
}

/** Custom Sentiment Analysis Analyze Text long tunning operation result object. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_11_15_preview)
model CustomSentimentAnalysisLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.CustomSentimentAnalysisLROResults;

  /** Results of the task. */
  results: CustomSentimentAnalysisResult;
}
