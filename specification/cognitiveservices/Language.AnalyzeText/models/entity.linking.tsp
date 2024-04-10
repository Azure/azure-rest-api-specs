import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;

@doc("Contains the analyze text Entity linking input.")
model AnalyzeTextEntityLinkingInput extends AnalyzeTextTask {
  @doc("Kind for Entity linking input.")
  kind: AnalyzeTextTaskKind.EntityLinking;

  @doc("Contains the analysis input to be handled by the service.")
  analysisInput?: MultiLanguageAnalysisInput;

  @doc("Task parameters.")
  parameters?: EntityLinkingTaskParameters;
}

@doc("Supported parameters for an Entity Linking task.")
@clientName("EntityLinkingTaskContent", "csharp")
model EntityLinkingTaskParameters is PreBuiltTaskParameters {
  @doc("Optional parameter to provide the string index type used to interpret string offsets. Defaults to TextElements (Graphemes).")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the analyze text Entity linking LRO task.")
model EntityLinkingLROTask extends AnalyzeTextLROTask {
  @doc("Kind of task result")
  kind: AnalyzeTextLROTaskKind.EntityLinking;

  @doc("Task parameters.")
  parameters?: EntityLinkingTaskParameters;
}

@doc("Contains the analyze text Entity linking task result.")
model EntityLinkingTaskResult extends AnalyzeTextTaskResult {
  @doc("Kind of task result")
  kind: AnalyzeTextTaskResultsKind.EntityLinkingResults;

  @doc("Entity linking result.")
  results: EntityLinkingResult;
}

@doc("Entity linking result.")
model EntityLinkingResult is PreBuiltResult {
  @doc("Response by document")
  @typeChangedFrom(
    Versions.v2023_04_15_preview,
    Array<LinkedEntitiesDocumentResult>
  )
  documents: Array<EntityLinkingResultWithDetectedLanguage>;
}

@doc("Entity linking document result.")
model LinkedEntitiesDocumentResult is DocumentResult {
  @doc("Recognized well known entities in the document.")
  entities: Array<LinkedEntity>;
}

@doc("Entity linking document result with auto language detection.")
@added(Versions.v2023_04_15_preview)
model EntityLinkingResultWithDetectedLanguage {
  ...LinkedEntitiesDocumentResult;
  ...DocumentDetectedLanguage;
}

@doc("The LinkedEntity object containing the detected entity with the associated sources/links.")
model LinkedEntity {
  @doc("Entity Linking formal name.")
  name: string;

  @doc("List of instances this entity appears in the text.")
  matches: Array<Match>;

  @doc("Language used in the data source.")
  language: string;

  @doc("Unique identifier of the recognized entity from the data source.")
  id?: string;

  @doc("URL for the entity's page from the data source.")
  url: string;

  @doc("Data source used to extract entity linking, such as Wiki/Bing etc.")
  dataSource: string;

  @doc("Bing Entity Search API unique identifier of the recognized entity.")
  bingId?: string;
}

@doc("The Match object containing the detected entity text with the offset and the length.")
@clientName("EntityLinkingMatch", "csharp")
model Match {
  @doc("If a well known item is recognized, a decimal number denoting the confidence level between 0 and 1 will be returned.")
  confidenceScore: float64;

  @doc("Entity text as appears in the request.")
  text: string;

  @doc("Start position for the entity match text.")
  offset: int32;

  @doc("Length for the entity match text.")
  length: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the analyze text Entity linking task LRO result.")
model EntityLinkingLROResult extends AnalyzeTextLROResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind.EntityLinkingLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: EntityLinkingResult;
}
