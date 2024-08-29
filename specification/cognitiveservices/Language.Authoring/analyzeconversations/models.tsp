import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.Authoring;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
union ProjectKind {
  string,

  /**
   * A project to build natural language into apps, bots, and IoT devices.
   */
  Conversation: "Conversation",

  /**
   * A project to connect and orchestrate Conversation, Custom question answering
   * and LUIS projects together in one single project.
   */
  Orchestration: "Orchestration",

  /**
   * A project to build conversation summarization models which are able to
   * summarize long conversations.
   */
  CustomConversationSummarization: "CustomConversationSummarization",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
union ErrorCode {
  string,
  InvalidRequest: "InvalidRequest",
  InvalidArgument: "InvalidArgument",
  Forbidden: "Forbidden",
  NotFound: "NotFound",
  Unauthorized: "Unauthorized",
  Timeout: "Timeout",
  QuotaExceeded: "QuotaExceeded",
  Conflict: "Conflict",
  Warning: "Warning",
  InternalServerError: "InternalServerError",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
union ExportedProjectFormat {
  string,

  /**
   * Specifies the format for a conversational project.
   */
  Conversation: "Conversation",

  /**
   * Specifies the format for an application that was exported from LUIS.
   */
  Luis: "Luis",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
union StringIndexType {
  string,

  /**
   * The offset and length values will correspond to UTF-16 code units. Use this
   * option if your application is written in a language that support Unicode, for
   * example Java, JavaScript.
   */
  Utf16CodeUnit: "Utf16CodeUnit",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
union TrainingMode {
  string,

  /**
   * Trains using fine-tuned neural network transformer models. Can train
   * multilingual projects.
   */
  advanced: "advanced",

  /**
   * Faster training times for quicker iterations.
   */
  standard: "standard",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
union EvaluationKind {
  string,

  /**
   * Split the data into training and test sets according to user-defined
   * percentages.
   */
  percentage: "percentage",

  /**
   * Split the data according to the chosen dataset for every example in the data.
   */
  manual: "manual",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@lroStatus
union JobStatus {
  string,
  notStarted: "notStarted",
  running: "running",

  @lroSucceeded
  succeeded: "succeeded",

  @lroFailed
  failed: "failed",

  @lroCanceled
  cancelled: "cancelled",
  cancelling: "cancelling",
  partiallyCompleted: "partiallyCompleted",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
union CompositionSetting {
  string,

  /**
   * When two or more components are found in the text and overlap, the component
   * with the longest set of characters is returned.
   */
  returnLongestOverlap: "returnLongestOverlap",

  /**
   * All components must overlap at the exact same characters in the text for the
   * entity to return. If one of the defined components is not matched or predicted,
   * the entity will not return.
   */
  requireExactOverlap: "requireExactOverlap",

  /**
   * Every component's match or prediction is returned as a separate instance of the
   * entity.
   */
  separateComponents: "separateComponents",

