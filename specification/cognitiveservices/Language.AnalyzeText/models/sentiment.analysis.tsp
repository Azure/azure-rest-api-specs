
import "@typespec/rest";
import "@typespec/http";
import "../common.tsp";
import "./common.models.tsp";

namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextSentimentAnalysisInput extends AnalyzeTextTask{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
    kind: AnalyzeTextTaskKind.SentimentAnalysis;

    #suppress "@azure-tools/typespec-azure-core/documentation-required"
    analysisInput?: MultiLanguageAnalysisInput;

    #suppress "@azure-tools/typespec-azure-core/documentation-required"
    parameters?: SentimentAnalysisTaskParameters;
}

@doc("Supported parameters for a Sentiment Analysis task.")
model SentimentAnalysisTaskParameters extends PreBuiltTaskParameters{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  opinionMining?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType?: StringIndexType
}

@doc("An object representing the task definition for a Sentiment Analysis task.")
model SentimentAnalysisLroTask extends AnalyzeTextLroTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroTaskKind.SentimentAnalysis;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: SentimentAnalysisTaskParameters
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model SentimentTaskResult extends AnalyzeTextTaskResult{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskResultsKind.SentimentAnalysisResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: SentimentResponse;
}

@doc("The predicted Sentiment for the sentence.")
enum SentimentValue {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  positive,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  neutral,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  negative
}

@doc("Sentiment analysis per document.")
model SentimentResponse extends AnalyzeTextPreBuiltResult{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  documents: Array<SentimentDocumentResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model SentimentDocumentResult extends DocumentResult {
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

  @doc("The sentiment confidence score between 0 and 1 for the sentence for all classes.",)
  confidenceScores: SentimentConfidenceScores
 }

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model SentenceTarget {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  sentiment: SentimentValue;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model SentenceAssessment {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  sentiment: SentimentValue;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model TargetRelation {
  @doc("The JSON pointer indicating the linked object.")
  ref: string;

  @doc("The type related to the target.")
  relationType: SentimentRelationType;

}

@doc("The type related to the target.")
enum SentimentRelationType {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  assessment,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  target
}

@doc("Represents the confidence scores across all sentiment classes: positive and negative.")
model TargetConfidenceScoreLabel {
  @doc("Confidence score for positive sentiment")
  positive: float64;

  @doc("Confidence score for negative sentiment")
  negative: float64;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model SentimentLroResult extends AnalyzeTextLroResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroResultsKind.SentimentAnalysisLroResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: SentimentResponse;
}