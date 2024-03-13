import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;

@doc("Supported parameters for a Custom Entities task.")
model CustomEntitiesTaskParameters is CustomTaskParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomEntitiesLROTask extends AnalyzeTextLROTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROTaskKind.CustomEntityRecognition;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: CustomEntitiesTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomEntitiesResult is CustomResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  documents: Array<EntitiesDocumentResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model CustomEntitiesResultWithDocumentDetectedLanguage is CustomResult {
  ...DocumentDetectedLanguage;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  documents: Array<EntitiesDocumentResult>;
}

@doc("Supported parameters for a Custom Single Classification task.")
model CustomSingleLabelClassificationTaskParameters is CustomTaskParameters;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Use custom models to classify text into single label taxonomy")
model CustomSingleLabelClassificationLROTask extends AnalyzeTextLROTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROTaskKind.CustomSingleLabelClassification;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: CustomSingleLabelClassificationTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomLabelClassificationResult is CustomResult {
  @doc("Response by document")
  documents: Array<ClassificationDocumentResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model CustomLabelClassificationResultWithDocumentDetectedLanguage
  is CustomLabelClassificationResult {
  ...DocumentDetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ClassificationResult {
  @doc("Classification type.")
  category: string;

  @doc("Confidence score between 0 and 1 of the recognized class.")
  confidenceScore: float64;
}

@doc("Supported parameters for a Custom Multi Classification task.")
model CustomMultiLabelClassificationTaskParameters is CustomTaskParameters;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Use custom models to classify text into multi label taxonomy")
model CustomMultiLabelClassificationLROTask extends AnalyzeTextLROTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROTaskKind.CustomMultiLabelClassification;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: CustomMultiLabelClassificationTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ClassificationDocumentResult is DocumentResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  class: Array<ClassificationResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomEntityRecognitionLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.CustomEntityRecognitionLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @typeChangedFrom(Versions.v2023_04_15_preview, CustomEntitiesResult)
  results: CustomEntitiesResultWithDocumentDetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomSingleLabelClassificationLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.CustomSingleLabelClassificationLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @typeChangedFrom(
    Versions.v2023_04_15_preview,
    CustomLabelClassificationResult
  )
  results: CustomLabelClassificationResultWithDocumentDetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomMultiLabelClassificationLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.CustomMultiLabelClassificationLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @typeChangedFrom(
    Versions.v2023_04_15_preview,
    CustomLabelClassificationResult
  )
  results: CustomLabelClassificationResultWithDocumentDetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model AnalyzeTextDynamicClassificationInput extends AnalyzeTextTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskKind.DynamicClassification;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  analysisInput?: MultiLanguageAnalysisInput;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: DynamicClassificationTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model DynamicClassificationDocumentResult is DocumentResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  classifications: Array<ClassificationResult>;
}

@added(Versions.v2023_04_15_preview)
@discriminator("entityComponentKind")
@doc("This object contains information of the detected entity components. The possible component types may expand in the future. Parsing code should handle unexpected values gracefully")
model EntityComponentInformation {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  entityComponentKind: EntityComponentKind;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
enum EntityComponentKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PrebuiltComponent,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LearnedComponent,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ListComponent,
}

@added(Versions.v2023_04_15_preview)
@doc("This object contains information of the prebuilt component of the detected entity.")
model PrebuiltComponent extends EntityComponentInformation {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  entityComponentKind: EntityComponentKind.PrebuiltComponent;

  @doc("The prebuilt component of an extracted entity type.")
  value?: string;
}

@added(Versions.v2023_04_15_preview)
@doc("This object contains information of the learned component of the detected entity.")
model LearnedComponent extends EntityComponentInformation {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  entityComponentKind: EntityComponentKind.LearnedComponent;

  @doc("The learned component of an extracted entity type.")
  value?: string;
}

@added(Versions.v2023_04_15_preview)
@doc("This object contains information of the list component of the detected entity.")
model ListComponent extends EntityComponentInformation {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  entityComponentKind: EntityComponentKind.ListComponent;

  @doc("The list key of an extracted entity type.")
  value?: string;
}

@added(Versions.v2023_04_15_preview)
@doc("Supported parameters for a Dynamic Classification task.")
model DynamicClassificationTaskParameters is PreBuiltTaskParameters {
  @doc("Specifies either one or multiple categories per document. Defaults to multi classification which may return more than one class for each document.")
  classificationType?: DynamicClassificationType = DynamicClassificationType.Multi;

  @doc("a list of categories to which input is classified to.")
  categories: Array<string>;
}

@added(Versions.v2023_04_15_preview)
@doc("Specifies either one or multiple categories per document. Defaults to multi classification which may return more than one class for each document.")
enum DynamicClassificationType {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Multi,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Single,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model DynamicClassificationResult is PreBuiltResult {
  @doc("Response by document")
  documents: Array<DynamicClassificationDocumentResult>;
}

@added(Versions.v2023_04_15_preview)
@doc("Result for Dynamic Classification task")
model DynamicClassificationTaskResult extends AnalyzeTextTaskResult {
  @doc("Kind of task result")
  kind: AnalyzeTextTaskResultsKind.DynamicClassificationResults;

  @doc("Results for Dynamic Classification task")
  results: DynamicClassificationResult;
}
