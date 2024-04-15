import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;

@added(Versions.v2023_04_01)
@doc("Supported parameters for an Extractive Summarization task.")
model ExtractiveSummarizationTaskParameters is PreBuiltTaskParameters {
  @doc("Specifies the number of sentences in the extracted summary.")
  sentenceCount?: int64 = 3;

  @doc("Specifies how to sort the extracted summaries.")
  sortBy?: ExtractiveSummarizationSortingCriteria = ExtractiveSummarizationSortingCriteria.Offset;

  @doc("Specifies the method used to interpret string offsets.")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  @added(Versions.v2023_11_15_preview)
  @doc("(Optional) If provided, the query will be used to extract most relevant sentences from the document.")
  query?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_01)
@doc("An object representing the task definition for an Extractive Summarization task.")
model ExtractiveSummarizationLROTask extends AnalyzeTextLROTask {
  @doc("The Extractive Summarization kind of the long running task.")
  kind: AnalyzeTextLROTaskKind.ExtractiveSummarization;

  @doc("Parameters for the Extractive Summarization task.")
  parameters?: ExtractiveSummarizationTaskParameters;
}

@added(Versions.v2023_04_01)
@doc("An object representing the pre-built Extractive Summarization results of each document.")
model ExtractiveSummarizationResult is PreBuiltResult {
  @added(Versions.v2023_04_01)
  @doc("Response by document")
  @typeChangedFrom(
    Versions.v2023_11_15_preview,
    Array<ExtractedSummaryDocumentResult>
  )
  documents: Array<ExtractedSummaryDocumentResultWithDetectedLanguage>;
}

@added(Versions.v2023_04_01)
@doc("The sorting criteria to use for the results of Extractive Summarization.")
union ExtractiveSummarizationSortingCriteria {
  string,

  @doc("Indicates that results should be sorted in order of appearance in the text.")
  Offset: "Offset",

  @doc("Indicates that results should be sorted in order of importance (i.e. rank score) according to the model.")
  Rank: "Rank",
}

@added(Versions.v2023_04_01)
@doc("A ranked list of sentences representing the extracted summary.")
model ExtractedSummaryDocumentResult is DocumentResult {
  @doc("Specifies the the extracted sentences from the input document.")
  sentences: Array<ExtractedSummarySentence>;
}

@added(Versions.v2023_11_15_preview)
@doc("A ranked list of sentences representing the extracted summary.")
model ExtractedSummaryDocumentResultWithDetectedLanguage
  is ExtractedSummaryDocumentResult {
  ...DocumentDetectedLanguage;
}

@doc("Represents an extracted sentences from the input document.")
@added(Versions.v2023_04_01)
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

#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_01)
@doc("An object representing the results for an Extractive Summarization task.")
model ExtractiveSummarizationLROResult extends AnalyzeTextLROResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind.ExtractiveSummarizationLROResults;

  @doc("Results of the task.")
  results: ExtractiveSummarizationResult;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_01)
@doc("An object representing the task definition for an Abstractive Summarization task.")
model AbstractiveSummarizationLROTask extends AnalyzeTextLROTask {
  @doc("The Abstractive Summarization kind of the long running task.")
  kind: AnalyzeTextLROTaskKind.AbstractiveSummarization;

  @doc("Parameters for the Abstractive Summarization task.")
  parameters: AbstractiveSummarizationTaskParameters;
}

@added(Versions.v2023_04_01)
@doc("Supported parameters for the pre-built Abstractive Summarization task.")
model AbstractiveSummarizationTaskParameters is PreBuiltTaskParameters {
  ...AbstractiveSummarizationTaskParametersBase;

  @added(Versions.v2023_11_15_preview)
  @doc("(Optional) If provided, the query will be used to generate the summary.")
  query?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_01)
@doc("An object representing the results for an Abstractive Summarization task.")
model AbstractiveSummarizationLROResult extends AnalyzeTextLROResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind.AbstractiveSummarizationLROResults;

  @doc("Results of the task.")
  results: AbstractiveSummarizationResult;
}

@added(Versions.v2023_04_01)
@doc("An object representing the summarization results of each document.")
model AbstractiveSummarizationResultBase {
  @added(Versions.v2023_04_01)
  @doc("Response by document")
  @typeChangedFrom(
    Versions.v2023_11_15_preview,
    Array<AbstractiveSummaryDocumentResult>
  )
  documents: Array<AbstractiveSummaryDocumentResultWithDetectedLanguage>;
}

@added(Versions.v2023_04_01)
@doc("An object representing the pre-built Abstractive Summarization results of each document.")
model AbstractiveSummarizationResult is PreBuiltResult {
  ...AbstractiveSummarizationResultBase;
}

@added(Versions.v2023_04_01)
@doc("An object representing the pre-built Abstractive Summarization results of each document.")
model AbstractiveSummaryDocumentResult is DocumentResult {
  @doc("A list of abstractive summaries.")
  summaries: Array<AbstractiveSummary>;
}

@added(Versions.v2023_11_15_preview)
@doc("An object representing the Abstractive Summarization result of a single document with detected language.")
model AbstractiveSummaryDocumentResultWithDetectedLanguage
  is AbstractiveSummaryDocumentResult {
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

#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_11_15_preview)
@doc("An object representing the task definition for an Custom Abstractive Summarization task.")
model CustomAbstractiveSummarizationLROTask extends AnalyzeTextLROTask {
  @doc("The Custom Abstractive Summarization kind of the long running task.")
  kind: AnalyzeTextLROTaskKind.CustomAbstractiveSummarization;

  @doc("Parameters for the Custom Abstractive Summarization task.")
  parameters: CustomAbstractiveSummarizationTaskParameters;
}

@added(Versions.v2023_11_15_preview)
@doc("Supported parameters for the Custom Abstractive Summarization task.")
model CustomAbstractiveSummarizationTaskParameters
  is AbstractiveSummarizationTaskParametersBase {
  ...CustomTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_11_15_preview)
@doc("An object representing the results for an Custom Abstractive Summarization task.")
model CustomAbstractiveSummarizationLROResult extends AnalyzeTextLROResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind.CustomAbstractiveSummarizationLROResults;

  @doc("Results of the task.")
  results: CustomAbstractiveSummarizationResult;
}

@added(Versions.v2023_11_15_preview)
@doc("An object representing the custom summarization results of each document.")
model CustomAbstractiveSummarizationResult
  is AbstractiveSummarizationResultBase {
  ...CustomResult;
}
