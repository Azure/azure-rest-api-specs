import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Language.Conversations.Authoring;

/**
 * Represents a list of retrieved projects' metadata.
 */
@clientName("ConversationAuthoringProjectsMetadata", "csharp")
model AnalyzeConversationAuthoringProjectsMetadata {
  /**
   * The list of projects.
   */
  value: AnalyzeConversationAuthoringProjectMetadata[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents the metadata of a project.
 */
@resource("authoring/analyze-conversations/projects")
@clientName("ConversationAuthoringProjectMetadata", "csharp")
model AnalyzeConversationAuthoringProjectMetadata {
  /**
   * Represents the project creation datetime.
   */
  @clientName("createdOn", "csharp")
  createdDateTime: utcDateTime;

  /**
   * Represents the project creation datetime.
   */
  @clientName("lastModifiedOn", "csharp")
  lastModifiedDateTime: utcDateTime;

  /**
   * Represents the project last trained datetime.
   */
  @clientName("lastTrainedOn", "csharp")
  lastTrainedDateTime?: utcDateTime;

  /**
   * Represents the project last deployed datetime.
   */
  @clientName("lastDeployedOn", "csharp")
  lastDeployedDateTime?: utcDateTime;

  /**
   * Represents the project kind.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  projectKind: ProjectKind;

  /**
   * The project settings.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  settings?: AnalyzeConversationAuthoringProjectSettings;

  /**
   * The storage container name in case of conversation summarization.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @added(Versions.v2023_04_15_preview)
  storageInputContainerName?: string;

  /**
   * The new project name.
   */
  @key("projectName")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @maxLength(100)
  projectName: string;

  /**
   * Whether the project would be used for multiple languages or not.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  multilingual?: boolean;

  /**
   * The project description.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  description?: string;

  /**
   * The project language. This is BCP-47 representation of a language. For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  language: string;
}

/**
 * Represents the settings used to define the project behavior.
 */
@clientName("ConversationAuthoringProjectSettings", "csharp")
model AnalyzeConversationAuthoringProjectSettings {
  /**
   * The threshold of the intent with the highest confidence, at which the prediction will automatically be changed to "None". The value of the threshold should be between 0 and 1 inclusive.
   */
  confidenceThreshold: float32;
}

/**
 * An object containing more specific information about the error. As per Microsoft One API guidelines - https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#7102-error-condition-responses.
 */
@clientName("ConversationAuthoringInnerErrorModel", "csharp")
model InnerErrorModel {
  /**
   * One of a server-defined set of error codes.
   */
  code: InnerErrorCode;

  /**
   * Error message.
   */
  message: string;

  /**
   * Error details.
   */
  details?: Record<string>;

  /**
   * Error target.
   */
  target?: string;

  /**
   * An object containing more specific information than the current object about the error.
   */
  innererror?: InnerErrorModel;
}

/**
 * Represents the options used to create or update a project.
 */
@clientName("ConversationAuthoringCreateProjectDetails", "csharp")
model AnalyzeConversationAuthoringCreateProjectOptions {
  /**
   * Represents the project kind.
   */
  projectKind: ProjectKind;

  /**
   * The project settings.
   */
  settings?: AnalyzeConversationAuthoringProjectSettings;

  /**
   * The storage container name in case of conversation summarization.
   */
  @added(Versions.v2023_04_15_preview)
  storageInputContainerName?: string;

  /**
   * The new project name.
   */
  projectName: string;

  /**
   * Whether the project would be used for multiple languages or not.
   */
  multilingual?: boolean;

  /**
   * The project description.
   */
  description?: string;

  /**
   * The project language. This is BCP-47 representation of a language. For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  language: string;
}

/**
 * Represents the options for authorizing a project copy to the current Azure resource.
 */
@added(Versions.v2023_04_15_preview)
@clientName("ConversationAuthoringCopyAuthorizationDetails", "csharp")
model AnalyzeConversationAuthoringCopyAuthorizationOptions {
  /**
   * Represents the project kind.
   */
  projectKind: ProjectKind;

  /**
   * The name of the storage container.
   */
  storageInputContainerName?: string;

  /**
   * Whether to allow an existing project to be overwritten using the resulting copy authorization.
   */
  allowOverwrite?: boolean;
}

/**
 * Represents the options for copying an existing project to another Azure resource.
 */
@added(Versions.v2023_04_15_preview)
@clientName("ConversationAuthoringCopyProjectDetails", "csharp")
model AnalyzeConversationAuthoringCopiedProjectOptions {
  /**
   * Represents the project kind.
   */
  projectKind: ProjectKind;

  /**
   * The project name to be copied-into.
   */
  targetProjectName: string;

  /**
   * The access token.
   */
  accessToken: string;

  /**
   * The expiration of the access token.
   */
  expiresAt: utcDateTime;

  /**
   * Represents the target Azure resource ID.
   */
  targetResourceId: string;

  /**
   * Represents the target Azure resource region.
   */
  targetResourceRegion: string;
}

/**
 * Represents an exported project.
 */
@clientName("ConversationAuthoringExportedProject", "csharp")
model AnalyzeConversationAuthoringExportedProject {
  /**
   * The version of the exported file.
   */
  projectFileVersion: string;

  /**
   * Specifies the method used to interpret string offsets. For additional information see https://aka.ms/text-analytics-offsets.
   */
  stringIndexType: StringIndexType;

  /**
   * Represents the project metadata.
   */
  metadata: AnalyzeConversationAuthoringCreateProjectOptions;

  /**
   * Represents the project assets.
   */
  assets?: AnalyzeConversationAuthoringExportedProjectAssets;
}

/**
 * Represents the assets of an exported project.
 */
@discriminator("projectKind")
@clientName("ConversationAuthoringExportedProjectAsset", "csharp")
model AnalyzeConversationAuthoringExportedProjectAssets {
  /**
   * The type of project containing the assets.
   */
  projectKind: ProjectKind;
}

/**
 * Represents the options for starting a new training job.
 */
@clientName("ConversationAuthoringTrainingJobDetails", "csharp")
model AnalyzeConversationAuthoringTrainingJobOptions {
  /**
   * Represents the output model label.
   */
  modelLabel: string;

  /**
   * Represents training config version. By default, "latest" value is used which uses the latest released training config version.
   */
  trainingConfigVersion?: string;

  /**
   * Represents the mode of the training operation.
   */
  trainingMode: TrainingMode;

  /**
   * Represents the evaluation options. By default, the evaluation kind is percentage, with training split percentage as 80, and testing split percentage as 20.
   */
  evaluationOptions?: AnalyzeConversationAuthoringEvaluationOptions;

  /**
   * For customers to populate if they wish to use data generation for their model training job.
   */
  @added(Versions.v2025_05_15_preview)
  dataGenerationSettings?: AnalyzeConversationAuthoringDataGenerationSettings;
}

/**
 * Represents the options used running the evaluation.
 */
@clientName("ConversationAuthoringEvaluationDetails", "csharp")
model AnalyzeConversationAuthoringEvaluationOptions {
  /**
   * Represents the evaluation kind. By default, the evaluation kind is set to percentage.
   */
  kind?: EvaluationKind;

  /**
   * Represents the training dataset split percentage. Only needed in case the evaluation kind is percentage.
   */
  trainingSplitPercentage?: int32;

  /**
   * Represents the testing dataset split percentage. Only needed in case the evaluation kind is percentage.
   */
  testingSplitPercentage?: int32;
}

/**
 * Represents the state of a copy job.
 */
@added(Versions.v2023_04_15_preview)
@clientName("ConversationAuthoringCopyProjectState", "csharp")
@resource("copy/jobs")
@parentResource(AnalyzeConversationAuthoringProjectMetadata)
model AnalyzeConversationAuthoringCopiedProjectJobState {
  ...AnalyzeConversationAuthoringJobState;
}

/**
 * Represents a job's state.
 */
@clientName("ConversationAuthoringState", "csharp")
model AnalyzeConversationAuthoringJobState {
  /**
   * The job ID.
   */
  @key("jobId")
  @visibility(Lifecycle.Read)
  jobId: string;

  /**
   * The creation date time of the job.
   */
  @clientName("createdOn", "csharp")
  createdDateTime: utcDateTime;

  /**
   * The last date time the job was updated.
   */
  @clientName("lastUpdatedOn", "csharp")
  lastUpdatedDateTime: utcDateTime;

  /**
   * The expiration date time of the job.
   */
  @clientName("expiresOn", "csharp")
  expirationDateTime?: utcDateTime;

  /**
   * The job status.
   */
  status: JobStatus;

  /**
   * The warnings that were encountered while executing the job.
   */
  warnings?: Foundations.Error[];

  /**
   * The errors encountered while executing the job.
   */
  errors?: Foundations.Error[];
}

/**
 * Represents a list of retrieved deployments.
 */
@clientName("ConversationAuthoringProjectDeployments", "csharp")
model AnalyzeConversationAuthoringProjectDeployments {
  /**
   * The list of retrieved deployments.
   */
  value: AnalyzeConversationAuthoringProjectDeployment[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents a project deployment.
 */
@clientName("ConversationAuthoringProjectDeployment", "csharp")
@resource("deployments")
@parentResource(AnalyzeConversationAuthoringProjectMetadata)
model AnalyzeConversationAuthoringProjectDeployment {
  /**
   * Represents deployment name.
   */
  @key("deploymentName")
  @visibility(Lifecycle.Read)
  deploymentName: string;

  /**
   * Represents deployment modelId.
   */
  modelId: string;

  /**
   * Represents deployment last trained time.
   */
  @clientName("lastTrainedOn", "csharp")
  lastTrainedDateTime: utcDateTime;

  /**
   * Represents deployment last deployed time.
   */
  @clientName("lastDeployedOn", "csharp")
  lastDeployedDateTime: utcDateTime;

  /**
   * Represents deployment expiration date in the runtime.
   */
  @clientName("deploymentExpiredOn", "csharp")
  deploymentExpirationDate: plainDate;

  /**
   * Represents model training config version.
   */
  modelTrainingConfigVersion: string;

  /**
   * Represents the metadata of the assigned Azure resources.
   */
  @added(Versions.v2023_04_15_preview)
  assignedResources: AnalyzeConversationAuthoringDeploymentResource[];
}

/**
 * Represents an Azure resource assigned to a deployment.
 */
@clientName("ConversationAuthoringDeploymentResource", "csharp")
model AnalyzeConversationAuthoringDeploymentResource {
  /**
   * Represents the Azure resource Id.
   */
  resourceId: string;

  /**
   * Represents the resource region.
   */
  region: string;

  /**
   * Represents the AOAI resource assigned for data generation.
   */
  @added(Versions.v2025_05_15_preview)
  assignedAoaiResource?: AnalyzeConversationAuthoringDataGenerationConnectionInfo;
}

/**
 * Represents the options for creating or updating a project deployment.
 */
@clientName("ConversationAuthoringCreateDeploymentDetails", "csharp")
model AnalyzeConversationAuthoringCreateDeploymentOptions {
  /**
   * Represents the trained model label.
   */
  trainedModelLabel: string;

  /**
   * Represents the resource IDs to be assigned to the deployment. If provided, the deployment will be rolled out to the resources provided here as well as the original resource in which the project is created.
   */
  @added(Versions.v2023_04_15_preview)
  @removed(Versions.v2025_05_15_preview)
  assignedResourceIds?: string[];

  /**
   * Represents the resources to be assigned to the deployment. If provided, the deployment will be rolled out to the resources provided here as well as the original resource in which the project is created.
   */
  @added(Versions.v2025_05_15_preview)
  assignedResources?: AnalyzeConversationAuthoringDeploymentResource[];
}

/**
 * Represents the options for deleting a project deployment.
 */
@clientName("ConversationAuthoringDeleteDeploymentDetails", "csharp")
model AnalyzeConversationAuthoringDeleteDeploymentOptions {
  /**
   * Represents the resource IDs to delete the deployment from. If not provided, the deployment will be rolled out from all the resources it is deployed to. If provided, it will delete the deployment only from the specified assigned resources, and leave it for the rest.
   */
  assignedResourceIds?: string[];
}

/**
 * Represents the state of a deployment job.
 */
@clientName("ConversationAuthoringDeploymentState", "csharp")
@parentResource(AnalyzeConversationAuthoringProjectDeployment)
@resource("jobs")
model AnalyzeConversationAuthoringDeploymentJobState {
  ...AnalyzeConversationAuthoringJobState;
}

/**
 * Represents the state of an existing delete deployment from specific resources job.
 */
@clientName("ConversationAuthoringDeploymentDeleteFromResourcesState", "csharp")
@parentResource(AnalyzeConversationAuthoringProjectDeployment)
@resource("delete-from-resources/jobs")
model AnalyzeConversationAuthoringDeploymentDeleteFromResourcesJobState {
  ...AnalyzeConversationAuthoringJobState;
}

/**
 * Represents the state of a deployment job.
 */
@clientName("ConversationAuthoringSwapDeploymentsState", "csharp")
@parentResource(AnalyzeConversationAuthoringProjectMetadata)
@resource("deployments/swap/jobs")
model AnalyzeConversationAuthoringSwapDeploymentsJobState {
  ...AnalyzeConversationAuthoringJobState;
}

/**
 * Represents the options for swapping two deployments together.
 */
@clientName("ConversationAuthoringSwapDeploymentsDetails", "csharp")
model AnalyzeConversationAuthoringSwapDeploymentsOptions {
  /**
   * Represents the first deployment name.
   */
  firstDeploymentName: string;

  /**
   * Represents the second deployment name.
   */
  secondDeploymentName: string;
}

/**
 * Represents the state of an export job.
 */
@clientName("ConversationAuthoringExportProjectState", "csharp")
@resource("export/jobs")
@parentResource(AnalyzeConversationAuthoringProjectMetadata)
model AnalyzeConversationAuthoringExportProjectJobState {
  ...AnalyzeConversationAuthoringJobState;

  /**
   * The URL to use in order to download the exported project.
   */
  @clientName("resultUri", "csharp")
  resultUrl?: string;
}

/**
 * Represents the state of an import job.
 */
@clientName("ConversationAuthoringImportProjectState", "csharp")
@resource("import/jobs")
@parentResource(AnalyzeConversationAuthoringProjectMetadata)
model AnalyzeConversationAuthoringImportProjectJobState {
  ...AnalyzeConversationAuthoringJobState;
}

/**
 * Represents a list of retrieved trained models.
 */
@clientName("ConversationAuthoringProjectTrainedModels", "csharp")
model AnalyzeConversationAuthoringProjectTrainedModels {
  /**
   * The list of trained models.
   */
  value: AnalyzeConversationAuthoringProjectTrainedModel[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents a trained model.
 */
@clientName("ConversationAuthoringProjectTrainedModel", "csharp")
@resource("models")
@parentResource(AnalyzeConversationAuthoringProjectMetadata)
model AnalyzeConversationAuthoringProjectTrainedModel {
  /**
   * The trained model label.
   */
  @key("trainedModelLabel")
  @visibility(Lifecycle.Read)
  label: string;

  /**
   * The model ID.
   */
  modelId: string;

  /**
   * The last trained date time of the model.
   */
  @clientName("lastTrainedOn", "csharp")
  lastTrainedDateTime: utcDateTime;

  /**
   * The duration of the model's last training request in seconds.
   */
  lastTrainingDurationInSeconds: int32;

  /**
   * The model expiration date.
   */
  @clientName("modelExpiredOn", "csharp")
  modelExpirationDate: plainDate;

  /**
   * The model training config version.
   */
  modelTrainingConfigVersion: string;

  /**
   * The flag to indicate if the trained model has a snapshot ready.
   */
  hasSnapshot: boolean;
}

/**
 * Represents the state of a evaluation job.
 */
@clientName("ConversationAuthoringEvaluationState", "csharp")
@resource("evaluate/jobs")
@parentResource(AnalyzeConversationAuthoringProjectTrainedModel)
model AnalyzeConversationAuthoringEvaluationJobState {
  ...AnalyzeConversationAuthoringJobState;

  /**
   * Represents evaluation task detailed result.
   */
  result: AnalyzeConversationAuthoringEvaluationJobResult;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConversationAuthoringEvaluationJobResult", "csharp")
model AnalyzeConversationAuthoringEvaluationJobResult {
  /**
   * Represents the options used running the evaluation.
   */
  @clientName("evaluationDetails", "csharp")
  evaluationOptions: AnalyzeConversationAuthoringEvaluationOptions;

  /**
   * Represents trained model label.
   */
  modelLabel: string;

  /**
   * Represents training config version.
   */
  trainingConfigVersion: string;

  /**
   * Represents progress percentage.
   */
  percentComplete: int32;
}

/**
 * Represent a list of utterances' evaluation results.
 */
@clientName("ConversationAuthoringEvalResults", "csharp")
model AnalyzeConversationAuthoringEvaluationResults {
  /**
   * The utterances evaluation results.
   */
  value: AnalyzeConversationAuthoringUtteranceEvaluationResult[];

  /**
   * The next page link.
   */
  nextLink: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model StringIndexTypeQueryParameter {
  /**
   * Specifies the method used to interpret string offsets. For additional information see https://aka.ms/text-analytics-offsets.
   */
  @query("stringIndexType")
  stringIndexType: StringIndexType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model SupportedPrebuiltEntitiesQueryParameter {
  /**
   * The language to get supported prebuilt entities for. Required if multilingual is false. This is BCP-47 representation of a language. For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  @query("language")
  language?: string;

  /**
   * Whether to get the support prebuilt entities for multilingual or monolingual projects. If true, the language parameter is ignored.
   */
  @query("multilingual")
  multilingual?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ProjectKindQueryParameter {
  /**
   * The project kind.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @query("projectKind")
  ProjectKind: ProjectKind;
}

/**
 * Represents the evaluation result for an utterance.
 */
@clientName("UtteranceEvaluationResult", "csharp")
@resource("evaluation/result")
@parentResource(AnalyzeConversationAuthoringProjectTrainedModel)
model AnalyzeConversationAuthoringUtteranceEvaluationResult {
  /**
   * Represents the utterance text.
   */
  @key
  @visibility(Lifecycle.Read)
  text: string;

  /**
   * Represents the utterance language. This is BCP-47 representation of a language. For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  language: string;

  /**
   * Represents the entities results for the utterance.
   */
  entitiesResult: AnalyzeConversationAuthoringUtteranceEntitiesEvaluationResult;

  /**
   * Represents the intents results for the utterance.
   */
  intentsResult: AnalyzeConversationAuthoringUtteranceIntentsEvaluationResult;
}

/**
 * Represents the comparison between the expected and predicted entities for an utterance.
 */
@clientName("UtteranceEntitiesEvaluationResult", "csharp")
model AnalyzeConversationAuthoringUtteranceEntitiesEvaluationResult {
  /**
   * Represents the expected entity labels.
   */
  expectedEntities: AnalyzeConversationAuthoringUtteranceEntityEvaluationResult[];

  /**
   * Represents the predicted entity labels.
   */
  predictedEntities: AnalyzeConversationAuthoringUtteranceEntityEvaluationResult[];
}

/**
 * Represents the evaluation output of an entity label or prediction.
 */
@clientName("UtteranceEntityEvaluationResult", "csharp")
model AnalyzeConversationAuthoringUtteranceEntityEvaluationResult {
  /**
   * Represents the entity category.
   */
  category: string;

  /**
   * Represents the entity offset index relative to the original text.
   */
  offset: int32;

  /**
   * Represents the entity length.
   */
  length: int32;
}

/**
 * Represents the comparison between the expected and the predicted intent for an utterance.
 */
@clientName("UtteranceIntentsEvaluationResult", "csharp")
model AnalyzeConversationAuthoringUtteranceIntentsEvaluationResult {
  /**
   * Represents the utterance's expected intent.
   */
  expectedIntent: string;

  /**
   * Represents the utterance's predicted intent.
   */
  predictedIntent: string;
}

/**
 * Represents the evaluation result summary.
 */
@clientName("ConversationAuthoringEvalSummary", "csharp")
model AnalyzeConversationAuthoringEvaluationSummary {
  /**
   * Contains the data related to entities evaluation.
   */
  entitiesEvaluation: AnalyzeConversationAuthoringEntitiesEvaluationSummary;

  /**
   * Contains the data related to intents evaluation.
   */
  intentsEvaluation: AnalyzeConversationAuthoringIntentsEvaluationSummary;

  /**
   * The options that were used while running the evaluation.
   */
  evaluationOptions?: AnalyzeConversationAuthoringEvaluationOptions;
}

/**
 * Represents the evaluation result summary for the project's entities.
 */
@clientName("EntitiesEvaluationSummary", "csharp")
model AnalyzeConversationAuthoringEntitiesEvaluationSummary {
  /**
   * Represents the confusion matrix between two entities (the two entities can be the same). The matrix is between the entity that was labelled and the entity that was predicted.
   */
  confusionMatrix: Record<AnalyzeConversationAuthoringConfusionMatrixRow>;

  /**
   * Represents the entities evaluation summary.
   */
  entities: Record<AnalyzeConversationAuthoringEntityEvaluationSummary>;

  /**
   * Represents the micro F1. Expected value is a float between 0 and 1 inclusive.
   */
  microF1: float32;

  /**
   * Represents the micro precision. Expected value is a float between 0 and 1 inclusive.
   */
  microPrecision: float32;

  /**
   * Represents the micro recall. Expected value is a float between 0 and 1 inclusive.
   */
  microRecall: float32;

  /**
   * Represents the macro F1. Expected value is a float between 0 and 1 inclusive.
   */
  macroF1: float32;

  /**
   * Represents the macro precision. Expected value is a float between 0 and 1 inclusive.
   */
  macroPrecision: float32;

  /**
   * Represents the macro recall. Expected value is a float between 0 and 1 inclusive.
   */
  macroRecall: float32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConversationAuthoringConfusionMatrixRow", "csharp")
model AnalyzeConversationAuthoringConfusionMatrixRow
  is Record<AnalyzeConversationAuthoringConfusionMatrixCell>;

/**
 * Represents a cell in a confusion matrix.
 */
@clientName("ConversationAuthoringConfusionMatrixCell", "csharp")
model AnalyzeConversationAuthoringConfusionMatrixCell {
  /**
   * Represents normalized value in percentages.
   */
  normalizedValue: float32;

  /**
   * Represents raw value.
   */
  rawValue: float32;
}

/**
 * Represents the evaluation result for an entity.
 */
@clientName("ConversationAuthoringEntityEvalSummary", "csharp")
model AnalyzeConversationAuthoringEntityEvaluationSummary {
  /**
   * Represents the model F1 score
   */
  f1: float64;

  /**
   * Represents the model precision
   */
  precision: float64;

  /**
   * Represents the model precision
   */
  recall: float64;

  /**
   * Represents the count of true positive
   */
  truePositiveCount: int32;

  /**
   * Represents the count of true negative
   */
  trueNegativeCount: int32;

  /**
   * Represents the count of false positive
   */
  falsePositiveCount: int32;

  /**
   * Represents the count of false negative
   */
  falseNegativeCount: int32;
}

/**
 * Represents the evaluation summary for the project's intents.
 */
@clientName("IntentsEvaluationSummary", "csharp")
model AnalyzeConversationAuthoringIntentsEvaluationSummary {
  /**
   * Represents the confusion matrix between two intents (the two intents can be the same). The matrix is between the intent that was labelled and the intent that was predicted.
   */
  confusionMatrix: Record<AnalyzeConversationAuthoringConfusionMatrixRow>;

  /**
   * Represents the intents evaluation summary.
   */
  intents: Record<AnalyzeConversationAuthoringIntentEvaluationSummary>;

  /**
   * Represents the micro F1. Expected value is a float between 0 and 1 inclusive.
   */
  microF1: float32;

  /**
   * Represents the micro precision. Expected value is a float between 0 and 1 inclusive.
   */
  microPrecision: float32;

  /**
   * Represents the micro recall. Expected value is a float between 0 and 1 inclusive.
   */
  microRecall: float32;

  /**
   * Represents the macro F1. Expected value is a float between 0 and 1 inclusive.
   */
  macroF1: float32;

  /**
   * Represents the macro precision. Expected value is a float between 0 and 1 inclusive.
   */
  macroPrecision: float32;

  /**
   * Represents the macro recall. Expected value is a float between 0 and 1 inclusive.
   */
  macroRecall: float32;
}

/**
 * The evaluation summary for an intent.
 */
@clientName("IntentEvaluationSummary", "csharp")
model AnalyzeConversationAuthoringIntentEvaluationSummary {
  /**
   * Represents the model precision
   */
  f1: float64;

  /**
   * Represents the model recall
   */
  precision: float64;

  /**
   * Represents the model F1 score
   */
  recall: float64;

  /**
   * Represents the count of true positive
   */
  truePositiveCount: int32;

  /**
   * Represents the count of true negative
   */
  trueNegativeCount: int32;

  /**
   * Represents the count of false positive
   */
  falsePositiveCount: int32;

  /**
   * Represents the count of false negative
   */
  falseNegativeCount: int32;
}

/**
 * Represents the state of loading a snapshot job.
 */
@clientName("ConversationAuthoringLoadSnapshotState", "csharp")
@resource("load-snapshot/jobs")
@parentResource(AnalyzeConversationAuthoringProjectTrainedModel)
model AnalyzeConversationAuthoringLoadSnapshotJobState {
  ...AnalyzeConversationAuthoringJobState;
}

/**
 * Represents the assigned deployment resources.
 */
@added(Versions.v2023_04_15_preview)
@clientName("ConversationAuthoringAssignedDeploymentResources", "csharp")
model AnalyzeConversationAuthoringAssignedDeploymentResources {
  /**
   * The list of assigned deployment resources.
   */
  value: AnalyzeConversationAuthoringAssignedDeploymentResource[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents the assigned deployment resource.
 */
@added(Versions.v2023_04_15_preview)
@clientName("ConversationAuthoringAssignedDeploymentResource", "csharp")
@resource("resources")
@parentResource(AnalyzeConversationAuthoringProjectMetadata)
model AnalyzeConversationAuthoringAssignedDeploymentResource {
  /**
   * The resource ID.
   */
  @key
  @visibility(Lifecycle.Read)
  @clientName("resourceId", "csharp")
  azureResourceId: string;

  /**
   * The resource region.
   */
  region: string;
}

/**
 * Represents the options for assigning Azure resources to a project.
 */
@added(Versions.v2023_04_15_preview)
@clientName("ConversationAuthoringAssignDeploymentResourcesDetails", "csharp")
model AnalyzeConversationAuthoringAssignDeploymentResourcesOptions {
  /**
   * Represents the metadata for the resources to be assigned.
   */
  @clientName("metadata", "csharp")
  resourcesMetadata: AnalyzeConversationAuthoringResourceMetadata[];
}

/**
 * Represents metadata for the Azure resource..
 */
@clientName("ConversationAuthoringResourceMetadata", "csharp")
model AnalyzeConversationAuthoringResourceMetadata {
  /**
   * Represents the Azure resource ID.
   */
  azureResourceId: string;

  /**
   * Represents the Azure resource custom domain.
   */
  customDomain: string;

  /**
   * Represents the Azure resource region.
   */
  region: string;
}

/**
 * Represents the options to unassign Azure resources from a project.
 */
@added(Versions.v2023_04_15_preview)
@clientName("ConversationAuthoringUnassignDeploymentResourcesDetails", "csharp")
model AnalyzeConversationAuthoringUnassignDeploymentResourcesOptions {
  /**
   * Represents the assigned resource IDs to be unassigned.
   */
  assignedResourceIds: string[];
}

/**
 * Represents the state of a deployment resources job.
 */
@added(Versions.v2023_04_15_preview)
@clientName("ConversationAuthoringDeploymentResourcesState", "csharp")
@resource("resources/assign/jobs")
@parentResource(AnalyzeConversationAuthoringProjectMetadata)
model AnalyzeConversationAuthoringDeploymentResourcesJobState {
  ...AnalyzeConversationAuthoringJobState;
}

/**
 * Represents a list of retrieved training jobs.
 */
@clientName("ConversationAuthoringTrainingJobs", "csharp")
model AnalyzeConversationAuthoringTrainingJobs {
  /**
   * The list of jobs.
   */
  value: AnalyzeConversationAuthoringTrainingJobState[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents the state of a training job.
 */
@clientName("ConversationAuthoringTrainingState", "csharp")
@resource("train/jobs")
@parentResource(AnalyzeConversationAuthoringProjectMetadata)
model AnalyzeConversationAuthoringTrainingJobState {
  ...AnalyzeConversationAuthoringJobState;

  /**
   * Represents training tasks detailed result.
   */
  result: AnalyzeConversationAuthoringTrainingJobResult;
}

/**
 * Represents the output of a training job.
 */
@clientName("ConversationAuthoringTrainingJobResult", "csharp")
model AnalyzeConversationAuthoringTrainingJobResult {
  /**
   * Represents trained model label.
   */
  modelLabel: string;

  /**
   * Represents training config version.
   */
  trainingConfigVersion: string;

  /**
   * Represents the mode of the training operation.
   */
  trainingMode?: TrainingMode;

  /**
   * Represents the model training status.
   */
  trainingStatus: AnalyzeConversationAuthoringSubTrainingJobState;

  /**
   * Represents model evaluation status.
   */
  evaluationStatus?: AnalyzeConversationAuthoringSubTrainingJobState;

  /**
   * Represents the estimated end date time for training and evaluation.
   */
  @clientName("estimatedEndOn", "csharp")
  estimatedEndDateTime?: utcDateTime;
}

/**
 * Represents the detailed state of a training sub-operation.
 */
@clientName("ConversationAuthoringSubTrainingState", "csharp")
model AnalyzeConversationAuthoringSubTrainingJobState {
  /**
   * Represents progress percentage.
   */
  percentComplete: int32;

  /**
   * Represents the start date time.
   */
  @clientName("startedOn", "csharp")
  startDateTime?: utcDateTime;

  /**
   * Represents the end date time.
   */
  @clientName("endedOn", "csharp")
  endDateTime?: utcDateTime;

  /**
   * Represents the status of the sub-operation.
   */
  status: JobStatus;
}

/**
 * Represents the state of a project deletion job.
 */
@clientName("ConversationAuthoringProjectDeletionState", "csharp")
model AnalyzeConversationAuthoringProjectDeletionJobState {
  ...AnalyzeConversationAuthoringJobState;
}

/**
 * Represents the metadata for deployments assigned to a resource.
 */
@added(Versions.v2023_04_15_preview)
@clientName(
  "ConversationAuthoringAssignedResourceDeploymentsMetadata",
  "csharp"
)
model AnalyzeConversationAuthoringAssignedResourceDeploymentsMetadata {
  /**
   * The list of retrieved assigned project deployments.
   */
  value: AnalyzeConversationAuthoringAssignedProjectDeploymentsMetadata[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents the metadata for assigned deployments for a project.
 */
@added(Versions.v2023_04_15_preview)
@clientName("ConversationAuthoringAssignedProjectDeploymentsMetadata", "csharp")
@resource("authoring/analyze-conversations/projects/global/deployments/resources")
model AnalyzeConversationAuthoringAssignedProjectDeploymentsMetadata {
  /**
   * Represents the project name.
   */
  @key
  @visibility(Lifecycle.Read)
  projectName: string;

  /**
   * Represents the resource region.
   */
  deploymentsMetadata: AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata[];
}

/**
 * Represents the metadata for an assigned deployment
 */
@added(Versions.v2023_04_15_preview)
@clientName("ConversationAuthoringAssignedProjectDeploymentMetadata", "csharp")
model AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata {
  /**
   * Represents the deployment name.
   */
  deploymentName: string;

  /**
   * Represents deployment last deployed time.
   */
  @clientName("lastDeployedOn", "csharp")
  lastDeployedDateTime: utcDateTime;

  /**
   * Represents deployment expiration date in the runtime.
   */
  @clientName("DeploymentExpiresOn", "csharp")
  deploymentExpirationDate: plainDate;
}

/**
 * Represents a list of retrieved languages.
 */
@clientName("ConversationAuthoringSupportedLanguages", "csharp")
model AnalyzeConversationAuthoringSupportedLanguages {
  /**
   * The list of the languages.
   */
  value: AnalyzeConversationAuthoringSupportedLanguage[];

  /**
   * The next page link.
   */
  nextLink?: string;
}
/**
 * Represents a supported language.
 */
@clientName("ConversationAuthoringSupportedLanguage", "csharp")
@resource("authoring/analyze-conversations/projects/global/languages")
model AnalyzeConversationAuthoringSupportedLanguage {
  /**
   * The language name.
   */
  @key
  @visibility(Lifecycle.Read)
  languageName: string;

  /**
   * The language code. This is BCP-47 representation of a language. For example, "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  languageCode: string;
}

/**
 * Represents a list of the retrieved supported prebuilt entities.
 */
@clientName("ConversationAuthoringPrebuiltEntities", "csharp")
model AnalyzeConversationAuthoringPrebuiltEntities {
  /**
   * The supported prebuilt entities.
   */
  value: AnalyzeConversationAuthoringPrebuiltEntity[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents a supported prebuilt entity.
 */
@clientName("ConversationAuthoringPrebuiltEntity", "csharp")
@resource("authoring/analyze-conversations/projects/global/prebuilt-entities")
model AnalyzeConversationAuthoringPrebuiltEntity {
  /**
   * The prebuilt entity category.
   */
  @key
  @visibility(Lifecycle.Read)
  category: string;

  /**
   * The description.
   */
  description: string;

  /**
   * English examples for the entity.
   */
  examples: string;
}

/**
 * Represents a list of training config versions.
 */
@clientName("ConversationAuthoringTrainingConfigVersions", "csharp")
model AnalyzeConversationAuthoringTrainingConfigVersions {
  /**
   * The list of the training config versions.
   */
  value: AnalyzeConversationAuthoringTrainingConfigVersion[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents a training config version.
 */
#suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "TODO: This client name renaming explicitly makes us run into the csharp issue. Please fix."
@clientName("ConversationAuthoringTrainingConfigVersion", "csharp")
@resource("authoring/analyze-conversations/projects/global/training-config-versions")
model AnalyzeConversationAuthoringTrainingConfigVersion {
  /**
   * Represents the version of the config.
   */
  @key
  @visibility(Lifecycle.Read)
  trainingConfigVersion: string;

  /**
   * Represents the training config version expiration date.
   */
  modelExpirationDate: plainDate;
}

/**
 * Represents an entity with its components.
 */
@clientName("ConversationExportedEntity", "csharp")
model AnalyzeConversationAuthoringConversationExportedEntity {
  /**
   * The category of the entity.
   */
  category: string;

  /**
   * The entity description.
   */
  @added(Versions.v2025_05_15_preview)
  description?: string;

  /**
   * The behavior to follow when the entity's components overlap with each other.
   */
  @clientName("compositionMode", "csharp")
  compositionSetting?: CompositionSetting;

  /**
   * The list component of the entity.
   */
  entities?: AnalyzeConversationAuthoringExportedEntityList;

  /**
   * The prebuilt entities components.
   */
  prebuilts?: AnalyzeConversationAuthoringExportedPrebuiltEntity[];

  /**
   * The regex component of the entity.
   */
  regex?: AnalyzeConversationAuthoringExportedEntityRegex;

  /**
   * The required components. Allowed values are 'learned', 'list', 'prebuilts' and 'regex'.
   */
  requiredComponents?: string[];
}

/**
 * Represents a list component of an entity.
 */
@clientName("ConversationAuthoringExportedEntityList", "csharp")
model AnalyzeConversationAuthoringExportedEntityList {
  /**
   * The sub-lists of the list component.
   */
  sublists?: AnalyzeConversationAuthoringExportedEntitySublist[];
}

/**
 * Represents a sub-list inside a list component.
 */
@clientName("ConversationAuthoringExportedEntitySublist", "csharp")
model AnalyzeConversationAuthoringExportedEntitySublist {
  /**
   * The key of the sub-list.
   */
  listKey?: string;

  /**
   * The phrases of that correspond to the sub-list.
   */
  synonyms?: AnalyzeConversationAuthoringExportedEntityListSynonym[];
}

/**
 * Represents a list of synonyms inside a list component
 */
@clientName("ConversationAuthoringExportedEntityListSynonym", "csharp")
model AnalyzeConversationAuthoringExportedEntityListSynonym {
  /**
   * Represents the language of the synonyms. This is BCP-47 representation of a language. For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  language?: string;

  /**
   * The list of synonyms.
   */
  values?: string[];
}

/**
 * Represents an exported prebuilt entity component
 */
@clientName("ConversationAuthoringExportedPrebuiltEntity", "csharp")
model AnalyzeConversationAuthoringExportedPrebuiltEntity {
  /**
   * The prebuilt entity category.
   */
  category: string;
}

/**
 * Represents a regex component of an entity.
 */
@clientName("ExportedEntityRegex", "csharp")
model AnalyzeConversationAuthoringExportedEntityRegex {
  /**
   * The regex expressions of the regex component. These expressions follow the .NET regex syntax. For reference, check here: https://learn.microsoft.com/dotnet/standard/base-types/regular-expressions
   */
  expressions?: AnalyzeConversationAuthoringExportedEntityRegexExpression[];
}

/**
 * Represents a regex expression inside a regex component. This expression follows the .NET regex syntax. For reference, check here: https://learn.microsoft.com/dotnet/standard/base-types/regular-expressions
 */
@clientName("ExportedEntityRegexExpression", "csharp")
model AnalyzeConversationAuthoringExportedEntityRegexExpression {
  /**
   * The key of the regex expression.
   */
  regexKey?: string;

  /**
   * Represents the language of the regex expression. This is BCP-47 representation of a language. For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  language?: string;

  /**
   * The regex pattern.
   */
  regexPattern?: string;
}

/**
 * Represents an exported intent of a conversational project.
 */
@clientName("ConversationExportedIntent", "csharp")
model AnalyzeConversationAuthoringConversationExportedIntent {
  /**
   * The intent category.
   */
  category: string;

  /**
   * The intent description.
   */
  @added(Versions.v2025_05_15_preview)
  description?: string;

  /**
   * The list of associated entities.
   */
  @added(Versions.v2025_05_15_preview)
  associatedEntities?: AnalyzeConversationExportedAssociatedEntityLabel[];
}

/**
 * Represents an associated entity label for an intent.
 */
@clientName("ConversationExportedAssociatedEntityLabel", "csharp")
@added(Versions.v2025_05_15_preview)
model AnalyzeConversationExportedAssociatedEntityLabel {
  /**
   * The category of the entity label.
   */
  category: string;
}

/**
 * Represents the exported assets of a conversational project.
 */
@clientName("ConversationExportedProjectAsset", "csharp")
model AnalyzeConversationAuthoringConversationExportedProjectAsset
  extends AnalyzeConversationAuthoringExportedProjectAssets {
  /**
   * The intents defined in the project.
   */
  intents?: AnalyzeConversationAuthoringConversationExportedIntent[];

  /**
   * The entities defined in the project.
   */
  entities?: AnalyzeConversationAuthoringConversationExportedEntity[];

  /**
   * The utterances defined in the project.
   */
  utterances?: AnalyzeConversationAuthoringConversationExportedUtterance[];

  /**
   * The type of project containing the assets.
   */
  projectKind: "Conversation";
}

/**
 * Represents an exported utterance for a conversational project.
 */
@clientName("ConversationExportedUtterance", "csharp")
model AnalyzeConversationAuthoringConversationExportedUtterance {
  /**
   * Represents the entity labels of the utterance.
   */
  entities?: AnalyzeConversationAuthoringExportedUtteranceEntityLabel[];

  /**
   * The utterance text.
   */
  text: string;

  /**
   * Represents the utterance's language. This is BCP-47 representation of a language. For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  language?: string;

  /**
   * The intent of the utterance.
   */
  intent: string;

  /**
   * The dataset for this utterance. Allowed values are 'Train' and 'Test'.
   */
  dataset?: DatasetType;
}

/**
 * The dataset for this utterance. Allowed values are 'Train' and 'Test'.
 */
union DatasetType {
  string,

  /**
   * Split the data into training and test sets according to user-defined percentages.
   */
  Train: "Train",

  /**
   * Split the data according to the chosen dataset for every example in the data.
   */
  Test: "Test",
}

/**
 * Represents an entity label for an utterance.
 */
@clientName("ExportedUtteranceEntityLabel", "csharp")
model AnalyzeConversationAuthoringExportedUtteranceEntityLabel {
  /**
   * The category of the entity label.
   */
  category: string;

  /**
   * Start position for the entity text.
   */
  offset: int32;

  /**
   * Length for the entity text.
   */
  length: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConversationSummarizationExportedProjectAsset", "csharp")
model AnalyzeConversationAuthoringConversationSummarizationExportedProjectAsset {
  /**
   * Represents the conversations of the project.
   */
  conversations?: AnalyzeConversationAuthoringCustomConversationSummarizationConversation[];
}

/**
 * Represents an exported conversation for a custom conversation summarization.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("CustomConversationSummarizationConversation", "csharp")
model AnalyzeConversationAuthoringCustomConversationSummarizationConversation {
  summaryLocation?: string;

  /**
   * Represents the conversation file location in the blob store container associated with the project.
   */
  location: string;

  /**
   * Represents the language. This is BCP-47 representation of a language. For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  language?: string;

  /**
   * The dataset for this conversation. Allowed values are 'Train' and 'Test'.
   */
  dataset?: string;
}

/**
 * Defines the orchestration details for a Conversational project target.
 */
@clientName("ExportedConversationOrchestration", "csharp")
model AnalyzeConversationAuthoringExportedConversationOrchestration {
  /**
   * The name of the targeted project.
   */
  projectName: string;

  /**
   * The name of the targeted deployment.
   */
  deploymentName: string;
}

/**
 * Represents the orchestration options for a Conversational project target.
 */
@clientName("ExportedConversationOrchestrationDetails", "csharp")
model AnalyzeConversationAuthoringExportedConversationOrchestrationOptions
  extends AnalyzeConversationAuthoringExportedOrchestrationOptions {
  /**
   * The Conversational project target details.
   */
  conversationOrchestration: AnalyzeConversationAuthoringExportedConversationOrchestration;

  /**
   * The kind of the target used in the orchestration flow.
   */
  targetProjectKind: "Conversation";
}

/**
 * Represents the options used to define the orchestration behavior of an intent.
 */
@discriminator("targetProjectKind")
@clientName("ExportedOrchestrationDetails", "csharp")
model AnalyzeConversationAuthoringExportedOrchestrationOptions {
  targetProjectKind: OrchestrationTargetProjectKind;
}

/**
 * Defines the orchestration details for a LUIS application target.
 */
@clientName("ExportedLuisOrchestration", "csharp")
model AnalyzeConversationAuthoringExportedLuisOrchestration {
  /**
   * The LUIS application ID.
   */
  appId: uuid;

  /**
   * The targeted version Id.
   */
  appVersion?: string;

  /**
   * The targeted slot name.
   */
  slotName?: string;
}

/**
 * Represents the orchestration options for a LUIS application target.
 */
@clientName("ExportedLuisOrchestrationDetails", "csharp")
model AnalyzeConversationAuthoringExportedLuisOrchestrationOptions
  extends AnalyzeConversationAuthoringExportedOrchestrationOptions {
  /**
   * The LUIS application target details.
   */
  luisOrchestration: AnalyzeConversationAuthoringExportedLuisOrchestration;

  /**
   * The kind of the target used in the orchestration flow.
   */
  targetProjectKind: "Luis";
}

/**
 * Defines the orchestration details for a Question Answering project target.
 */
@clientName("ExportedQuestionAnsweringOrchestration", "csharp")
model AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestration {
  /**
   * The name of the target project.
   */
  projectName: string;
}

/**
 * Represents the orchestration options for a Question Answering project target.
 */
@clientName("ExportedQuestionAnsweringOrchestrationDetails", "csharp")
model AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestrationOptions
  extends AnalyzeConversationAuthoringExportedOrchestrationOptions {
  /**
   * The Question Answering project details.
   */
  questionAnsweringOrchestration: AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestration;

  /**
   * The kind of the target used in the orchestration flow.
   */
  targetProjectKind: "QuestionAnswering";
}

/**
 * Represents an exported intent for an orchestration project.
 */
@clientName("OrchestrationExportedIntent", "csharp")
model AnalyzeConversationAuthoringOrchestrationExportedIntent {
  /**
   * Specifies the behavior of this intent in the orchestration flow.
   */
  orchestration?: AnalyzeConversationAuthoringExportedOrchestrationOptions;

  /**
   * The intent category.
   */
  category: string;

  /**
   * The intent description.
   */
  @added(Versions.v2025_05_15_preview)
  description?: string;
}

/**
 * Represents the assets of an orchestration project.
 */
@clientName("OrchestrationExportedProjectAsset", "csharp")
model AnalyzeConversationAuthoringOrchestrationExportedProjectAsset
  extends AnalyzeConversationAuthoringExportedProjectAssets {
  /**
   * Represents the intents of the project.
   */
  intents?: AnalyzeConversationAuthoringOrchestrationExportedIntent[];

  /**
   * Represents the utterances of the project.
   */
  utterances?: AnalyzeConversationAuthoringOrchestrationExportedUtterance[];

  /**
   * The type of project containing the assets.
   */
  projectKind: "Orchestration";
}

/**
 * Represents an utterance of an orchestration project.
 */
@clientName("OrchestrationExportedUtterance", "csharp")
model AnalyzeConversationAuthoringOrchestrationExportedUtterance {
  /**
   * The utterance text.
   */
  text: string;

  /**
   * Represents the utterance's language. This is BCP-47 representation of a language. For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  language?: string;

  /**
   * The intent of the utterance.
   */
  intent: string;

  /**
   * The dataset for this utterance. Allowed values are 'Train' and 'Test'.
   */
  dataset?: string;
}

/**
 * Represents an exported trained model.
 */
@clientName("ConversationAuthoringExportedTrainedModel", "csharp")
@resource("exported-models")
@parentResource(AnalyzeConversationAuthoringProjectMetadata)
model AnalyzeConversationAuthoringExportedTrainedModel {
  /**
   * The exported model name.
   */
  @key("exportedModelName")
  @visibility(Lifecycle.Read)
  exportedModelName: string;

  /**
   * The model ID.
   */
  modelId: string;

  /**
   * The last trained date time of the model.
   */
  @clientName("lastTrainedOn", "csharp")
  lastTrainedDateTime: utcDateTime;

  /**
   * The last exported date time of the model.
   */
  @clientName("lastExportedModelOn", "csharp")
  lastExportedModelDateTime: utcDateTime;

  /**
   * The model expiration date.
   */
  @clientName("modelExpiredOn", "csharp")
  modelExpirationDate: plainDate;

  /**
   * The model training config version.
   */
  modelTrainingConfigVersion: string;
}
/**
 * Represents the state of a job to create or updated an exported model.
 */
@added(Versions.v2024_11_15_preview)
@clientName("ConversationAuthoringExportedModelState", "csharp")
@resource("jobs")
@parentResource(AnalyzeConversationAuthoringExportedTrainedModel)
model AnalyzeConversationAuthoringExportedModelJobState {
  ...AnalyzeConversationAuthoringJobState;
}
/**
 * Represents the properties for the model file.
 */
@clientName("ConversationAuthoringModelFile", "csharp")
@added(Versions.v2024_11_15_preview)
model AnalyzeConversationAuthoringModelFile {
  /**
   * The name of the file.
   */
  name: string;

  /**
   * The URI to retrieve the content of the file.
   */
  contentUri: url;
}
/**
 * Represents the options for creating or replacing an exported model.
 */
@clientName("ConversationAuthoringExportedModelDetails", "csharp")
@added(Versions.v2024_11_15_preview)
model ExportedModelOptions {
  /**
   * The trained model label.
   */
  trainedModelLabel: string;
}

/**
 * Represents the connection kind for Azure OpenAI deployment.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2025_05_15_preview)
union AnalyzeConversationAuthoringDataGenerationConnectionKind {
  string,
  AzureOpenAI: "AzureOpenAI",
}

/**
 * Represents the connection info for the Azure resource to use during data generation.
 */
@added(Versions.v2025_05_15_preview)
model AnalyzeConversationAuthoringDataGenerationConnectionInfo {
  /**
   * Connection type for data generation settings. Currently only supports Azure OpenAI.
   */
  kind: AnalyzeConversationAuthoringDataGenerationConnectionKind;

  /**
   * Deployment name of model to be used for synthetic data generation.
   */
  deploymentName: string;

  /**
   * Resource ID for the data generation resource. Looks something like
   * "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{resourceName}".
   */
  resourceId?: string;
}

/**
 * Settings to enable data generation for training augmentation.
 */
@added(Versions.v2025_05_15_preview)
model AnalyzeConversationAuthoringDataGenerationSettings {
  /**
   * Must be explicitly set to True to enable data generation to augment training data.
   */
  enableDataGeneration: boolean;

  /**
   * Must be filled out to enable data generation to augment training data.
   */
  dataGenerationConnectionInfo: AnalyzeConversationAuthoringDataGenerationConnectionInfo;
}
