import "@typespec/versioning";

using Language.Text;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.Text;
/** Supported parameters for a custom Healthcare task. */
@removed(Versions.v2024_11_01)
model CustomHealthcareTaskParameters is CustomTaskParameters {
  /** Optional parameter to provide the string index type used to interpret string offsets. Defaults to TextElements (Graphemes). */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

/** Contains the custom healthcare task definition. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@removed(Versions.v2024_11_01)
model CustomHealthcareLROTask extends AnalyzeTextLROTask {
  /** Kind of the task. */
  kind: AnalyzeTextLROTaskKind.CustomHealthcare;

  /** Contains the custom healthcare task parameters. */
  parameters?: CustomHealthcareTaskParameters;
}

/** Contains the custom healthcare result for the request. */
@removed(Versions.v2024_11_01)
model CustomHealthcareResult is CustomResult {
  /** List of custom healthcare results for the document. */
  documents: Array<CustomHealthcareEntitiesDocumentResultWithDocumentDetectedLanguage>;
}

/** Contains the document custom healthcare results with detected language. */
@removed(Versions.v2024_11_01)
model CustomHealthcareEntitiesDocumentResultWithDocumentDetectedLanguage
  is CustomHealthcareEntitiesDocumentResult {
  ...DocumentDetectedLanguage;
}

/** Contains the document custom healthcare results. */
@removed(Versions.v2024_11_01)
model CustomHealthcareEntitiesDocumentResult is DocumentResult {
  /** Healthcare entities. */
  entities: Array<CustomHealthcareEntity>;

  /** Healthcare entity relations. */
  relations: Array<HealthcareRelation>;
}

/** Contains the custom healthcare entity. */
@removed(Versions.v2024_11_01)
model CustomHealthcareEntity is HealthcareEntity {
  /** (Optional) Entity component information listing fired components of the extracted entity. This object only applies for custom healthcare. */
  entityComponentInformation?: Array<EntityComponentInformation>;
}

/** Contains the custom healthcare job result. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@removed(Versions.v2024_11_01)
model CustomHealthcareLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.CustomHealthcareLROResults;

  /** Contains the list of document results. */
  results: CustomHealthcareResult;
}
