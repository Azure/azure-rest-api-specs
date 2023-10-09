import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Language.AnalyzeText;


@added(Versions.v2023_04_15_preview)
@doc("Supported parameters for a custom Healthcare task.")
model CustomHealthcareTaskParameters extends CustomTaskParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType: StringIndexType
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomHealthcareLROTask extends AnalyzeTextLROTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" 
  kind: AnalyzeTextLROTaskKind.CustomHealthcare;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: CustomHealthcareTaskParameters;
} 

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomHealthcareResult extends CustomResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  documents: Array<CustomHealthcareEntitiesDocumentResultWithDocumentDetectedLanguage>;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomHealthcareEntitiesDocumentResultWithDocumentDetectedLanguage extends CustomHealthcareEntitiesDocumentResult {
  ...DocumentDetectedLanguage;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomHealthcareEntitiesDocumentResult extends DocumentResult {
  @doc("Healthcare entities.")
  entities: Array<CustomHealthcareEntity>;

  @doc("Healthcare entity relations.")
  relations: Array<HealthcareRelation>;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomHealthcareEntity extends HealthcareEntity {
  @doc("(Optional) Entity component information listing fired components of the extracted entity. This object only applies for custom healthcare.")
  entityComponentInformation: Array<EntityComponentInformation>;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomHealthcareLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.CustomHealthcareLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results?: CustomHealthcareResult;
}

