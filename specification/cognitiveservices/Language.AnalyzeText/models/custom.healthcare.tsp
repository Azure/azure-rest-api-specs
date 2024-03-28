import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@added(Versions.v2023_04_15_preview)
@clientName("CustomHealthcareTaskContent", "csharp")
@doc("Supported parameters for a custom Healthcare task.")
model CustomHealthcareTaskParameters extends CustomTaskParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_15_preview)
model CustomHealthcareLROTask extends AnalyzeTextLROTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROTaskKind.CustomHealthcare;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: CustomHealthcareTaskParameters;
}
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model CustomHealthcareResult extends CustomResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  documents: Array<CustomHealthcareEntitiesDocumentResultWithDocumentDetectedLanguage>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model CustomHealthcareEntitiesDocumentResultWithDocumentDetectedLanguage
  is CustomHealthcareEntitiesDocumentResult {
  ...DocumentDetectedLanguage;
}
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model CustomHealthcareEntitiesDocumentResult extends DocumentResult {
  @doc("Healthcare entities.")
  entities: Array<CustomHealthcareEntity>;

  @doc("Healthcare entity relations.")
  relations: Array<HealthcareRelation>;
}
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model CustomHealthcareEntity extends HealthcareEntity {
  @doc("(Optional) Entity component information listing fired components of the extracted entity. This object only applies for custom healthcare.")
  entityComponentInformation?: Array<EntityComponentInformation>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
@added(Versions.v2023_04_15_preview)
model CustomHealthcareLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.CustomHealthcareLROResults;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: CustomHealthcareResult;
}
