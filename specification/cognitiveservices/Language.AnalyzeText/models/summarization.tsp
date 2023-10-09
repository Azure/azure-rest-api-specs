import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Language.AnalyzeText;

@added(Versions.v2023_04_01)
@doc("Supported parameters for an Extractive Summarization task.")
model ExtractiveSummarizationTaskParameters extends PreBuiltTaskParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  sentenceCount?: int64 = 3;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  sortBy?: ExtractiveSummarizationSortingCriteria = ExtractiveSummarizationSortingCriteria.Offset;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType?: StringIndexType;
}

@added(Versions.v2023_04_01)
#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("An object representing the task definition for an Extractive Summarization task.")
model ExtractiveSummarizationLROTask extends AnalyzeTextLROTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROTaskKind.ExtractiveSummarization;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: ExtractiveSummarizationTaskParameters;
}

@added(Versions.v2023_04_01)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ExtractiveSummarizationResult extends PreBuiltResult {
  @added(Versions.v2023_04_01)
  @doc("Response by document")
  @typeChangedFrom(Versions.v2023_04_15_preview, Array<ExtractedSummaryDocumentResult>)
  documents: Array<ExtractedSummaryDocumentResultWithDetectedLanguage>
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
model ExtractedSummaryDocumentResult extends DocumentResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  sentences: Array<ExtractedSummarySentence>;
}

@added(Versions.v2023_04_15_preview)
@doc("A ranked list of sentences representing the extracted summary.")
model ExtractedSummaryDocumentResultWithDetectedLanguage extends ExtractedSummaryDocumentResult {
  ...DocumentDetectedLanguage;
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
#suppress "@azure-tools/typespec-azure-core/casing-style"
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ExtractiveSummarizationLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.ExtractiveSummarizationLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: ExtractiveSummarizationResult;
}

@added(Versions.v2023_04_01)
#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("An object representing the task definition for an Abstractive Summarization task.")
model AbstractiveSummarizationLROTask extends AnalyzeTextLROTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROTaskKind.AbstractiveSummarization;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters: AbstractiveSummarizationTaskParameters;
}

@added(Versions.v2023_04_01)
@doc("Supported parameters for the pre-build Abstractive Summarization task.")
model AbstractiveSummarizationTaskParameters extends PreBuiltTaskParameters {
  ...AbstractiveSummarizationTaskParametersBase;
}

@added(Versions.v2023_04_01)
#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("An object representing the results for an Abstractive Summarization task.")
model AbstractiveSummarizationLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.AbstractiveSummarizationLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: AbstractiveSummarizationResult;
}

@added(Versions.v2023_04_01)
@doc("An object representing the summarization results of each document.")
model AbstractiveSummarizationResultBase {
  @added(Versions.v2023_04_01)
  @doc("Response by document")
  @typeChangedFrom(Versions.v2023_04_15_preview, Array<AbstractiveSummaryDocumentResult>)
  documents: Array<AbstractiveSummaryDocumentResultWithDetectedLanguage>;
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

@added(Versions.v2023_04_15_preview)
@doc("An object representing the summarization result of a single document with detected language.")
model AbstractiveSummaryDocumentResultWithDetectedLanguage extends AbstractiveSummaryDocumentResult {
  ...DocumentDetectedLanguage;
}

@added(Versions.v2023_04_01)
@doc("An object representing a single summary with context for given document.")
model AbstractiveSummary {
  @doc("The text of the summary.")
  text: string;

  @doc("The context list of the summary.")
  contexts?: Array<SummaryContext>;

}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("An object representing the task definition for an Custom Abstractive Summarization task.")
model CustomAbstractiveSummarizationLROTask extends AnalyzeTextLROTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROTaskKind.CustomAbstractiveSummarization;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters: CustomAbstractiveSummarizationTaskParameters;
}

@added(Versions.v2023_04_15_preview)
@doc("Supported parameters for the Custom Abstractive Summarization task.") 
model CustomAbstractiveSummarizationTaskParameters extends AbstractiveSummarizationTaskParametersBase {
  ...CustomTaskParameters;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("An object representing the results for an Custom Abstractive Summarization task.")
model CustomAbstractiveSummarizationLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.CustomAbstractiveSummarizationLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: CustomAbstractiveSummarizationResult;
}

@added(Versions.v2023_04_15_preview)
@doc("An object representing the custom summarization results of each document.")
model CustomAbstractiveSummarizationResult extends AbstractiveSummarizationResultBase {
  ...CustomResult;
}