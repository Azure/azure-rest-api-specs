import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Language.Text;

/** Supported parameters for a Custom Entities task. */
model CustomEntitiesTaskParameters is CustomTaskParameters {
  /** Optional parameter to provide the string index type used to interpret string offsets. Defaults to TextElements (Graphemes). */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

/** Contains the custom text LRO task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomEntitiesLROTask extends AnalyzeTextLROTask {
  /** Kind of the task. */
  kind: AnalyzeTextLROTaskKind.CustomEntityRecognition;

  /** task parameters. */
  parameters?: CustomEntitiesTaskParameters;
}

/** Contains the list of detected custom entities result for the documents. */
model CustomEntitiesResult is CustomResult {
  /** Enumeration of the document results. */
  documents: Array<EntitiesDocumentResult>;
}

/** Contains the list of detected custom entities result for the documents along with detected language. */
@added(Versions.v2023_11_15_preview)
model CustomEntitiesResultWithDocumentDetectedLanguage is CustomResult {
  /** Enumeration of the document results with detected language. */
  documents: Array<EntitiesDocumentResultWithDetectedLanguage>;
}

/** Supported parameters for a Custom Single Classification task. */
model CustomSingleLabelClassificationTaskParameters is CustomTaskParameters;

/** Use custom models to classify text into single label taxonomy */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomSingleLabelClassificationLROTask extends AnalyzeTextLROTask {
  /** Kind of the task. */
  kind: AnalyzeTextLROTaskKind.CustomSingleLabelClassification;

  /** Task parameters */
  parameters?: CustomSingleLabelClassificationTaskParameters;
}

/** Contains the custom label classification results. */
model CustomLabelClassificationResult is CustomResult {
  /** Response by document */
  documents: Array<ClassificationDocumentResult>;
}

/** Contains the custom label classification with detected language results. */
@added(Versions.v2023_11_15_preview)
model CustomLabelClassificationResultWithDocumentDetectedLanguage
  is CustomResult {
  /** Response by document */
  documents: Array<ClassificationDocumentResultWithDetectedLanguage>;
}

/** Contains the classification result. */
model ClassificationResult {
  /** Classification type. */
  category: string;

  /** Confidence score between 0 and 1 of the recognized class. */
  confidenceScore: float64;
}

/** Supported parameters for a Custom Multi Classification task. */
model CustomMultiLabelClassificationTaskParameters is CustomTaskParameters;

/** Use custom models to classify text into multi label taxonomy */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomMultiLabelClassificationLROTask extends AnalyzeTextLROTask {
  /** Kind of the task. */
  kind: AnalyzeTextLROTaskKind.CustomMultiLabelClassification;

  /** Task parameters. */
  parameters?: CustomMultiLabelClassificationTaskParameters;
}

/** Contains the classification doc result for the task. */
model ClassificationDocumentResult is DocumentResult {
  /** Contains the classification doc results for all docs. */
  class: Array<ClassificationResult>;
}

/** Contains the classification doc result for the task with detected language. */
model ClassificationDocumentResultWithDetectedLanguage
  is ClassificationDocumentResult {
  ...DocumentDetectedLanguage;
}

/** Contains the custom entity recognition job result. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomEntityRecognitionLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.CustomEntityRecognitionLROResults;

  /** List of results. */
  @typeChangedFrom(Versions.v2023_11_15_preview, CustomEntitiesResult)
  results: CustomEntitiesResultWithDocumentDetectedLanguage;
}

/** Contains the custom single label classification job result. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomSingleLabelClassificationLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.CustomSingleLabelClassificationLROResults;

  /** List of results. */
  @typeChangedFrom(
    Versions.v2023_11_15_preview,
    CustomLabelClassificationResult
  )
  results: CustomLabelClassificationResultWithDocumentDetectedLanguage;
}