  /**
   * When two or more components are found in the text and overlap, the components'
   * spans are merged together into one span combining all of them.
   */
  combineComponents: "combineComponents",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
union OrchestrationTargetProjectKind {
  string,
  Luis: "Luis",
  Conversation: "Conversation",
  QuestionAnswering: "QuestionAnswering",
}

/**
 * Represents the metadata of a project.
 */
@resource("projects")
model ProjectMetadata {
  /**
   * Represents the project creation datetime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  /**
   * Represents the project creation datetime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime: utcDateTime;

  /**
   * Represents the project last trained datetime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTrainedDateTime?: utcDateTime;

  /**
   * Represents the project last deployed datetime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastDeployedDateTime?: utcDateTime;

  /**
   * Represents the project kind.
   */
  projectKind: ProjectKind;

  /**
   * The project settings.
   */
  settings?: ProjectSettings;

  /**
   * The storage container name in case of conversation summarization.
   */
  storageInputContainerName?: string;

  /**
   * The new project name.
   */
  @key("projectName")
  @visibility("read")
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
   * The project language. This is BCP-47 representation of a language. For example,
   * use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  language: string;
}

/**
 * Represents the settings used to define the project behavior.
 */
model ProjectSettings {
  /**
   * The threshold of the intent with the highest confidence, at which the
   * prediction will automatically be changed to "None". The value of the threshold
   * should be between 0 and 1 inclusive.
   */
  confidenceThreshold: float32;

  /**
   * Gets or sets normalize casing flag
   */
  normalizeCasing?: boolean;

  /**
   * Gets or sets the augment diacritics flag.
   */
  augmentDiacritics?: boolean;
}

/**
 * Represents an error that occurred.
 */
@error
model ErrorResponse {
  /**
   * Represents the definition of an error that occurred.
   */
  error: Error;
}

/**
 * Represents the definition of an error that occurred.
 */
model Error {
  /**
   * The error code.
   */
  code: ErrorCode;

  /**
   * The error message.
   */
  message: string;

  /**
   * The target that caused the error, if applicable.
   */
  target?: string;

  /**
   * An array of details about specific errors that led to this reported error.
   */
  details?: Error[];
}

/**
 * Represents the options used to create or update a project.
 */
model CreateProjectOptions {
  /**
   * Represents the project kind.
   */
  projectKind: ProjectKind;

  /**
   * The project settings.
   */
  settings?: ProjectSettings;

  /**
   * The storage container name in case of conversation summarization.
   */
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
   * The project language. This is BCP-47 representation of a language. For example,
   * use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  language: string;
}

/**
 * Represents the options for authorizing a project copy to the current Azure
 * resource.
 */
model CopyAuthorizationOptions {
  /**
   * Represents the project kind.
   */
  projectKind: ProjectKind;

  /**
   * The name of the storage container.
   */
  storageInputContainerName?: string;

  /**
   * Whether to allow an existing project to be overwritten using the resulting copy
   * authorization.
   */
  allowOverwrite?: boolean;
}

/**
 * Represents the options for copying an existing project to another Azure
 * resource.
 */
model CopyProjectOptions {
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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
model ExportedProject {
  /**
   * The version of the exported file.
   */
  projectFileVersion: string;

  /**
   * Specifies the method used to interpret string offsets. For additional
   * information see https://aka.ms/text-analytics-offsets.
   */
  stringIndexType: StringIndexType;

  /**
   * Represents the project metadata.
   */
  metadata: CreateProjectOptions;

  /**
   * Represents the project assets.
   */
  assets?: ExportedProjectAssets;
}

/**
 * Represents the assets of an exported project.
 */
@discriminator("projectKind")
model ExportedProjectAssets {
  projectKind: ProjectKind;
}

/**
 * Represents the options for starting a new training job.
 */
model TrainingJobOptions {
  /**
   * Represents the output model label.
   */
  modelLabel: string;

  /**
   * Represents training config version. By default, "latest" value is used which
   * uses the latest released training config version.
   */
  trainingConfigVersion?: string;

  /**
   * Represents the mode of the training operation.
   */
  trainingMode: TrainingMode;

  /**
   * Represents the evaluation options. By default, the evaluation kind is
   * percentage, with training split percentage as 80, and testing split percentage
   * as 20.
   */
  evaluationOptions?: EvaluationOptions;
}

/**
 * Represents the options used running the evaluation.
 */
model EvaluationOptions {
  /**
   * Represents the evaluation kind. By default, the evaluation kind is set to
   * percentage.
   */
  kind?: EvaluationKind;

  /**
   * Represents the training dataset split percentage. Only needed in case the
   * evaluation kind is percentage.
   */
  trainingSplitPercentage?: int32;

  /**
   * Represents the testing dataset split percentage. Only needed in case the
   * evaluation kind is percentage.
   */
  testingSplitPercentage?: int32;
}

/**
 * Represents the state of a copy job.
 */
model CopyProjectJobState {
  ...JobState;
}

/**
 * Represents a job's state.
 */
model JobState {
  /**
   * The job ID.
   */
  jobId: string;

  /**
   * The creation date time of the job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  /**
   * The last date time the job was updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedDateTime: utcDateTime;

  /**
   * The expiration date time of the job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDateTime?: utcDateTime;

  /**
   * The job status.
   */
  status: JobStatus;

  /**
   * The warnings that were encountered while executing the job.
   */
  warnings?: Warning[];

  /**
   * The errors encountered while executing the job.
   */
  errors?: Error[];
}

/**
 * Represents a warning that was encountered while executing the request.
 */
model Warning {
  /**
   * The warning code.
   */
  code: string;

  /**
   * The warning message.
   */
  message: string;
}

/**
 * Represents a list of retrieved deployments.
 */
model ProjectDeployments {
  /**
   * The list of retrieved deployments.
   */
  value: ProjectDeployment[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents a project deployment.
 */
model ProjectDeployment {
  /**
   * Represents deployment name.
   */
  deploymentName: string;

  /**
   * Represents deployment modelId.
   */
  modelId: string;

  /**
   * Represents deployment last trained time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTrainedDateTime: utcDateTime;

  /**
   * Represents deployment last deployed time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastDeployedDateTime: utcDateTime;

  /**
   * Represents deployment expiration date in the runtime.
   */
  deploymentExpirationDate: plainDate;

  /**
   * Represents model training config version.
   */
  modelTrainingConfigVersion: string;

  /**
   * Represents the metadata of the assigned Azure resources.
   */
  assignedResources: DeploymentResource[];
}

/**
 * Represents an Azure resource assigned to a deployment.
 */
model DeploymentResource {
  /**
   * Represents the Azure resource Id.
   */
  resourceId: string;

  /**
   * Represents the resource region.
   */
  region: string;
}

/**
 * Represents the options for creating or updating a project deployment.
 */
model CreateDeploymentOptions {
  /**
   * Represents the trained model label.
   */
  trainedModelLabel: string;

  /**
   * Represents the resource IDs to be assigned to the deployment.
   *             If provided, the deployment will be rolled out to the resources
   * provided here as well as the original resource in which the project is created.
   */
  assignedResourceIds?: string[];
}

/**
 * Represents the options for deleting a project deployment.
 */
model DeleteDeploymentOptions {
  /**
   * Represents the resource IDs to delete the deployment from.
   *             If not provided, the deployment will be rolled out from all the
   * resources it is deployed to.
   *             If provided, it will delete the deployment only from the specified
   * assigned resources, and leave it for the rest.
   */
  assignedResourceIds?: string[];
}

/**
 * Represents the state of a deployment job.
 */
model DeploymentJobState {
  ...JobState;
}

/**
 * Represents the options for swapping two deployments together.
 */
model SwapDeploymentsOptions {
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
model ExportProjectJobState {
  
  ...JobState;
  /**
   * The URL to use in order to download the exported project.
   */
  resultUrl?: string;
}

/**
 * Represents the state of an import job.
 */
model ImportProjectJobState {
  ...JobState;
}

/**
 * Represents a list of retrieved trained models.
 */
model ProjectTrainedModels {
  /**
   * The list of trained models.
   */
  value: ProjectTrainedModel[];

  /**
   * The next page link.
   */
  nextLink: string;
}

/**
 * Represents a trained model.
 */
model ProjectTrainedModel {
  /**
   * The trained model label.
   */
  label: string;

  /**
   * The model ID.
   */
  modelId: string;

  /**
   * The last trained date time of the model.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTrainedDateTime: utcDateTime;

  /**
   * The duration of the model's last training request in seconds.
   */
  lastTrainingDurationInSeconds: int32;

  /**
   * The model expiration date.
   */
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
 * Represents the options used running the evaluation.
 */
model EvaluationOnDemandOptions {
  /**
   * Represents the evaluation kind. By default, the evaluation kind is set to
   * percentage.
   */
  kind?: EvaluationKind;

  /**
   * Represents the testing dataset split percentage. Only needed in case the
   * evaluation kind is percentage.
   */
  testingSplitPercentage?: int32;
}

/**
 * Represents the state of a evaluation job.
 */
model EvaluationJobState {

  ...JobState;

  /**
   * Represents evaluation task detailed result.
   */
  result: EvaluationJobResult;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model EvaluationJobResult {
  /**
   * Represents the options used running the evaluation.
   */
  evaluationOptions: EvaluationOptions;

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
  percentComplete: float64;
}

/**
 * Represent a list of utterances' evaluation results.
 */
model EvaluationResults {
  /**
   * The utterances evaluation results.
   */
  value: UtteranceEvaluationResult[];

  /**
   * The next page link.
   */
  nextLink: string;
}

/**
 * Represents the evaluation result for an utterance.
 */
model UtteranceEvaluationResult {
  /**
   * Represents the utterance text.
   */
  text: string;

  /**
   * Represents the conversation location.
   */
  location: string;

  /**
   * Represents the utterance language. This is BCP-47 representation of a language.
   * For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish
   * etc.
   */
  language: string;

  /**
   * Represents the entities results for the utterance.
   */
  entitiesResult: UtteranceEntitiesEvaluationResult;

  /**
   * Represents the intents results for the utterance.
   */
  intentsResult: UtteranceIntentsEvaluationResult;

  /**
   * Represents the location of the labeled summary.
   */
  labeledSummaryLocation: string;

  /**
   * Represents the location of the predicted summary.
   */
  predictedSummaryLocation: string;
}

/**
 * Represents the comparison between the expected and predicted entities for an
 * utterance.
 */
model UtteranceEntitiesEvaluationResult {
  /**
   * Represents the expected entity labels.
   */
  expectedEntities: UtteranceEntityEvaluationResult[];

  /**
   * Represents the predicted entity labels.
   */
  predictedEntities: UtteranceEntityEvaluationResult[];
}

/**
 * Represents the evaluation output of an entity label or prediction.
 */
model UtteranceEntityEvaluationResult {
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
 * Represents the comparison between the expected and the predicted intent for an
 * utterance.
 */
model UtteranceIntentsEvaluationResult {
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
model EvaluationSummary {
  /**
   * Contains the data related to entities evaluation.
   */
  entitiesEvaluation: EntitiesEvaluationSummary;

  /**
   * Contains the data related to intents evaluation.
   */
  intentsEvaluation: IntentsEvaluationSummary;

  /**
   * The options that were used while running the evaluation.
   */
  evaluationOptions?: EvaluationOptions;
}

/**
 * Represents the evaluation result summary for the project's entities.
 */
model EntitiesEvaluationSummary {
  /**
   * Represents the confusion matrix between two entities (the two entities can be
   * the same). The matrix is between the entity that was labelled and the entity
   * that was predicted.
   */
  confusionMatrix: Record<Record<ConfusionMatrixCell>>;

  /**
   * Represents the entities evaluation summary.
   */
  entities: Record<EntityEvaluationSummary>;

  /**
   * Represents the micro F1. Expected value is a float between 0 and 1 inclusive.
   */
  microF1: float32;

  /**
   * Represents the micro precision. Expected value is a float between 0 and 1
   * inclusive.
   */
  microPrecision: float32;

  /**
   * Represents the micro recall. Expected value is a float between 0 and 1
   * inclusive.
   */
  microRecall: float32;

  /**
   * Represents the macro F1. Expected value is a float between 0 and 1 inclusive.
   */
  macroF1: float32;

  /**
   * Represents the macro precision. Expected value is a float between 0 and 1
   * inclusive.
   */
  macroPrecision: float32;

  /**
   * Represents the macro recall. Expected value is a float between 0 and 1
   * inclusive.
   */
  macroRecall: float32;
}

/**
 * Represents a cell in a confusion matrix.
 */
model ConfusionMatrixCell {
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
model EntityEvaluationSummary {
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
 * Represents the evaluation summary for the project's intents.
 */
model IntentsEvaluationSummary {
  /**
   * Represents the confusion matrix between two intents (the two intents can be the
   * same). The matrix is between the intent that was labelled and the intent that
   * was predicted.
   */
  confusionMatrix: Record<Record<ConfusionMatrixCell>>;

  /**
   * Represents the intents evaluation summary.
   */
  intents: Record<IntentEvaluationSummary>;

  /**
   * Represents the micro F1. Expected value is a float between 0 and 1 inclusive.
   */
  microF1: float32;

  /**
   * Represents the micro precision. Expected value is a float between 0 and 1
   * inclusive.
   */
  microPrecision: float32;

  /**
   * Represents the micro recall. Expected value is a float between 0 and 1
   * inclusive.
   */
  microRecall: float32;

  /**
   * Represents the macro F1. Expected value is a float between 0 and 1 inclusive.
   */
  macroF1: float32;

  /**
   * Represents the macro precision. Expected value is a float between 0 and 1
   * inclusive.
   */
  macroPrecision: float32;

  /**
   * Represents the macro recall. Expected value is a float between 0 and 1
   * inclusive.
   */
  macroRecall: float32;
}

/**
 * The evaluation summary for an intent.
 */
model IntentEvaluationSummary {
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
model LoadSnapshotJobState {
  ...JobState;
}

/**
 * Represents the assigned deployment resources.
 */
model AssignedDeploymentResources {
  /**
   * The list of assigned deployment resources.
   */
  value: AssignedDeploymentResource[];

  /**
   * The next page link.
   */
  nextLink: string;
}

/**
 * Represents the assigned deployment resource.
 */
model AssignedDeploymentResource {
  /**
   * The resource ID.
   */
  azureResourceId: string;

  /**
   * The resource region.
   */
  region: string;
}

/**
 * Represents the options for assigning Azure resources to a project.
 */
model AssignDeploymentResourcesOptions {
  /**
   * Represents the metadata for the resources to be assigned.
   */
  resourcesMetadata: ResourceMetadata[];
}

/**
 * Represents metadata for the Azure resource..
 */
model ResourceMetadata {
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
model UnassignDeploymentResourcesOptions {
  /**
   * Represents the assigned resource IDs to be unassigned.
   */
  assignedResourceIds: string[];
}

/**
 * Represents the state of a deployment resources job.
 */
model DeploymentResourcesJobState {
  ...JobState;
}

/**
 * Represents a list of retrieved training jobs.
 */
model TrainingJobs {
  /**
   * The list of jobs.
   */
  value: TrainingJobState[];

  /**
   * The next page link.
   */
  nextLink: string;
}

/**
 * Represents the state of a training job.
 */
model TrainingJobState {

  ...JobState;
  /**
   * Represents training tasks detailed result.
   */
  result: TrainingJobResult;
}

/**
 * Represents the output of a training job.
 */
model TrainingJobResult {
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
  trainingStatus: SubTrainingJobState;

  /**
   * Represents model evaluation status.
   */
  evaluationStatus?: SubTrainingJobState;

  /**
   * Represents the estimated end date time for training and evaluation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  estimatedEndDateTime?: utcDateTime;
}

/**
 * Represents the detailed state of a training sub-operation.
 */
model SubTrainingJobState {
  /**
   * Represents progress percentage.
   */
  percentComplete: int32;

  /**
   * Represents the start date time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * Represents the end date time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * Represents the status of the sub-operation.
   */
  status: JobStatus;
}

/**
 * Represents a list of retrieved projects' metadata.
 */
@resource("projects")
model ProjectsMetadata {
  /**
   * The list of projects.
   */
  @key
  @visibility
  value: ProjectMetadata[];

  /**
   * The next page link.
   */
  nextLink: string;
}

/**
 * Represents the state of a project deletion job.
 */
model ProjectDeletionJobState {
  ...JobState;
}

/**
 * Represents the metadata for deployments assigned to a resource.
 */
model AssignedResourceDeploymentsMetadata {
  /**
   * The list of retrieved assigned project deployments.
   */
  value: AssignedProjectDeploymentsMetadata[];

  /**
   * The next page link.
   */
  nextLink: string;
}

/**
 * Represents the metadata for assigned deployments for a project.
 */
model AssignedProjectDeploymentsMetadata {
  /**
   * Represents the project name.
   */
  projectName: string;

  /**
   * Represents the resource region.
   */
  deploymentsMetadata: AssignedProjectDeploymentMetadata[];
}

/**
 * Represents the metadata for an assigned deployment
 */
model AssignedProjectDeploymentMetadata {
  /**
   * Represents the deployment name.
   */
  deploymentName: string;

  /**
   * Represents deployment last deployed time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastDeployedDateTime: utcDateTime;

  /**
   * Represents deployment expiration date in the runtime.
   */
  deploymentExpirationDate: plainDate;
}

/**
 * Represents a list of retrieved languages.
 */
model SupportedLanguages {
  /**
   * The list of the languages.
   */
  value: SupportedLanguage[];

  /**
   * The next page link.
   */
  nextLink: string;
}

/**
 * Represents a supported language.
 */
model SupportedLanguage {
  /**
   * The language name.
   */
  languageName: string;

  /**
   * The language code. This is BCP-47 representation of a language. For example,
   * "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  languageCode: string;
}

/**
 * Represents a list of the retrieved supported prebuilt entities.
 */
model PrebuiltEntities {
  /**
   * The supported prebuilt entities.
   */
  value: PrebuiltEntity[];

  /**
   * The next page link.
   */
  nextLink: string;
}

/**
 * Represents a supported prebuilt entity.
 */
model PrebuiltEntity {
  /**
   * The prebuilt entity category.
   */
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
model TrainingConfigVersions {
  /**
   * The list of the training config versions.
   */
  value: TrainingConfigVersion[];

  /**
   * The next page link.
   */
  nextLink: string;
}

/**
 * Represents a training config version.
 */
model TrainingConfigVersion {
  /**
   * Represents the version of the config.
   */
  @clientName("trainingConfigVersion", "csharp")
  configVersion: string;

  /**
   * Represents the training config version expiration date.
   */
  modelExpirationDate: plainDate;
}

/**
 * Represents an entity with its components.
 */
model ConversationExportedEntity {
  /**
   * The category of the entity.
   */
  category: string;

  /**
   * The behavior to follow when the entity's components overlap with each other.
   */
  compositionSetting?: CompositionSetting;

  /**
   * The list component of the entity.
   */
  list?: ExportedEntityList;

  /**
   * The prebuilt entities components.
   */
  prebuilts?: ExportedPrebuiltEntity[];

  /**
   * The regex component of the entity.
   */
  regex?: ExportedEntityRegex;

  /**
   * The required components. Allowed values are 'learned', 'list', 'prebuilts' and 'regex'.
   */
  requiredComponents?: string[];
}

/**
 * Represents a list component of an entity.
 */
model ExportedEntityList {
  /**
   * The sub-lists of the list component.
   */
  sublists?: ExportedEntitySublist[];
}

/**
 * Represents a sub-list inside a list component.
 */
model ExportedEntitySublist {
  /**
   * The key of the sub-list.
   */
  listKey?: string;

  /**
   * The phrases of that correspond to the sub-list.
   */
  synonyms?: ExportedEntityListSynonym[];
}

/**
 * Represents a list of synonyms inside a list component
 */
model ExportedEntityListSynonym {
  /**
   * Represents the language of the synonyms. This is BCP-47 representation of a
   * language. For example, use "en" for English, "en-gb" for English (UK), "es" for
   * Spanish etc.
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
model ExportedPrebuiltEntity {
  /**
   * The prebuilt entity category.
   */
  category: string;
}

/**
 * Represents a regex component of an entity.
 */
model ExportedEntityRegex {
  /**
   * The regex expressions of the regex component. These expressions follow the .NET
   * regex syntax. For reference, check here:
   * https://learn.microsoft.com/dotnet/standard/base-types/regular-expressions
   */
  expressions?: ExportedEntityRegexExpression[];
}

/**
 * Represents a regex expression inside a regex component. This expression follows
 * the .NET regex syntax. For reference, check here:
 * https://learn.microsoft.com/dotnet/standard/base-types/regular-expressions
 */
model ExportedEntityRegexExpression {
  /**
   * The key of the regex expression.
   */
  regexKey?: string;

  /**
   * Represents the language of the regex expression. This is BCP-47 representation
   * of a language. For example, use "en" for English, "en-gb" for English (UK),
   * "es" for Spanish etc.
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
model ConversationExportedIntent {
  /**
   * The intent category.
   */
  category: string;
}

/**
 * Represents the exported assets of a conversational project.
 */
model ConversationExportedProjectAssets extends ExportedProjectAssets {
  /**
   * The intents defined in the project.
   */
  intents?: ConversationExportedIntent[];

  /**
   * The entities defined in the project.
   */
  entities?: ConversationExportedEntity[];

  /**
   * The utterances defined in the project.
   */
  utterances?: ConversationExportedUtterance[];

  /**
   * The type of project containing the assets.
   */
  projectKind: "Conversation";
}

/**
 * Represents an exported utterance for a conversational project.
 */
model ConversationExportedUtterance {
  /**
   * Represents the entity labels of the utterance.
   */
  entities?: ExportedUtteranceEntityLabel[];

  /**
   * The utterance text.
   */
  text: string;

  /**
   * Represents the utterance's language. This is BCP-47 representation of a
   * language. For example, use "en" for English, "en-gb" for English (UK), "es" for
   * Spanish etc.
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
 * Represents an entity label for an utterance.
 */
model ExportedUtteranceEntityLabel {
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ConversationSummarizationExportedProjectAssets {
  /**
   * Represents the conversations of the project.
   */
  conversations?: CustomConversationSummarizationConversation[];
}

/**
 * Represents an exported conversation for a custom conversation summarization.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model CustomConversationSummarizationConversation {
  summaryLocation?: string;

  /**
   * Represents the conversation file location in the blob store container
   * associated with the project.
   */
  location: string;

  /**
   * Represents the language. This is BCP-47 representation of a language. For
   * example, use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
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
model ExportedConversationOrchestration {
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
model ExportedConversationOrchestrationOptions
  extends ExportedOrchestrationOptions {
  /**
   * The Conversational project target details.
   */
  conversationOrchestration: ExportedConversationOrchestration;

  /**
   * The kind of the target used in the orchestration flow.
   */
  targetProjectKind: "Conversation";
}

/**
 * Represents the options used to define the orchestration behavior of an intent.
 */
@discriminator("targetProjectKind")
model ExportedOrchestrationOptions {
  targetProjectKind : OrchestrationTargetProjectKind;
}

/**
 * Defines the orchestration details for a LUIS application target.
 */
model ExportedLuisOrchestration {
  /**
   * The LUIS application ID.
   */
  appId: string;

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
model ExportedLuisOrchestrationOptions extends ExportedOrchestrationOptions {
  /**
   * The LUIS application target details.
   */
  luisOrchestration: ExportedLuisOrchestration;

  /**
   * The kind of the target used in the orchestration flow.
   */
  targetProjectKind: "Luis";
}

/**
 * Defines the orchestration details for a Question Answering project target.
 */
model ExportedQuestionAnsweringOrchestration {
  /**
   * The name of the target project.
   */
  projectName: string;
}

/**
 * Represents the orchestration options for a Question Answering project target.
 */
model ExportedQuestionAnsweringOrchestrationOptions
  extends ExportedOrchestrationOptions {
  /**
   * The Question Answering project details.
   */
  questionAnsweringOrchestration: ExportedQuestionAnsweringOrchestration;

  /**
   * The kind of the target used in the orchestration flow.
   */
  targetProjectKind: "QuestionAnswering";
}

/**
 * Represents an exported intent for an orchestration project.
 */
model OrchestrationExportedIntent {
  /**
   * Specifies the behavior of this intent in the orchestration flow.
   */
  orchestration?: ExportedOrchestrationOptions;

  /**
   * The intent category.
   */
  category: string;
}

/**
 * Represents the assets of an orchestration project.
 */
model OrchestrationExportedProjectAssets extends ExportedProjectAssets {
  /**
   * Represents the intents of the project.
   */
  intents?: OrchestrationExportedIntent[];

  /**
   * Represents the utterances of the project.
   */
  utterances?: OrchestrationExportedUtterance[];

  /**
   * The type of project containing the assets.
   */
  projectKind: "Orchestration";
}

/**
 * Represents an utterance of an orchestration project.
 */
model OrchestrationExportedUtterance {
  /**
   * The utterance text.
   */
  text: string;

  /**
   * Represents the utterance's language. This is BCP-47 representation of a
   * language. For example, use "en" for English, "en-gb" for English (UK), "es" for
   * Spanish etc.
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
