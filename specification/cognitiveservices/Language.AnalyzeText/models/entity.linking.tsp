import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextEntityLinkingInput extends AnalyzeTextTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskKind.EntityLinking;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  analysisInput?: MultiLanguageAnalysisInput;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: EntityLinkingTaskParameters;
}

@doc("Supported parameters for an Entity Linking task.")
model EntityLinkingTaskParameters extends PreBuiltTaskParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType: StringIndexType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
model EntityLinkingLROTask extends AnalyzeTextLROTask {
  kind: AnalyzeTextLROTaskKind.EntityLinking;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: EntityLinkingTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntityLinkingTaskResult extends AnalyzeTextTaskResult {
  kind: AnalyzeTextTaskResultsKind.EntityLinkingResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: Array<EntityLinkingResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntityLinkingResult extends AnalyzeTextPreBuiltResult {
  @doc("Response by document")
  @typeChangedFrom(Versions.v2023_04_15_preview, LinkedEntitiesDocumentResult)
  documents: Array<EntityLinkingResultWithDetectedLanguage>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model LinkedEntitiesDocumentResult extends DocumentResult {
  @doc("Recognized well known entities in the document.")
  entities: Array<LinkedEntity>;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntityLinkingResultWithDetectedLanguage extends LinkedEntitiesDocumentResult {
  ...DocumentDetectedLanguage
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model LinkedEntity {
  @doc("Entity Linking formal name.")
  name: string;

  @doc("List of instances this entity appears in the text.")
  matches: Array<Match>;

  @doc("Language used in the data source.")
  language: string;

  @doc("Unique identifier of the recognized entity from the data source.")
  id: string;

  @doc("URL for the entity's page from the data source.")
  url: url;

  @doc("Data source used to extract entity linking, such as Wiki/Bing etc.")
  dataSource: string;

  @doc("Bing Entity Search API unique identifier of the recognized entity.")
  bingId: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
model EntityLinkingLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.EntityLinkingLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: EntityLinkingResult;
}