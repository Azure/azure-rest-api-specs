import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Language.AnalyzeText;

@added(Versions.v2023_04_01)
@doc("Supported parameters for an Extractive Summarization task.")
model ExtractiveSummarizationTaskParameters extends PreBuiltTaskParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  sentenceCount?: int32 = 3;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  sortBy?: ExtractiveSummarizationSortingCriteria = ExtractiveSummarizationSortingCriteria.Offset;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType?: StringIndexType;
}

@added(Versions.v2023_04_01)
@doc("An object representing the task definition for an Extractive Summarization task.")
model ExtractiveSummarizationLroTask extends AnalyzeTextLroTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroTaskKind.ExtractiveSummarization;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: ExtractiveSummarizationTaskParameters;
}

@added(Versions.v2023_04_01)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ExtractiveSummarizationResult extends PreBuiltResult {
  @doc("Response by document")
  documents: Array<ExtractedSummaryDocumentResult>
}

@added(Versions.v2023_04_01)
@doc("The sorting criteria to use for the results of Extractive Summarization.")
enum ExtractiveSummarizationSortingCriteria {
  @doc("Indicates that results should be sorted in order of appearance in the text.")
  Offset,

  @doc("Indicates that results should be sorted in order of importance (i.e. rank score) according to the model.")
  Rank,
}

@added(Versions.v2023_04_01)
@doc("A ranked list of sentences representing the extracted summary.")
model ExtractedSummaryDocumentResult extends DocumentResult{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  sentences: Array<ExtractedSummarySentence>;
}

@added(Versions.v2023_04_01)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ExtractedSummarySentence {
  @doc("The extracted sentence text.")
  text: string;

  @doc("A double value representing the relevance of the sentence within the summary. Higher values indicate higher importance.")
  rankScore: float64;

  @doc("The sentence offset from the start of the document, based on the value of the parameter StringIndexType.")
  offset: int32;

  @doc("The length of the sentence.")
  length: int32;
}

@added(Versions.v2023_04_01)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ExtractiveSummarizationLroResult extends AnalyzeTextLroResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroResultsKind.ExtractiveSummarizationLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: ExtractiveSummarizationResult;
}

@added(Versions.v2023_04_01)
@doc("An object representing the task definition for an Abstractive Summarization task.")
model AbstractiveSummarizationLroTask extends AnalyzeTextLroTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroTaskKind.AbstractiveSummarization;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters: AbstractiveSummarizationTaskParameters;
}

@added(Versions.v2023_04_01)
@doc("Supported parameters for the pre-build Abstractive Summarization task.")
model AbstractiveSummarizationTaskParameters extends PreBuiltTaskParameters{
  ...AbstractiveSummarizationTaskParametersBase;
}

@added(Versions.v2023_04_01)
@doc("An object representing the results for an Abstractive Summarization task.")
model AbstractiveSummarizationLroResult extends AnalyzeTextLroResult{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroResultsKind.AbstractiveSummarizationLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: AbstractiveSummarizationResult;
}

@added(Versions.v2023_04_01)
@doc("An object representing the summarization results of each document.")
model AbstractiveSummarizationResultBase {
  @doc("Response by document")
  documents: Array<AbstractiveSummaryDocumentResult>;
}

@added(Versions.v2023_04_01)
@doc("An object representing the pre-build summarization results of each document.")
model AbstractiveSummarizationResult extends PreBuiltResult {
  ... AbstractiveSummarizationResultBase;
}

@added(Versions.v2023_04_01)
@doc("An object representing the pre-build summarization results of each document.")
model AbstractiveSummaryDocumentResult extends DocumentResult {
  @doc("A list of abstractive summaries.",)
  summaries: AbstractiveSummary;
}

@added(Versions.v2023_04_01)
@doc("An object representing a single summary with context for given document.")
model AbstractiveSummary {
  @doc("The text of the summary.")
  text: string;

  @doc("The context list of the summary.")
  contexts?: Array<SummaryContext>;

}