/** Contains the custom multi label classification job result. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomMultiLabelClassificationLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.CustomMultiLabelClassificationLROResults;

  /** List of results. */
  @typeChangedFrom(
    Versions.v2023_11_15_preview,
    CustomLabelClassificationResult
  )
  results: CustomLabelClassificationResultWithDocumentDetectedLanguage;
}

/** Contains the analyze text dynamic classifications input. */
@added(Versions.v2023_11_15_preview)
model AnalyzeTextDynamicClassificationInput extends AnalyzeTextTask {
  /** Kind of the task. */
  kind: AnalyzeTextTaskKind.DynamicClassification;

  /** Input to be analyzed. */
  analysisInput?: MultiLanguageAnalysisInput;

  /** Task parameters. */
  parameters?: DynamicClassificationTaskParameters;
}

/** Contains the Dynamic Classification document result. */
@added(Versions.v2023_11_15_preview)
model DynamicClassificationDocumentResult is DocumentResult {
  /** Array of classification results. */
  classifications: Array<ClassificationResult>;
}

/** This object contains information of the detected entity components. The possible component types may expand in the future. Parsing code should handle unexpected values gracefully */
@added(Versions.v2023_11_15_preview)
@discriminator("entityComponentKind")
model EntityComponentInformation {
  /** Kind of entity component. */
  entityComponentKind: entityComponentKind;
}

/** Kind of entity components supported. */
@added(Versions.v2023_11_15_preview)
union entityComponentKind {
  string,

  /** Prebuilt component */
  PrebuiltComponent: "PrebuiltComponent",

  /** Learned component */
  LearnedComponent: "LearnedComponent",

  /** List component */
  ListComponent: "ListComponent",
}

/** This object contains information of the prebuilt component of the detected entity. */
@added(Versions.v2023_11_15_preview)
model PrebuiltComponent extends EntityComponentInformation {
  /** Kind of entity component. */
  entityComponentKind: entityComponentKind.PrebuiltComponent;

  /** The prebuilt component of an extracted entity type. */
  value?: string;
}

/** This object contains information of the learned component of the detected entity. */
@added(Versions.v2023_11_15_preview)
model LearnedComponent extends EntityComponentInformation {
  /** Kind of entity component. */
  entityComponentKind: entityComponentKind.LearnedComponent;

  /** The learned component of an extracted entity type. */
  value?: string;
}

/** This object contains information of the list component of the detected entity. */
@added(Versions.v2023_11_15_preview)
model ListComponent extends EntityComponentInformation {
  /** Kind of entity component. */
  entityComponentKind: entityComponentKind.ListComponent;

  /** The list key of an extracted entity type. */
  value?: string;
}

/** Supported parameters for a Dynamic Classification task. */
@added(Versions.v2023_11_15_preview)
model DynamicClassificationTaskParameters is PreBuiltTaskParameters {
  /** Specifies either one or multiple categories per document. Defaults to multi classification which may return more than one class for each document. */
  classificationType?: ClassificationType = ClassificationType.Multi;

  /** a list of categories to which input is classified to. */
  categories: Array<string>;
}

/** Specifies either one or multiple categories per document. Defaults to multi classification which may return more than one class for each document. */
@added(Versions.v2023_11_15_preview)
union ClassificationType {
  string,

  /** Multi selection */
  Multi: "Multi",

  /** Single selection */
  Single: "Single",
}

/** Contains the Dynamic Classification result. */
@added(Versions.v2023_11_15_preview)
model DynamicClassificationResult is PreBuiltResult {
  /** Response by document */
  documents: Array<DynamicClassificationDocumentResult>;
}

/** Result for Dynamic Classification task. */
@added(Versions.v2023_11_15_preview)
model DynamicClassificationTaskResult extends AnalyzeTextTaskResult {
  /** Kind of task result */
  kind: AnalyzeTextTaskResultsKind.DynamicClassificationResults;

  /** Results for Dynamic Classification task */
  results: DynamicClassificationResult;
}
