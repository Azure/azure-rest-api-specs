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

union ProjectKind {
  string,

  /**
   * For building a classification model to classify text using your own data. Each
   * file will have only one label. For example, file 1 is classified as A and file
   * 2 is classified as B.
   */
  CustomSingleLabelClassification: "CustomSingleLabelClassification",

  /**
   * For building a classification model to classify text using your own data. Each
   * file can have one or many labels. For example, file 1 is classified as A, B,
   * and C and file 2 is classified as B and C.
   */
  CustomMultiLabelClassification: "CustomMultiLabelClassification",

  /**
   * For building an extraction model to identify your domain categories using your
   * own data.
   */
  CustomEntityRecognition: "CustomEntityRecognition",

  /**
   * For building an abstractive summarization models which are able to summarize
   * long documents.
   */
  CustomAbstractiveSummarization: "CustomAbstractiveSummarization",

  /**
   * For building an text analytics for health model to identify your health domain
   * data.
   */
  CustomHealthcare: "CustomHealthcare",

  /**
   * For building a sentiment models which are able to extract sentiment for long
   * documents.
   */
  CustomTextSentiment: "CustomTextSentiment",
}

/**
 * Human-readable error code.
 */
union ErrorCode {
  string,
  InvalidRequest: "InvalidRequest",
  InvalidArgument: "InvalidArgument",
  Unauthorized: "Unauthorized",
  Forbidden: "Forbidden",
  NotFound: "NotFound",
  ProjectNotFound: "ProjectNotFound",
  OperationNotFound: "OperationNotFound",
  AzureCognitiveSearchNotFound: "AzureCognitiveSearchNotFound",
  AzureCognitiveSearchIndexNotFound: "AzureCognitiveSearchIndexNotFound",
  TooManyRequests: "TooManyRequests",
  AzureCognitiveSearchThrottling: "AzureCognitiveSearchThrottling",
  AzureCognitiveSearchIndexLimitReached: "AzureCognitiveSearchIndexLimitReached",
  InternalServerError: "InternalServerError",
  ServiceUnavailable: "ServiceUnavailable",
  Timeout: "Timeout",
  QuotaExceeded: "QuotaExceeded",
  Conflict: "Conflict",
  Warning: "Warning",
}

/**
 * Human-readable error code.
 */
union InnerErrorCode {
  string,
  InvalidRequest: "InvalidRequest",
  InvalidParameterValue: "InvalidParameterValue",
  KnowledgeBaseNotFound: "KnowledgeBaseNotFound",
  AzureCognitiveSearchNotFound: "AzureCognitiveSearchNotFound",
  AzureCognitiveSearchThrottling: "AzureCognitiveSearchThrottling",
  ExtractionFailure: "ExtractionFailure",
  InvalidRequestBodyFormat: "InvalidRequestBodyFormat",
  EmptyRequest: "EmptyRequest",
  MissingInputDocuments: "MissingInputDocuments",
  InvalidDocument: "InvalidDocument",
  ModelVersionIncorrect: "ModelVersionIncorrect",
  InvalidDocumentBatch: "InvalidDocumentBatch",
  UnsupportedLanguageCode: "UnsupportedLanguageCode",
  InvalidCountryHint: "InvalidCountryHint",
}

union StringIndexType {
  string,

  /**
   * The offset and length values will correspond to UTF-16 code units. Use this
   * option if your application is written in a language that support Unicode, for
   * example Java, JavaScript.
   */
  Utf16CodeUnit: "Utf16CodeUnit",
}

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

union JobStatus {
  string,
  notStarted: "notStarted",
  running: "running",
  succeeded: "succeeded",
  failed: "failed",
  cancelled: "cancelled",
  cancelling: "cancelling",
  partiallyCompleted: "partiallyCompleted",
}

union Sentiment {
  string,
  positive: "positive",
  negative: "negative",
  neutral: "neutral",
}

