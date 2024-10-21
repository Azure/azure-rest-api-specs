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
  @typeChangedFrom(Versions.v2024_11_15_preview, Array<EntitiesDocumentResult>)
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
  @typeChangedFrom(
    Versions.v2024_11_15_preview,
    Array<ClassificationDocumentResult>
  )
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
  results: CustomEntitiesResult;
}

/** Contains the custom single label classification job result. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomSingleLabelClassificationLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.CustomSingleLabelClassificationLROResults;

  /** List of results. */
  results: CustomLabelClassificationResult;
}

/** Contains the custom multi label classification job result. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model CustomMultiLabelClassificationLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.CustomMultiLabelClassificationLROResults;

  /** List of results. */
  results: CustomLabelClassificationResult;
}

/** This object contains information of the detected entity components. The possible component types may expand in the future. Parsing code should handle unexpected values gracefully */
@added(Versions.v2024_11_15_preview)
@discriminator("entityComponentKind")
model EntityComponentInformation {
  /** Kind of entity component. */
  entityComponentKind: entityComponentKind;
}

/** Kind of entity components supported. */
@added(Versions.v2024_11_15_preview)
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
@added(Versions.v2024_11_15_preview)
model PrebuiltComponent extends EntityComponentInformation {
  /** Kind of entity component. */
  entityComponentKind: entityComponentKind.PrebuiltComponent;

  /** The prebuilt component of an extracted entity type. */
  value?: string;
}

/** This object contains information of the learned component of the detected entity. */
@added(Versions.v2024_11_15_preview)
model LearnedComponent extends EntityComponentInformation {
  /** Kind of entity component. */
  entityComponentKind: entityComponentKind.LearnedComponent;

  /** The learned component of an extracted entity type. */
  value?: string;
}

/** This object contains information of the list component of the detected entity. */
@added(Versions.v2024_11_15_preview)
model ListComponent extends EntityComponentInformation {
  /** Kind of entity component. */
  entityComponentKind: entityComponentKind.ListComponent;

  /** The list key of an extracted entity type. */
  value?: string;
}

/** Specifies either one or multiple categories per document. Defaults to multi classification which may return more than one class for each document. */
@added(Versions.v2024_11_15_preview)
union ClassificationType {
  string,

  /** Multi selection */
  Multi: "Multi",

  /** Single selection */
  Single: "Single",
}
