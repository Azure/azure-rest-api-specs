
import "@typespec/rest";
import "@typespec/http";
import "./main.tsp";
import "../Language/common.tsp";

namespace Language.AnalyzeText;

model AnalyzeTextSentimentAnalysisInput extends AnalyzeTextTask{
    kind: AnalyzeTextTaskKind.SentimentAnalysis;

    analysisInput?: MultiLanguageAnalysisInput;

    parameters?: SentimentAnalysisTaskParameters;
}

@doc("Supported parameters for a Sentiment Analysis task.")
model SentimentAnalysisTaskParameters extends PreBuiltTaskParameters{
  opinionMining?: boolean = false;

  stringIndexType?: StringIndexType
}

@doc("An object representing the task definition for a Sentiment Analysis task.")
model SentimentAnalysisLROTask extends AnalyzeTextLROTask {
  kind: AnalyzeTextLROTaskKind.SentimentAnalysis;

  parameters?: SentimentAnalysisTaskParameters
}

model SentimentTaskResult extends AnalyzeTextTaskResult{
  kind: AnalyzeTextTaskResultsKind.SentimentAnalysisResults;

  results: SentimentResponse;
}

@doc("Sentiment analysis per document.")
model SentimentResponse extends PreBuiltResult{
  documents: Array<SentimentDocumentResult>;
}

model SentimentDocumentResult extends DocumentResult {
  @doc("Predicted sentiment for document (Negative, Neutral, Positive, or Mixed).")
  sentiment: Sentiment;

  confidenceScores: SentimentConfidenceScores;

  sentences: Array<SentenceSentiment>;
}


model SentenceTarget {
  sentiment: Sentiment;

  confidenceScores: SentimentConfidenceScores;

  @doc("The target offset from the start of the sentence.")
  offset: int32;

  @doc( "The length of the target.")
  length: int32;

  @doc("The target text detected.")
  text: string;

  @doc("The array of either assessment or target objects which is related to the target.")
  relations: Array<TargetRelation>
}

model SentenceAssessment {
  sentiment: Sentiment;

  confidenceScores: SentimentConfidenceScores;

  @doc("The target offset from the start of the sentence.")
  offset: int32;

  @doc( "The length of the target.")
  length: int32;

  @doc("The target text detected.")
  text: string;

  @doc("The indicator representing if the assessment is negated.")
  isNegated: boolean;
}


model TargetRelation {
  @doc("The JSON pointer indicating the linked object.")
  ref: string;

  @doc("The type related to the target.")
  relationType: RelationType;

}

@doc("The type related to the target.")
enum RelationType {
  assessment,
  target
}

@doc("Represents the confidence scores across all sentiment classes: positive and negative.")
model TargetConfidenceScoreLabel {
  @doc("Confidence score for positive sentiment")
  positive: float64;

  @doc("Confidence score for negative sentiment")
  negative: float64;
}