union CompositionSetting {
  string,

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

/**
 * Represents a list of retrieved projects' metadata.
 */
model ProjectsMetadata is Azure.Core.Page<ProjectMetadata>;

/**
 * Represents the metadata of a project.
 */
model ProjectMetadata {
  /**
   * Represents the project creation datetime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  /**
   * Represents the project last modification datetime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime: utcDateTime;

  /**
   * Represents the project last training datetime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTrainedDateTime?: utcDateTime;

  /**
   * Represents the project last deployment datetime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastDeployedDateTime?: utcDateTime;

  /**
   * The project kind.
   */
  projectKind: ProjectKind;

  /**
   * The storage container name.
   */
  storageInputContainerName: string;

  /**
   * The project settings.
   */
  settings?: ProjectSettings;

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
 * Represents the settings used to define the project behavior.
 */
model ProjectSettings {
  /**
   * The threshold of the class with the highest confidence, at which the prediction
   * will automatically be changed to "None". The value of the threshold should be
   * between 0 and 1 inclusive.
   */
  confidenceThreshold?: float32;

  /**
   * The path to the AML connected project.
   */
  amlProjectPath?: string;

  /**
   * Indicates whether the labeling experience can be modified or not.
   */
  isLabelingLocked?: boolean;

  /**
   * Indicates whether to run GPT predictions or not.
   */
  runGptPredictions?: boolean;

  /**
   * The predictive lookahead for GPT predictions that is specified by the user.
   */
  gptPredictiveLookahead?: int32;
}

/**
 * Error response.
 */
@error
model ErrorResponse {
  /**
   * The error object.
   */
  error: Error;
}

/**
 * The error object.
 */
model Error {
  ...Record<unknown>;

  /**
   * One of a server-defined set of error codes.
   */
  code: ErrorCode;

  /**
   * A human-readable representation of the error.
   */
  message: string;

  /**
   * The target of the error.
   */
  target?: string;

  /**
   * An array of details about specific errors that led to this reported error.
   */
  details?: Error[];

  /**
   * An object containing more specific information than the current object about
   * the error.
   */
  innererror?: InnerErrorModel;
}

/**
 * An object containing more specific information about the error. As per
 * Microsoft One API guidelines -
 * https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#7102-error-condition-responses.
 */
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
   * An object containing more specific information than the current object about
   * the error.
   */
  innererror?: InnerErrorModel;
}

/**
 * Represents the options used to create or update a project.
 */
model CreateProjectOptions {
  /**
   * The project kind.
   */
  projectKind: ProjectKind;

  /**
   * The storage container name.
   */
  storageInputContainerName: string;

  /**
   * The project settings.
   */
  settings?: ProjectSettings;

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
model ExportedProjectAssets {}

/**
 * Represents the options for starting a new training job.
 */
model TrainingJobOptions {
  /**
   * Represents the output model label.
   */
  modelLabel: string;

  /**
   * Represents training config version.
   */
  trainingConfigVersion: string;

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
model CopyProjectJobState extends JobState {}

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
model ProjectDeployments is Azure.Core.Page<ProjectDeployment>;

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
model DeploymentJobState extends JobState {}

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
model ExportProjectJobState extends JobState {
  /**
   * The URL to use in order to download the exported project.
   */
  resultUrl?: string;
}

/**
 * Represents a list of exported trained models.
 */
model ExportedTrainedModels is Azure.Core.Page<ExportedTrainedModel>;

/**
 * Represents an exported trained model.
 */
model ExportedTrainedModel {
  /**
   * The exported model name.
   */
  exportedModelName: string;

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
   * The last exported date time of the model.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastExportedModelDateTime: utcDateTime;

  /**
   * The model expiration date.
   */
  modelExpirationDate: plainDate;

  /**
   * The model training config version.
   */
  modelTrainingConfigVersion: string;
}

/**
 * Represents the options for creating or replacing an exported model.
 */
model ExportedModelOptions {
  /**
   * The trained model label.
   */
  trainedModelLabel: string;
}

/**
 * Represents the state of a job to create or updated an exported model.
 */
model ExportedModelJobState extends JobState {}

/**
 * Represents the properties for the exported model manifest.
 */
model ExportedModelManifest {
  /**
   * The model files belonging to this model.
   */
  modelFiles: ModelFile[];
}

/**
 * Represents the properties for the model file.
 */
model ModelFile {
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
 * Represents the state of an import job.
 */
model ImportProjectJobState extends JobState {}

/**
 * Represents a list of retrieved trained models.
 */
model ProjectTrainedModels is Azure.Core.Page<ProjectTrainedModel>;

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
 * Represents the state of a evaluation job.
 */
model EvaluationJobState extends JobState {
  /**
   * Represents evaluation task detailed result.
   */
  result: EvaluationJobResult;
}

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
  percentComplete: int32;
}

/**
 * Represents a list of results for an evaluation operation.
 */
model EvaluationResults is Azure.Core.Page<DocumentEvaluationResult>;

/**
 * Represents the evaluation result of a document.
 */
@discriminator("projectKind")
model DocumentEvaluationResult {
  /**
   * Represents the document path.
   */
  location: string;

  /**
   * Represents the document language. This is BCP-47 representation of a language.
   * For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish
   * etc.
   */
  language: string;
}

/**
 * Represents the summary for an evaluation operation.
 */
@discriminator("projectKind")
model EvaluationSummary {
  /**
   * Represents the options used running the evaluation.
   */
  evaluationOptions: EvaluationOptions;
}

/**
 * Represents the state of loading a snapshot job.
 */
model LoadSnapshotJobState extends JobState {}

/**
 * Represents the assigned deployment resources.
 */
model AssignedDeploymentResources
  is Azure.Core.Page<AssignedDeploymentResource>;

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
model DeploymentResourcesJobState extends JobState {}

/**
 * Represents a list of retrieved training jobs.
 */
model TrainingJobs is Azure.Core.Page<TrainingJobState>;

/**
 * Represents the state of a training job.
 */
model TrainingJobState extends JobState {
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
   * Represents model train status.
   */
  trainingStatus: SubTrainingJobState;

  /**
   * Represents model evaluation status.
   */
  evaluationStatus?: SubTrainingJobState;

  /**
   * Represents the estimate end date time for training and evaluation.
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
 * Represents the state of a project deletion job.
 */
model ProjectDeletionJobState extends JobState {}

/**
 * Represents the metadata for deployments assigned to a resource.
 */
model AssignedResourceDeploymentsMetadata
  is Azure.Core.Page<AssignedProjectDeploymentsMetadata>;

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
model SupportedLanguages is Azure.Core.Page<SupportedLanguage>;

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
model PrebuiltEntities is Azure.Core.Page<PrebuiltEntity>;

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
model TrainingConfigVersions is Azure.Core.Page<TrainingConfigVersion>;

/**
 * Represents a training config version.
 */
model TrainingConfigVersion {
  /**
   * Represents the version of the config.
   */
  trainingConfigVersion: string;

  /**
   * Represents the training config version expiration date.
   */
  modelExpirationDate: plainDate;
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
 * Represents the document evaluation result for a custom entity recognition
 * project.
 */
model CustomEntityRecognitionDocumentEvaluationResult
  extends DocumentEvaluationResult {
  /**
   * Represents the evaluation prediction for entity recognition.
   */
  customEntityRecognitionResult: DocumentEntityRecognitionEvaluationResult;

  /**
   * Represents the project kind.
   */
  projectKind: "CustomEntityRecognition";
}

/**
 * Represents the entity recognition evaluation result for a document.
 */
model DocumentEntityRecognitionEvaluationResult {
  /**
   * Represents the document labelled entities.
   */
  entities: DocumentEntityRegionEvaluationResult[];
}

/**
 * Represents the evaluation comparison between the expected and predicted
 * entities of a document region.
 */
model DocumentEntityRegionEvaluationResult {
  /**
   * Represents the region's expected entity labels.
   */
  expectedEntities: DocumentEntityLabelEvaluationResult[];

  /**
   * Represents the region's predicted entity labels.
   */
  predictedEntities: DocumentEntityLabelEvaluationResult[];

  /**
   * Represents the region offset.
   */
  regionOffset: int32;

  /**
   * Represents the region length.
   */
  regionLength: int32;
}

/**
 * Represents an evaluation result entity label.
 */
model DocumentEntityLabelEvaluationResult {
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
 * Represents the evaluation summary for a custom entity recognition project.
 */
model CustomEntityRecognitionEvaluationSummary extends EvaluationSummary {
  /**
   * Contains the data related to extraction evaluation.
   */
  customEntityRecognitionEvaluation: EntityRecognitionEvaluationSummary;

  /**
   * Represents the project type that the evaluation ran on.
   */
  projectKind: "CustomEntityRecognition";
}

/**
 * Represents the evaluation summary for a custom entity recognition project.
 */
model EntityRecognitionEvaluationSummary {
  /**
   * Represents the confusion matrix between two entities (the two entities can be
   * the same). The matrix is between the entity that was labelled and the entity
   * that was predicted.
   */
  confusionMatrix: Record<Record<ConfusionMatrixCell>>;

  /**
   * Represents the entities evaluation
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
 * Represents the evaluation summary for an entity.
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
 * Represents the document evaluation result for a custom entity recognition
 * project.
 */
model CustomHealthcareDocumentEvaluationResult
  extends DocumentEvaluationResult {
  /**
   * Represents the evaluation prediction for entity recognition.
   */
  customHealthcareResult: DocumentHealthcareEvaluationResult;

  /**
   * Represents the project kind.
   */
  projectKind: "CustomHealthcare";
}

/**
 * Represents the healthcare evaluation result for a document.
 */
model DocumentHealthcareEvaluationResult {
  /**
   * Represents the document labelled entities.
   */
  entities: DocumentEntityRegionEvaluationResult[];
}

/**
 * Represents the evaluation summary for a custom health care project.
 */
model CustomHealthcareEvaluationSummary extends EvaluationSummary {
  /**
   * Contains the data related to health care evaluation.
   */
  customHealthcareEvaluation: EntityRecognitionEvaluationSummary;

  /**
   * Represents the project type that the evaluation ran on.
   */
  projectKind: "CustomHealthcare";
}

/**
 * Represents the document evaluation result for a custom multi-label
 * classification project.
 */
model CustomMultiLabelClassificationDocumentEvaluationResult
  extends DocumentEvaluationResult {
  /**
   * Represents the evaluation prediction for multi label classification.
   */
  customMultiLabelClassificationResult: DocumentMultiLabelClassificationEvaluationResult;

  /**
   * Represents the project kind.
   */
  projectKind: "CustomMultiLabelClassification";
}

/**
 * Represents the comparison between the expected and predicted classes that are
 * result from the evaluation operation.
 */
model DocumentMultiLabelClassificationEvaluationResult {
  /**
   * Represents the document's expected classes.
   */
  expectedClasses: string[];

  /**
   * Represents the document's predicted classes.
   */
  predictedClasses: string[];
}

/**
 * Represents the evaluation summary for a custom multi-label classification
 * project.
 */
model CustomMultiLabelClassificationEvaluationSummary
  extends EvaluationSummary {
  /**
   * Contains the data related to multi label classification evaluation.
   */
  customMultiLabelClassificationEvaluation: MultiLabelClassificationEvaluationSummary;

  /**
   * Represents the project type that the evaluation ran on.
   */
  projectKind: "CustomMultiLabelClassification";
}

/**
 * Represents the evaluation summary for a multi-label classification project.
 */
model MultiLabelClassificationEvaluationSummary {
  /**
   * Represents the classes evaluation
   */
  classes: Record<MultiLabelClassEvaluationSummary>;

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
 * Represents the evaluation summary of a class in a multi-label classification
 * project.
 */
model MultiLabelClassEvaluationSummary {
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
 * Represents the document evaluation result for a custom single-label
 * classification project.
 */
model CustomSingleLabelClassificationDocumentEvaluationResult
  extends DocumentEvaluationResult {
  /**
   * Represents the evaluation prediction for single label classification.
   */
  customSingleLabelClassificationResult: DocumentSingleLabelClassificationEvaluationResult;

  /**
   * Represents the project kind.
   */
  projectKind: "CustomSingleLabelClassification";
}

/**
 * Represents the comparison between the expected and predicted class that result
 * from an evaluation operation.
 */
model DocumentSingleLabelClassificationEvaluationResult {
  /**
   * Represents the document's expected class.
   */
  expectedClass: string;

  /**
   * Represents the document's predicted class.
   */
  predictedClass: string;
}

/**
 * Represents the evaluation summary for a custom single-label classification
 * project.
 */
model CustomSingleLabelClassificationEvaluationSummary
  extends EvaluationSummary {
  /**
   * Contains the data related to single label classification evaluation.
   */
  customSingleLabelClassificationEvaluation: SingleLabelClassificationEvaluationSummary;

  /**
   * Represents the project type that the evaluation ran on.
   */
  projectKind: "CustomSingleLabelClassification";
}

/**
 * Represents the evaluation summary for a custom single-label classification
 * project.
 */
model SingleLabelClassificationEvaluationSummary {
  /**
   * Represents the confusion matrix between two classes (the two classes can be the
   * same). The matrix is between the class that was labelled and the class that was
   * predicted.
   */
  confusionMatrix: Record<Record<ConfusionMatrixCell>>;

  /**
   * Represents the classes evaluation
   */
  classes: Record<SingleLabelClassEvaluationSummary>;

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
 * Represents the evaluation summary for a class in a single-label classification
 * project.
 */
model SingleLabelClassEvaluationSummary {
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
 * Represents the document evaluation result for a custom sentiment project.
 */
model CustomTextSentimentDocumentEvaluationResult
  extends DocumentEvaluationResult {
  /**
   * Represents the evaluation prediction for text sentiment.
   */
  customTextSentimentResult: DocumentTextSentimentEvaluationResult;

  /**
   * Represents the project kind.
   */
  projectKind: "CustomTextSentiment";
}

/**
 * Represents the comparison between the expected and predicted sentiment that
 * result from an evaluation operation.
 */
model DocumentTextSentimentEvaluationResult {
  /**
   * Represents the document's expected sentiment labels.
   */
  expectedSentimentSpans: DocumentSentimentLabelEvaluationResult[];

  /**
   * Represents the document's predicted sentiment labels.
   */
  predictedSentimentSpans: DocumentSentimentLabelEvaluationResult[];
}

/**
 * Represents an evaluation result Sentiment label.
 */
model DocumentSentimentLabelEvaluationResult {
  /**
   * Represents the sentiment category.
   */
  category: Sentiment;

  /**
   * Represents the sentiment offset index relative to the original text.
   */
  offset: int32;

  /**
   * Represents the sentiment length.
   */
  length: int32;
}

/**
 * Represents the evaluation summary for a custom text sentiment project.
 */
model CustomTextSentimentEvaluationSummary extends EvaluationSummary {
  /**
   * Contains the data related to custom sentiment evaluation.
   */
  customTextSentimentEvaluation: TextSentimentEvaluationSummary;

  /**
   * Represents the project type that the evaluation ran on.
   */
  projectKind: "CustomTextSentiment";
}

/**
 * Represents the evaluation summary for a custom text sentiment project.
 */
model TextSentimentEvaluationSummary {
  /**
   * Represents evaluation of span level sentiments
   */
  spanSentimentsEvaluation: SpanSentimentEvaluationSummary;

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
 * Represents the evaluation summary for a custom sentiment project.
 */
model SpanSentimentEvaluationSummary {
  /**
   * Represents the confusion matrix between two sentiments (the two sentiments can
   * be the same). The matrix is between the sentiment that was labelled and the
   * sentiment that was predicted.
   */
  confusionMatrix: Record<Record<ConfusionMatrixCell>>;

  /**
   * Represents the sentiment evaluation
   */
  sentiments: Record<SentimentEvaluationSummary>;

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
 * Represents the evaluation summary for a sentiment in a custom sentiment project.
 */
model SentimentEvaluationSummary {
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
 * Represents a class of an exported project.
 */
model ExportedClass {
  /**
   * The class category.
   */
  category?: string;
}

/**
 * Represents an entity in an exported project with composite entities enabled.
 */
model ExportedCompositeEntity {
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
   * The entity category.
   */
  category?: string;
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
 * Represents an exported document for a custom abstractive summarization project.
 */
model ExportedCustomAbstractiveSummarizationDocument {
  /**
   * Represents the summary file location in the blob store container associated
   * with the project.
   */
  summaryLocation: string;

  /**
   * The location of the document in the storage.
   */
  location?: string;

  /**
   * Represents the document language. This is BCP-47 representation of a language.
   * For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish
   * etc.
   */
  language?: string;

  /**
   * The dataset for this document. Allowed values are 'Train' and 'Test'.
   */
  dataset?: string;
}

/**
 * Represents the exported assets for an abstractive summarization project.
 */
model ExportedCustomAbstractiveSummarizationProjectAssets
  extends ExportedProjectAssets {
  /**
   * The list of documents belonging to this project.
   */
  documents?: ExportedCustomAbstractiveSummarizationDocument[];

  /**
   * The type of the project the assets belong to.
   */
  projectKind: "CustomAbstractiveSummarization";
}

/**
 * Represents an exported document for a custom entity recognition project.
 */
model ExportedCustomEntityRecognitionDocument {
  /**
   * The list of entity labels belonging to the document.
   */
  entities?: ExportedDocumentEntityRegion[];

  /**
   * The location of the document in the storage.
   */
  location?: string;

  /**
   * Represents the document language. This is BCP-47 representation of a language.
   * For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish
   * etc.
   */
  language?: string;

  /**
   * The dataset for this document. Allowed values are 'Train' and 'Test'.
   */
  dataset?: string;
}

/**
 * Represents a region in a document for entity labeling.
 */
model ExportedDocumentEntityRegion {
  /**
   * Start position for the region.
   */
  regionOffset?: int32;

  /**
   * Length for the region text.
   */
  regionLength?: int32;

  /**
   * The list of entity labels belonging to this region.
   */
  labels?: ExportedDocumentEntityLabel[];
}

/**
 * Represents an entity label for a document.
 */
model ExportedDocumentEntityLabel {
  /**
   * The entity category.
   */
  category?: string;

  /**
   * Start position for the entity text.
   */
  offset?: int32;

  /**
   * Length for the entity text.
   */
  length?: int32;
}

/**
 * Represents the exported assets for a entity recognition project.
 */
model ExportedCustomEntityRecognitionProjectAssets
  extends ExportedProjectAssets {
  /**
   * The list of entities belonging to the project.
   */
  entities?: ExportedEntity[];

  /**
   * The list of documents belonging to the project.
   */
  documents?: ExportedCustomEntityRecognitionDocument[];

  /**
   * The type of the project the assets belong to.
   */
  projectKind: "CustomEntityRecognition";
}

/**
 * Represents an entity in an exported project.
 */
model ExportedEntity {
  /**
   * The entity category.
   */
  category?: string;
}

/**
 * Represents an exported document for a CustomHealthcare project.
 */
model ExportedCustomHealthcareDocument {
  /**
   * The list of entity labels belonging to the document.
   */
  entities?: ExportedDocumentEntityRegion[];

  /**
   * The location of the document in the storage.
   */
  location?: string;

  /**
   * Represents the document language. This is BCP-47 representation of a language.
   * For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish
   * etc.
   */
  language?: string;

  /**
   * The dataset for this document. Allowed values are 'Train' and 'Test'.
   */
  dataset?: string;
}

/**
 * Represents the exported assets for a CustomHealthcare project.
 */
model ExportedCustomHealthcareProjectAssets extends ExportedProjectAssets {
  /**
   * The list of entities belonging to the project.
   */
  entities?: ExportedCompositeEntity[];

  /**
   * The list of documents belonging to the project.
   */
  documents?: ExportedCustomHealthcareDocument[];

  /**
   * The type of the project the assets belong to.
   */
  projectKind: "CustomHealthcare";
}

/**
 * Represents an exported document of a custom multi-label classification project.
 */
model ExportedCustomMultiLabelClassificationDocument {
  /**
   * The document classes.
   */
  classes?: ExportedDocumentClass[];

  /**
   * The location of the document in the storage.
   */
  location?: string;

  /**
   * Represents the document language. This is BCP-47 representation of a language.
   * For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish
   * etc.
   */
  language?: string;

  /**
   * The dataset for this document. Allowed values are 'Train' and 'Test'.
   */
  dataset?: string;
}

/**
 * Represents a classification label for a document.
 */
model ExportedDocumentClass {
  category?: string;
}

/**
 * Represents the exported assets for a custom multi-label classification project.
 */
model ExportedCustomMultiLabelClassificationProjectAssets
  extends ExportedProjectAssets {
  /**
   * The list of classes in the project.
   */
  classes?: ExportedClass[];

  /**
   * The list of documents in the project.
   */
  documents?: ExportedCustomMultiLabelClassificationDocument[];

  /**
   * The type of the project the assets belong to.
   */
  projectKind: "CustomMultiLabelClassification";
}

/**
 * Represents an exported document for a custom single-label classification
 * project.
 */
model ExportedCustomSingleLabelClassificationDocument {
  /**
   * The class of the documents.
   */
  class?: ExportedDocumentClass;

  /**
   * The location of the document in the storage.
   */
  location?: string;

  /**
   * Represents the document language. This is BCP-47 representation of a language.
   * For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish
   * etc.
   */
  language?: string;

  /**
   * The dataset for this document. Allowed values are 'Train' and 'Test'.
   */
  dataset?: string;
}

/**
 * Represents the exported assets for a single-label classification project.
 */
model ExportedCustomSingleLabelClassificationProjectAssets
  extends ExportedProjectAssets {
  /**
   * The list of classes belonging to this project.
   */
  classes?: ExportedClass[];

  /**
   * The list of documents belonging to this project.
   */
  documents?: ExportedCustomSingleLabelClassificationDocument[];

  /**
   * The type of the project the assets belong to.
   */
  projectKind: "CustomSingleLabelClassification";
}

/**
 * Represents an exported document for a custom text sentiment project.
 */
model ExportedCustomTextSentimentDocument {
  sentimentSpans?: ExportedDocumentSentimentLabel[];

  /**
   * The location of the document in the storage.
   */
  location?: string;

  /**
   * Represents the document language. This is BCP-47 representation of a language.
   * For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish
   * etc.
   */
  language?: string;

  /**
   * The dataset for this document. Allowed values are 'Train' and 'Test'.
   */
  dataset?: string;
}

/**
 * Represents an entity label for a document.
 */
model ExportedDocumentSentimentLabel {
  /**
   * The sentiment category.
   */
  category?: Sentiment;

  /**
   * Start position for the sentiment text.
   */
  offset?: int32;

  /**
   * Length for the sentiment text.
   */
  length?: int32;
}

/**
 * Represents the exported assets for a custom text sentiment project.
 */
model ExportedCustomTextSentimentProjectAssets extends ExportedProjectAssets {
  /**
   * The list of documents belonging to the project.
   */
  documents?: ExportedCustomTextSentimentDocument[];

  /**
   * The type of the project the assets belong to.
   */
  projectKind: "CustomTextSentiment";
}
