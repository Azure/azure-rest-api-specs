import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.Text;

/** Supported parameters for an Extractive Summarization task. */
@added(Versions.v2023_04_01)
model ExtractiveSummarizationTaskParameters is PreBuiltTaskParameters {
  /** Specifies the number of sentences in the extracted summary. */
  sentenceCount?: int64 = 3;

  /** Specifies how to sort the extracted summaries. */
  sortBy?: ExtractiveSummarizationSortingCriteria = ExtractiveSummarizationSortingCriteria.Offset;

  /** Specifies the method used to interpret string offsets. */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  /** (Optional) If provided, the query will be used to extract most relevant sentences from the document. */
  @added(Versions.v2024_11_15_preview)
  query?: string;
}

/** An object representing the task definition for an Extractive Summarization task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_01)
model ExtractiveSummarizationLROTask extends AnalyzeTextLROTask {
  /** The Extractive Summarization kind of the long running task. */
  kind: AnalyzeTextLROTaskKind.ExtractiveSummarization;

  /** Parameters for the Extractive Summarization task. */
  parameters?: ExtractiveSummarizationTaskParameters;
}

/** An object representing the pre-built Extractive Summarization results of each document. */
@added(Versions.v2023_04_01)
model ExtractiveSummarizationResult is PreBuiltResult {
  /** Response by document */
  @added(Versions.v2023_04_01)
  @typeChangedFrom(
    Versions.v2024_11_15_preview,
    Array<ExtractedSummaryDocumentResult>
  )
  documents: Array<ExtractedSummaryDocumentResultWithDetectedLanguage>;
}

/** The sorting criteria to use for the results of Extractive Summarization. */
@added(Versions.v2023_04_01)
union ExtractiveSummarizationSortingCriteria {
  string,

  /** Indicates that results should be sorted in order of appearance in the text. */
  Offset: "Offset",

  /** Indicates that results should be sorted in order of importance (i.e. rank score) according to the model. */
  Rank: "Rank",
}

/** A ranked list of sentences representing the extracted summary. */
@added(Versions.v2023_04_01)
model ExtractedSummaryDocumentResult is DocumentResult {
  /** Specifies the the extracted sentences from the input document. */
  sentences: Array<ExtractedSummarySentence>;
}

/** A ranked list of sentences representing the extracted summary. */
@added(Versions.v2024_11_15_preview)
model ExtractedSummaryDocumentResultWithDetectedLanguage
  is ExtractedSummaryDocumentResult {
  ...DocumentDetectedLanguage;
}

/** Represents an extracted sentences from the input document. */
@added(Versions.v2023_04_01)
model ExtractedSummarySentence {
  /** The extracted sentence text. */
  text: string;

  /** A double value representing the relevance of the sentence within the summary. Higher values indicate higher importance. */
  rankScore: float64;

  /** The sentence offset from the start of the document, based on the value of the parameter StringIndexType. */
  offset: int32;

  /** The length of the sentence. */
  length: int32;
}

/** An object representing the results for an Extractive Summarization task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_01)
model ExtractiveSummarizationLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.ExtractiveSummarizationLROResults;

  /** Results of the task. */
  results: ExtractiveSummarizationResult;
}

/** An object representing the task definition for an Abstractive Summarization task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_01)
model AbstractiveSummarizationLROTask extends AnalyzeTextLROTask {
  /** The Abstractive Summarization kind of the long running task. */
  kind: AnalyzeTextLROTaskKind.AbstractiveSummarization;

  /** Parameters for the Abstractive Summarization task. */
  parameters?: AbstractiveSummarizationTaskParameters;
}

/** Supported parameters for the pre-built Abstractive Summarization task. */
@added(Versions.v2023_04_01)
model AbstractiveSummarizationTaskParameters is PreBuiltTaskParameters {
  ...AbstractiveSummarizationTaskParametersBase;

  /** (Optional) If provided, the query will be used to generate the summary. */
  @added(Versions.v2024_11_15_preview)
  instruction?: string;
}

/** An object representing the results for an Abstractive Summarization task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_01)
model AbstractiveSummarizationLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.AbstractiveSummarizationLROResults;

  /** Results of the task. */
  results: AbstractiveSummarizationResult;
}

/** An object representing the summarization results of each document. */
@added(Versions.v2023_04_01)
model AbstractiveSummarizationResultBase {
  /** Response by document */
  @added(Versions.v2023_04_01)
  @typeChangedFrom(
    Versions.v2024_11_15_preview,
    Array<AbstractiveSummaryDocumentResult>
  )
  documents: Array<AbstractiveSummaryDocumentResultWithDetectedLanguage>;
}

/** An object representing the pre-built Abstractive Summarization results of each document. */
@added(Versions.v2023_04_01)
model AbstractiveSummarizationResult is PreBuiltResult {
  ...AbstractiveSummarizationResultBase;
}

/** An object representing the pre-built Abstractive Summarization results of each document. */
@added(Versions.v2023_04_01)
model AbstractiveSummaryDocumentResult is DocumentResult {
  /** A list of abstractive summaries. */
  summaries: Array<AbstractiveSummary>;
}

/** An object representing the Abstractive Summarization result of a single document with detected language. */
@added(Versions.v2024_11_15_preview)
model AbstractiveSummaryDocumentResultWithDetectedLanguage
  is AbstractiveSummaryDocumentResult {
  ...DocumentDetectedLanguage;
}

/** An object representing a single summary with context for given document. */
@added(Versions.v2023_04_01)
model AbstractiveSummary {
  /** The text of the summary. */
  text: string;

  /** The context list of the summary. */
  contexts?: Array<SummaryContext>;
}
