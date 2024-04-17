import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;
@added(Versions.v2023_11_15_preview)
/** Supported parameters for a custom Healthcare task. */
model CustomHealthcareTaskParameters is CustomTaskParameters {
  /** Optional parameter to provide the string index type used to interpret string offsets. Defaults to TextElements (Graphemes). */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
/** Contains the custom healthcare task definition. */
@added(Versions.v2023_11_15_preview)
model CustomHealthcareLROTask extends AnalyzeTextLROTask {
  /** Kind of the task. */
  kind: AnalyzeTextLROTaskKind.CustomHealthcare;

  /** Contains the custom healthcare task parameters. */
  parameters?: CustomHealthcareTaskParameters;
}

@added(Versions.v2023_11_15_preview)
/** Contains the custom healthcare result for the request. */
model CustomHealthcareResult is CustomResult {
  /** List of custom healthcare results for the document. */
  documents: Array<CustomHealthcareEntitiesDocumentResultWithDocumentDetectedLanguage>;
}

@added(Versions.v2023_11_15_preview)
/** Contains the document custom healthcare results with detected language. */
model CustomHealthcareEntitiesDocumentResultWithDocumentDetectedLanguage
  is CustomHealthcareEntitiesDocumentResult {
  ...DocumentDetectedLanguage;
}

@added(Versions.v2023_11_15_preview)
/** Contains the document custom healthcare results. */
model CustomHealthcareEntitiesDocumentResult is DocumentResult {
  /** Healthcare entities. */
  entities: Array<CustomHealthcareEntity>;

  /** Healthcare entity relations. */
  relations: Array<HealthcareRelation>;
}

/** Contains the custom healthcare entity. */
@added(Versions.v2023_11_15_preview)
model CustomHealthcareEntity is HealthcareEntity {
  /** (Optional) Entity component information listing fired components of the extracted entity. This object only applies for custom healthcare. */
  entityComponentInformation?: Array<EntityComponentInformation>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_11_15_preview)
/** Contains the custom healthcare job result. */
model CustomHealthcareLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.CustomHealthcareLROResults;

  /** Contains the list of document results. */
  results: CustomHealthcareResult;
}
