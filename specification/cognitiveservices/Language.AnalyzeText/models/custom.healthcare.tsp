import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;
@added(Versions.v2023_04_15_preview)
@clientName("CustomHealthcareTaskContent", "csharp")
@doc("Supported parameters for a custom Healthcare task.")
model CustomHealthcareTaskParameters is CustomTaskParameters {
  @doc("Optional parameter to provide the string index type used to interpret string offsets. Defaults to TextElements (Graphemes).")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the custom healthcare task definition.")
@added(Versions.v2023_04_15_preview)
model CustomHealthcareLROTask extends AnalyzeTextLROTask {
  kind: AnalyzeTextLROTaskKind.CustomHealthcare;
  @doc("Contains the custom healthcare task parameters.")
  parameters?: CustomHealthcareTaskParameters;
}

@added(Versions.v2023_04_15_preview)
@doc("Contains the custom healthcare result for the request.")
model CustomHealthcareResult is CustomResult {
  @doc("List of custom healthcare results for the document.")
  documents: Array<CustomHealthcareEntitiesDocumentResultWithDocumentDetectedLanguage>;
}

@added(Versions.v2023_04_15_preview)
@doc("Contains the document custom healthcare results with detected language.")
model CustomHealthcareEntitiesDocumentResultWithDocumentDetectedLanguage
  is CustomHealthcareEntitiesDocumentResult {
  ...DocumentDetectedLanguage;
}

@added(Versions.v2023_04_15_preview)
@doc("Contains the document custom healthcare results.") 
model CustomHealthcareEntitiesDocumentResult is DocumentResult {
  @doc("Healthcare entities.")
  entities: Array<CustomHealthcareEntity>;

  @doc("Healthcare entity relations.")
  relations: Array<HealthcareRelation>;
}

@doc("Contains the custom healthcare entity.") 
@added(Versions.v2023_04_15_preview)
model CustomHealthcareEntity is HealthcareEntity {
  @doc("(Optional) Entity component information listing fired components of the extracted entity. This object only applies for custom healthcare.")
  entityComponentInformation?: Array<EntityComponentInformation>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_15_preview)
@doc("Contains the custom healthcare job result.")
model CustomHealthcareLROResult extends AnalyzeTextLROResult {
  kind: AnalyzeTextLROResultsKind.CustomHealthcareLROResults;
  @doc("Contains the list of document results.")
  results: CustomHealthcareResult;
}
