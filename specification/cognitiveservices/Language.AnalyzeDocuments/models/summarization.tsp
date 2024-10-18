import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.AnalyzeDocuments;

/** Supported parameters for an Extractive Summarization task. */
@added(Versions.v2023_11_15_preview)
model ExtractiveSummarizationTaskParameters is PreBuiltTaskParameters {
  /** Specifies the number of sentences in the extracted summary. */
  sentenceCount?: int64 = 3;

  /** Specifies how to sort the extracted summaries. */
  sortBy?: ExtractiveSummarizationSortingCriteria = ExtractiveSummarizationSortingCriteria.Offset;

  /** Specifies the method used to interpret string offsets. */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  /** (Optional) If provided, the query will be used to extract most relevant sentences from the document. */
  @added(Versions.v2023_11_15_preview)
  query?: string;
}

/** An object representing the task definition for an Extractive Summarization task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_11_15_preview)
model ExtractiveSummarizationLROTask extends AnalyzeDocumentsLROTask {
  /** The Extractive Summarization kind of the long running task. */
  kind: AnalyzeDocumentsLROTaskKind.ExtractiveSummarization;

  /** Parameters for the Extractive Summarization task. */
  parameters?: ExtractiveSummarizationTaskParameters;
}

/** An object representing the pre-built Extractive Summarization results of each document. */
@added(Versions.v2023_11_15_preview)
model ExtractiveSummarizationResult is PreBuiltResult {
  /** Response by document */
  @added(Versions.v2023_11_15_preview)
  @typeChangedFrom(
    Versions.v2023_11_15_preview,
    Array<ExtractedSummaryDocumentResult>
  )
  documents: Array<ExtractedSummaryDocumentResultWithDetectedLanguage>;
}

/** The sorting criteria to use for the results of Extractive Summarization. */
@added(Versions.v2023_11_15_preview)
union ExtractiveSummarizationSortingCriteria {
  string,

  /** Indicates that results should be sorted in order of appearance in the text. */
  Offset: "Offset",

  /** Indicates that results should be sorted in order of importance (i.e. rank score) according to the model. */
  Rank: "Rank",
}

/** A ranked list of sentences representing the extracted summary. */
@added(Versions.v2023_11_15_preview)
model ExtractedSummaryDocumentResult is DocumentResult {
  /** Specifies the the extracted sentences from the input document. */
  sentences: Array<ExtractedSummarySentence>;
}

/** A ranked list of sentences representing the extracted summary. */
@added(Versions.v2023_11_15_preview)
model ExtractedSummaryDocumentResultWithDetectedLanguage
  is ExtractedSummaryDocumentResult {
  ...DocumentDetectedLanguage;
}

/** Represents an extracted sentences from the input document. */
@added(Versions.v2023_11_15_preview)
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
@added(Versions.v2023_11_15_preview)
model ExtractiveSummarizationLROResult extends AnalyzeDocumentsLROResult {
  /** Kind of the task. */
  kind: AnalyzeDocumentsLROResultsKind.ExtractiveSummarizationLROResults;

  /** Results of the document task. */
  results: AnalyzeDocumentsResult;
}

/** An object representing the task definition for an Abstractive Summarization task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_11_15_preview)
model AbstractiveSummarizationLROTask extends AnalyzeDocumentsLROTask {
  /** The Abstractive Summarization kind of the long running task. */
  kind: AnalyzeDocumentsLROTaskKind.AbstractiveSummarization;

  /** Parameters for the Abstractive Summarization task. */
  parameters: AbstractiveSummarizationTaskParameters;
}

/** Supported parameters for the pre-built Abstractive Summarization task. */
@added(Versions.v2023_11_15_preview)
model AbstractiveSummarizationTaskParameters is PreBuiltTaskParameters {
  ...AbstractiveSummarizationTaskParametersBase;

  /** (Optional) If provided, the query will be used to generate the summary. */
  query?: string;
}

/** An object representing the results for an Abstractive Summarization task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AbstractiveSummarizationLROResult extends AnalyzeDocumentsLROResult {
  /** Kind of the task. */
  kind: AnalyzeDocumentsLROResultsKind.AbstractiveSummarizationLROResults;

  /** Results of the task. */
  results: AbstractiveSummarizationResult;
}

/** An object representing the summarization results of each document. */
@added(Versions.v2023_11_15_preview)
model AbstractiveSummarizationResultBase {
  /** Response by document */
  documents: Array<AbstractiveSummaryDocumentResultWithDetectedLanguage>;
}

/** An object representing the pre-built Abstractive Summarization results of each document. */
@added(Versions.v2023_11_15_preview)
model AbstractiveSummarizationResult is PreBuiltResult {
  ...AbstractiveSummarizationResultBase;
}

/** An object representing the pre-built Abstractive Summarization results of each document. */
@added(Versions.v2023_11_15_preview)
model AbstractiveSummaryDocumentResult is DocumentResult {
  /** A list of abstractive summaries. */
  summaries: Array<AbstractiveSummary>;
}

/** An object representing the Abstractive Summarization result of a single document with detected language. */
@added(Versions.v2023_11_15_preview)
model AbstractiveSummaryDocumentResultWithDetectedLanguage
  is AbstractiveSummaryDocumentResult {
  ...DocumentDetectedLanguage;
}

/** An object representing a single summary with context for given document. */
@added(Versions.v2023_11_15_preview)
model AbstractiveSummary {
  /** The text of the summary. */
  text: string;

  /** The context list of the summary. */
  contexts?: Array<SummaryContext>;
}
