import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;

@doc("Supported parameters for a Custom Entities task.")
model CustomEntitiesTaskParameters is CustomTaskParameters {
  @doc("Optional parameter to provide the string index type used to interpret string offsets. Defaults to TextElements (Graphemes).")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the custom text LRO task.")
model CustomEntitiesLROTask extends AnalyzeTextLROTask {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROTaskKind.CustomEntityRecognition;

  @doc("task parameters.")
  parameters?: CustomEntitiesTaskParameters;
}

@doc("Contains the list of detected custom entities result for the documents.")
model CustomEntitiesResult is CustomResult {
  @doc("Enumeration of the document results.")
  documents: Array<EntitiesDocumentResult>;
}

@added(Versions.v2023_11_15_preview)
@doc("Contains the list of detected custom entities result for the documents along with detected language.")
model CustomEntitiesResultWithDocumentDetectedLanguage is CustomResult {
  @doc("Enumeration of the document results with detected language.")
  documents: Array<EntitiesDocumentResultWithDetectedLanguage>;
}

@doc("Supported parameters for a Custom Single Classification task.")
model CustomSingleLabelClassificationTaskParameters is CustomTaskParameters;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Use custom models to classify text into single label taxonomy")
model CustomSingleLabelClassificationLROTask extends AnalyzeTextLROTask {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROTaskKind.CustomSingleLabelClassification;

  @doc("Task parameters")
  parameters?: CustomSingleLabelClassificationTaskParameters;
}

@doc("Contains the custom label classification results.")
model CustomLabelClassificationResult is CustomResult {
  @doc("Response by document")
  documents: Array<ClassificationDocumentResult>;
}

@added(Versions.v2023_11_15_preview)
@doc("Contains the custom label classification with detected language results.")
model CustomLabelClassificationResultWithDocumentDetectedLanguage
  is CustomResult {
  @doc("Response by document")
  documents: Array<ClassificationDocumentResultWithDetectedLanguage>;
}

@doc("Contains the classification result.")
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
  @doc("Kind of the task.")
  kind: AnalyzeTextLROTaskKind.CustomMultiLabelClassification;

  @doc("Task parameters.")
  parameters?: CustomMultiLabelClassificationTaskParameters;
}

@doc("Contains the classification doc result for the task.")
model ClassificationDocumentResult is DocumentResult {
  @doc("Contains the classification doc results for all docs.")
  class: Array<ClassificationResult>;
}

@doc("Contains the classification doc result for the task with detected language.")
model ClassificationDocumentResultWithDetectedLanguage
  is ClassificationDocumentResult {
  ...DocumentDetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the custom entity recognition job result.")
model CustomEntityRecognitionLROResult extends AnalyzeTextLROResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind.CustomEntityRecognitionLROResults;

  @doc("List of results.")
  @typeChangedFrom(Versions.v2023_11_15_preview, CustomEntitiesResult)
  results: CustomEntitiesResultWithDocumentDetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the custom single label classification job result.")
model CustomSingleLabelClassificationLROResult extends AnalyzeTextLROResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind.CustomSingleLabelClassificationLROResults;

  @doc("List of results.")
  @typeChangedFrom(
    Versions.v2023_11_15_preview,
    CustomLabelClassificationResult
  )
  results: CustomLabelClassificationResultWithDocumentDetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the custom multi label classification job result.")
model CustomMultiLabelClassificationLROResult extends AnalyzeTextLROResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind.CustomMultiLabelClassificationLROResults;

  @doc("List of results.")
  @typeChangedFrom(
    Versions.v2023_11_15_preview,
    CustomLabelClassificationResult
  )
  results: CustomLabelClassificationResultWithDocumentDetectedLanguage;
}

@added(Versions.v2023_11_15_preview)
@doc("Contains the analyze text dynamic classifications input.")
model AnalyzeTextDynamicClassificationInput extends AnalyzeTextTask {
  @doc("Kind of the task.")
  kind: AnalyzeTextTaskKind.DynamicClassification;

  @doc("Input to be analyzed.")
  analysisInput?: MultiLanguageAnalysisInput;

  @doc("Task parameters.")
  parameters?: DynamicClassificationTaskParameters;
}

@added(Versions.v2023_11_15_preview)
@doc("Contains the Dynamic Classification document result.")
model DynamicClassificationDocumentResult is DocumentResult {
  @doc("Array of classification results.")
  classifications: Array<ClassificationResult>;
}

@added(Versions.v2023_11_15_preview)
@discriminator("entityComponentKind")
@doc("This object contains information of the detected entity components. The possible component types may expand in the future. Parsing code should handle unexpected values gracefully")
model EntityComponentInformation {
  @doc("Kind of entity component.")
  entityComponentKind: entityComponentKind;
}

@doc("Kind of entity components supported.")
@added(Versions.v2023_11_15_preview)
union entityComponentKind {
  string,
  @doc("Prebuilt component")
  PrebuiltComponent: "PrebuiltComponent",
  @doc("Learned component")
  LearnedComponent: "LearnedComponent",
  @doc("List component")
  ListComponent: "ListComponent",
}

@added(Versions.v2023_11_15_preview)
@doc("This object contains information of the prebuilt component of the detected entity.")
model PrebuiltComponent extends EntityComponentInformation {
  @doc("Kind of entity component.")
  entityComponentKind: entityComponentKind.PrebuiltComponent;

  @doc("The prebuilt component of an extracted entity type.")
  value?: string;
}

@added(Versions.v2023_11_15_preview)
@doc("This object contains information of the learned component of the detected entity.")
model LearnedComponent extends EntityComponentInformation {
  @doc("Kind of entity component.")
  entityComponentKind: entityComponentKind.LearnedComponent;

  @doc("The learned component of an extracted entity type.")
  value?: string;
}

@added(Versions.v2023_11_15_preview)
@doc("This object contains information of the list component of the detected entity.")
model ListComponent extends EntityComponentInformation {
  @doc("Kind of entity component.")
  entityComponentKind: entityComponentKind.ListComponent;

  @doc("The list key of an extracted entity type.")
  value?: string;
}

@added(Versions.v2023_11_15_preview)
@doc("Supported parameters for a Dynamic Classification task.")
model DynamicClassificationTaskParameters is PreBuiltTaskParameters {
  @doc("Specifies either one or multiple categories per document. Defaults to multi classification which may return more than one class for each document.")
  classificationType?: ClassificationType = ClassificationType.Multi;

  @doc("a list of categories to which input is classified to.")
  categories: Array<string>;
}

@added(Versions.v2023_11_15_preview)
@doc("Specifies either one or multiple categories per document. Defaults to multi classification which may return more than one class for each document.")
union ClassificationType {
  string,
  @doc("Multi selection")
  Multi: "Multi",
  @doc("Single selection")
  Single: "Single",
}

@added(Versions.v2023_11_15_preview)
@doc("Contains the Dynamic Classification result.")
model DynamicClassificationResult is PreBuiltResult {
  @doc("Response by document")
  documents: Array<DynamicClassificationDocumentResult>;
}

@added(Versions.v2023_11_15_preview)
@doc("Result for Dynamic Classification task.")
model DynamicClassificationTaskResult extends AnalyzeTextTaskResult {
  @doc("Kind of task result")
  kind: AnalyzeTextTaskResultsKind.DynamicClassificationResults;

  @doc("Results for Dynamic Classification task")
  results: DynamicClassificationResult;
}
