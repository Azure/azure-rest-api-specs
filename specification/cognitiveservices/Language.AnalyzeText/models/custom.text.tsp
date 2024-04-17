import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;

/** Supported parameters for a Custom Entities task. */
model CustomEntitiesTaskParameters is CustomTaskParameters {
  /** Optional parameter to provide the string index type used to interpret string offsets. Defaults to TextElements (Graphemes). */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
/** Contains the custom text LRO task. */
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

@added(Versions.v2023_11_15_preview)
/** Contains the list of detected custom entities result for the documents along with detected language. */
model CustomEntitiesResultWithDocumentDetectedLanguage is CustomResult {
  /** Enumeration of the document results with detected language. */
  documents: Array<EntitiesDocumentResultWithDetectedLanguage>;
}

/** Supported parameters for a Custom Single Classification task. */
model CustomSingleLabelClassificationTaskParameters is CustomTaskParameters;

#suppress "@azure-tools/typespec-azure-core/casing-style"
/** Use custom models to classify text into single label taxonomy */
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

@added(Versions.v2023_11_15_preview)
/** Contains the custom label classification with detected language results. */
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

#suppress "@azure-tools/typespec-azure-core/casing-style"
/** Use custom models to classify text into multi label taxonomy */
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

#suppress "@azure-tools/typespec-azure-core/casing-style"
/** Contains the custom entity recognition job result. */
model CustomEntityRecognitionLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.CustomEntityRecognitionLROResults;

  /** List of results. */
  @typeChangedFrom(Versions.v2023_11_15_preview, CustomEntitiesResult)
  results: CustomEntitiesResultWithDocumentDetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
/** Contains the custom single label classification job result. */
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

#suppress "@azure-tools/typespec-azure-core/casing-style"
/** Contains the custom multi label classification job result. */
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

@added(Versions.v2023_11_15_preview)
/** Contains the analyze text dynamic classifications input. */
model AnalyzeTextDynamicClassificationInput extends AnalyzeTextTask {
  /** Kind of the task. */
  kind: AnalyzeTextTaskKind.DynamicClassification;

  /** Input to be analyzed. */
  analysisInput?: MultiLanguageAnalysisInput;

  /** Task parameters. */
  parameters?: DynamicClassificationTaskParameters;
}

@added(Versions.v2023_11_15_preview)
/** Contains the Dynamic Classification document result. */
model DynamicClassificationDocumentResult is DocumentResult {
  /** Array of classification results. */
  classifications: Array<ClassificationResult>;
}

@added(Versions.v2023_11_15_preview)
@discriminator("entityComponentKind")
/** This object contains information of the detected entity components. The possible component types may expand in the future. Parsing code should handle unexpected values gracefully */
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

@added(Versions.v2023_11_15_preview)
/** This object contains information of the prebuilt component of the detected entity. */
model PrebuiltComponent extends EntityComponentInformation {
  /** Kind of entity component. */
  entityComponentKind: entityComponentKind.PrebuiltComponent;

  /** The prebuilt component of an extracted entity type. */
  value?: string;
}

@added(Versions.v2023_11_15_preview)
/** This object contains information of the learned component of the detected entity. */
model LearnedComponent extends EntityComponentInformation {
  /** Kind of entity component. */
  entityComponentKind: entityComponentKind.LearnedComponent;

  /** The learned component of an extracted entity type. */
  value?: string;
}

@added(Versions.v2023_11_15_preview)
/** This object contains information of the list component of the detected entity. */
model ListComponent extends EntityComponentInformation {
  /** Kind of entity component. */
  entityComponentKind: entityComponentKind.ListComponent;

  /** The list key of an extracted entity type. */
  value?: string;
}

@added(Versions.v2023_11_15_preview)
/** Supported parameters for a Dynamic Classification task. */
model DynamicClassificationTaskParameters is PreBuiltTaskParameters {
  /** Specifies either one or multiple categories per document. Defaults to multi classification which may return more than one class for each document. */
  classificationType?: ClassificationType = ClassificationType.Multi;

  /** a list of categories to which input is classified to. */
  categories: Array<string>;
}

@added(Versions.v2023_11_15_preview)
/** Specifies either one or multiple categories per document. Defaults to multi classification which may return more than one class for each document. */
union ClassificationType {
  string,

  /** Multi selection */
  Multi: "Multi",

  /** Single selection */
  Single: "Single",
}

@added(Versions.v2023_11_15_preview)
/** Contains the Dynamic Classification result. */
model DynamicClassificationResult is PreBuiltResult {
  /** Response by document */
  documents: Array<DynamicClassificationDocumentResult>;
}

@added(Versions.v2023_11_15_preview)
/** Result for Dynamic Classification task. */
model DynamicClassificationTaskResult extends AnalyzeTextTaskResult {
  /** Kind of task result */
  kind: AnalyzeTextTaskResultsKind.DynamicClassificationResults;

  /** Results for Dynamic Classification task */
  results: DynamicClassificationResult;
}
