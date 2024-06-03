import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;

/** Contains the analyze text Entity linking input. */
model AnalyzeTextEntityLinkingInput extends AnalyzeTextTask {
  /** Kind for Entity linking input. */
  kind: AnalyzeTextTaskKind.EntityLinking;

  /** Contains the analysis input to be handled by the service. */
  analysisInput?: MultiLanguageAnalysisInput;

  /** Task parameters. */
  parameters?: EntityLinkingTaskParameters;
}

/** Supported parameters for an Entity Linking task. */
model EntityLinkingTaskParameters is PreBuiltTaskParameters {
  /** Optional parameter to provide the string index type used to interpret string offsets. Defaults to TextElements (Graphemes). */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

/** Contains the analyze text Entity linking LRO task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model EntityLinkingLROTask extends AnalyzeTextLROTask {
  /** Kind of task result */
  kind: AnalyzeTextLROTaskKind.EntityLinking;

  /** Task parameters. */
  parameters?: EntityLinkingTaskParameters;
}

/** Contains the analyze text Entity linking task result. */
model EntityLinkingTaskResult extends AnalyzeTextTaskResult {
  /** Kind of task result */
  kind: AnalyzeTextTaskResultsKind.EntityLinkingResults;

  /** Entity linking result. */
  results: EntityLinkingResult;
}

/** Entity linking result. */
model EntityLinkingResult is PreBuiltResult {
  /** Response by document */
  @typeChangedFrom(
    Versions.v2023_11_15_preview,
    Array<LinkedEntitiesDocumentResult>
  )
  documents: Array<EntityLinkingResultWithDetectedLanguage>;
}

/** Entity linking document result. */
model LinkedEntitiesDocumentResult is DocumentResult {
  /** Recognized well known entities in the document. */
  entities: Array<LinkedEntity>;
}

/** Entity linking document result with auto language detection. */
@added(Versions.v2023_11_15_preview)
model EntityLinkingResultWithDetectedLanguage {
  ...LinkedEntitiesDocumentResult;
  ...DocumentDetectedLanguage;
}

/** The LinkedEntity object containing the detected entity with the associated sources/links. */
model LinkedEntity {
  /** Entity Linking formal name. */
  name: string;

  /** List of instances this entity appears in the text. */
  matches: Array<Match>;

  /** Language used in the data source. */
  language: string;

  /** Unique identifier of the recognized entity from the data source. */
  id?: string;

  /** URL for the entity's page from the data source. */
  url: string;

  /** Data source used to extract entity linking, such as Wiki/Bing etc. */
  dataSource: string;

  /** Bing Entity Search API unique identifier of the recognized entity. */
  bingId?: string;
}

/** The Match object containing the detected entity text with the offset and the length. */
model Match {
  /** If a well known item is recognized, a decimal number denoting the confidence level between 0 and 1 will be returned. */
  confidenceScore: float64;

  /** Entity text as appears in the request. */
  text: string;

  /** Start position for the entity match text. */
  offset: int32;

  /** Length for the entity match text. */
  length: int32;
}

/** Contains the analyze text Entity linking task LRO result. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model EntityLinkingLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.EntityLinkingLROResults;

  /** Entity linking result. */
  results: EntityLinkingResult;
}
