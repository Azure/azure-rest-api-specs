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

namespace Language.Authoring.Text;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
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
  @added(Versions.v2023_04_15_preview)
  CustomAbstractiveSummarization: "CustomAbstractiveSummarization",

  /**
   * For building an text analytics for health model to identify your health domain
   * data.
   */
  @added(Versions.v2023_04_15_preview)
  CustomHealthcare: "CustomHealthcare",

  /**
   * For building a sentiment models which are able to extract sentiment for long
   * documents.
   */
  @added(Versions.v2023_04_15_preview)
  CustomTextSentiment: "CustomTextSentiment",
}

/**
 * Human-readable error code.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
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
#suppress "@azure-tools/typespec-azure-core/documentation-required"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
union StringIndexType {
  string,

  /**
   * The offset and length values will correspond to UTF-16 code units. Use this
   * option if your application is written in a language that support Unicode, for
   * example Java, JavaScript.
   */
  Utf16CodeUnit: "Utf16CodeUnit",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("EvaluationKind")
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@lroStatus
@clientName("JobStatus", "csharp")
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
union Sentiment {
  string,
  positive: "positive",
  negative: "negative",
  neutral: "neutral",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
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
@clientName("ProjectsMetadata", "csharp")
model TextAnalysisAuthoringProjectsMetadata {
  /**
   * The list of projects.
   */
  value: TextAnalysisAuthoringProjectMetadata[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents the metadata of a project.
 */
@resource("authoring/analyze-text/projects")
@clientName("ProjectMetadata", "csharp")
model TextAnalysisAuthoringProjectMetadata {
  /**
   * Represents the project creation datetime.
   */
  createdDateTime: utcDateTime;

  /**
   * Represents the project last modification datetime.
   */
  lastModifiedDateTime: utcDateTime;

  /**
   * Represents the project last training datetime.
   */
  lastTrainedDateTime?: utcDateTime;

  /**
   * Represents the project last deployment datetime.
   */
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
  settings?: TextAnalysisAuthoringProjectSettings;

  /**
   * The new project name.
   */
  @key("projectName")
  @visibility
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
@clientName("ProjectSettings")
model TextAnalysisAuthoringProjectSettings {
  /**
   * The threshold of the class with the highest confidence, at which the prediction
   * will automatically be changed to "None". The value of the threshold should be
   * between 0 and 1 inclusive.
   */
  confidenceThreshold?: float32;

  /**
   * The path to the AML connected project.
   */
  @added(Versions.v2023_04_15_preview)
  amlProjectPath?: string;

  /**
   * Indicates whether the labeling experience can be modified or not.
   */
  @added(Versions.v2023_04_15_preview)
  isLabelingLocked?: boolean;

  /**
   * Indicates whether to run GPT predictions or not.
   */
  @added(Versions.v2023_04_15_preview)
  runGptPredictions?: boolean;

  /**
   * The predictive lookahead for GPT predictions that is specified by the user.
   */
  @added(Versions.v2023_04_15_preview)
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
@clientName("CreateProjectOptions")
model TextAnalysisAuthoringCreateProjectOptions {
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
  settings?: TextAnalysisAuthoringProjectSettings;

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
@clientName("CopyAuthorizationOptions")
model TextAnalysisAuthoringCopyAuthorizationOptions {
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
@clientName("CopyProjectOptions")
model TextAnalysisAuthoringCopyProjectOptions {
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
@clientName("ExportedProject")
model TextAnalysisAuthoringExportedProject {
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
  metadata: TextAnalysisAuthoringCreateProjectOptions;

  /**
   * Represents the project assets.
   */
  assets?: TextAnalysisAuthoringExportedProjectAssets;
}

/**
 * Represents the assets of an exported project.
 */
@discriminator("projectKind")
@clientName("ExportedProjectAssets")
model TextAnalysisAuthoringExportedProjectAssets {
  projectKind: ProjectKind;
}

/**
 * Represents the options for starting a new training job.
 */
@clientName("TrainingJobOptions")
model TextAnalysisAuthoringTrainingJobOptions {
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
  evaluationOptions?: TextAnalysisAuthoringEvaluationOptions;

  /**
   * Represents the settings for using data generation as part of training a custom model.
   */
  @added(Versions.v2024_11_15_preview)
  dataGenerationSettings?: TextAnalysisAuthoringDataGenerationSettings;
}

/**
 * Represents the settings for using data generation as part of training a custom model.
 */
@added(Versions.v2024_11_15_preview)
@clientName("DataGenerationSettings")
model TextAnalysisAuthoringDataGenerationSettings {
  /**
   * If set to true, augment customer provided training data with synthetic data to improve model quality.
   */
  enableDataGeneration: boolean;

  /**
   * Represents the connection info for the Azure resource to use during data generation as part of training a custom model.
   */
  @added(Versions.v2024_11_15_preview)
  dataGenerationConnectionInfo: TextAnalysisAuthoringDataGenerationConnectionInfo;
}

/**
 * Represents the connection info for the Azure resource to use during data generation as part of training a custom model.
 */
@added(Versions.v2024_11_15_preview)
@clientName("DataGenerationConnectionInfo")
model TextAnalysisAuthoringDataGenerationConnectionInfo {
  /**
   * Connection type for data generation settings. Currently only supports Azure Open AI.
   */
  kind: "azureOpenAI";

  /**
   * Resource ID for the data generation resource. Looks something like "/subscriptions/<SUBSCRIPTION-ID-GUID>/resourceGroups/<RG-NAME>/providers/Microsoft.CognitiveServices/accounts/<AOAI-ACCOUNT-NAME>".
   */
  resourceId: string;

  /**
   * Deployment name of model to be used for synthetic data generation.
   */
  deploymentName: string;
}

/**
 * Represents the options used running the evaluation.
 */
@clientName("EvaluationOptions")
model TextAnalysisAuthoringEvaluationOptions {
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
@added(Versions.v2023_04_15_preview)
@clientName("CopyProjectJobState", "csharp")
@resource("copy/jobs")
@parentResource(TextAnalysisAuthoringProjectMetadata)
model TextAnalysisAuthoringCopyProjectJobState {
  ...TextAnalysisAuthoringJobState;
}

/**
 * Represents a job's state.
 */
@clientName("JobState", "csharp")
model TextAnalysisAuthoringJobState {
  /**
   * The job ID.
   */
  @key("jobId")
  @visibility
  jobId: string;

  /**
   * The creation date time of the job.
   */
  createdDateTime: utcDateTime;

  /**
   * The last date time the job was updated.
   */
  lastUpdatedDateTime: utcDateTime;

  /**
   * The expiration date time of the job.
   */
  expirationDateTime?: utcDateTime;

  /**
   * The job status.
   */
  status: JobStatus;

  /**
   * The warnings that were encountered while executing the job.
   */
  warnings?: TextAnalysisAuthoringWarning[];

  /**
   * The errors encountered while executing the job.
   */
  errors?: Error[];
}

/**
 * Represents a warning that was encountered while executing the request.
 */
@clientName("Warning", "csharp")
model TextAnalysisAuthoringWarning {
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
@clientName("ProjectDeployments", "csharp")
model TextAnalysisAuthoringProjectDeployments {
  /**
   * The list of projects.
   */
  value: TextAnalysisAuthoringProjectDeployment[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents a project deployment.
 */
@clientName("ProjectDeployment", "csharp")
@resource("deployments")
@parentResource(TextAnalysisAuthoringProjectMetadata)
model TextAnalysisAuthoringProjectDeployment {
  /**
   * Represents deployment name.
   */
  @key("deploymentName")
  @visibility
  deploymentName: string;

  /**
   * Represents deployment modelId.
   */
  modelId: string;

  /**
   * Represents deployment last trained time.
   */
  lastTrainedDateTime: utcDateTime;

  /**
   * Represents deployment last deployed time.
   */
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
  @added(Versions.v2023_04_15_preview)
  assignedResources: TextAnalysisAuthoringDeploymentResource[];
}

/**
 * Represents an Azure resource assigned to a deployment.
 */
@clientName("DeploymentResource", "csharp")
model TextAnalysisAuthoringDeploymentResource {
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
@clientName("CreateDeploymentOptions", "csharp")
model TextAnalysisAuthoringCreateDeploymentOptions {
  /**
   * Represents the trained model label.
   */
  trainedModelLabel: string;

  /**
   * Represents the resource IDs to be assigned to the deployment.
   *             If provided, the deployment will be rolled out to the resources
   * provided here as well as the original resource in which the project is created.
   */
  @added(Versions.v2023_04_15_preview)
  assignedResourceIds?: string[];
}

/**
 * Represents the options for deleting a project deployment.
 */
@added(Versions.v2023_04_15_preview)
@clientName("DeleteDeploymentOptions", "csharp")
model TextAnalysisAuthoringDeleteDeploymentOptions {
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
@clientName("DeploymentJobState", "csharp")
@parentResource(TextAnalysisAuthoringProjectDeployment)
@resource("jobs")
model TextAnalysisAuthoringDeploymentJobState {
  ...TextAnalysisAuthoringJobState;
}

/**
 * Represents the state of an existing delete deployment from specific resources job.
 */
@clientName("DeploymentDeleteFromResourcesJobState", "csharp")
@parentResource(TextAnalysisAuthoringProjectDeployment)
@resource("delete-from-resources/jobs")
model TextAnalysisAuthoringDeploymentDeleteFromResourcesJobState {
  ...TextAnalysisAuthoringJobState;
}

/**
 * Represents the state of a deployment job.
 */
@clientName("SwapDeploymentsJobState", "csharp")
@parentResource(TextAnalysisAuthoringProjectMetadata)
@resource("deployments/swap/jobs")
model TextAnalysisAuthoringSwapDeploymentsJobState {
  ...TextAnalysisAuthoringJobState;
}

/**
 * Represents the options for swapping two deployments together.
 */
@clientName("SwapDeploymentsOptions")
model TextAnalysisAuthoringSwapDeploymentsOptions {
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
@clientName("ExportProjectJobState", "csharp")
@resource("export/jobs")
@parentResource(TextAnalysisAuthoringProjectMetadata)
model TextAnalysisAuthoringExportProjectJobState {
  ...TextAnalysisAuthoringJobState;

  /**
   * The URL to use in order to download the exported project.
   */
  resultUrl?: string;
}

/**
 * Represents a list of exported trained models.
 */
@clientName("ExportedTrainedModels", "csharp")
model TextAnalysisAuthoringExportedTrainedModels {
  /**
   * The list of projects.
   */
  value: TextAnalysisAuthoringExportedTrainedModel[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents an exported trained model.
 */
@clientName("ExportedTrainedModel", "csharp")
@resource("exported-models")
@parentResource(TextAnalysisAuthoringProjectMetadata)
model TextAnalysisAuthoringExportedTrainedModel {
  /**
   * The exported model name.
   */
  @key("exportedModelName")
  @visibility
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
@clientName("ExportedModelOptions")
model TextAnalysisAuthoringExportedModelOptions {
  /**
   * The trained model label.
   */
  trainedModelLabel: string;
}

/**
 * Represents the state of a job to create or updated an exported model.
 */
@clientName("ExportedModelJobState", "csharp")
@resource("jobs")
@parentResource(TextAnalysisAuthoringExportedTrainedModel)
model TextAnalysisAuthoringExportedModelJobState {
  ...TextAnalysisAuthoringJobState;
}

/**
 * Represents the properties for the exported model manifest.
 */
@added(Versions.v2023_04_15_preview)
@clientName("ExportedModelManifest", "csharp")
model TextAnalysisAuthoringExportedModelManifest {
  /**
   * The model files belonging to this model.
   */
  modelFiles: TextAnalysisAuthoringModelFile[];
}

/**
 * Represents the properties for the model file.
 */
@clientName("ModelFile", "csharp")
@added(Versions.v2023_04_15_preview)
model TextAnalysisAuthoringModelFile {
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
@clientName("ImportProjectJobState", "csharp")
@resource("import/jobs")
@parentResource(TextAnalysisAuthoringProjectMetadata)
model TextAnalysisAuthoringImportProjectJobState {
  ...TextAnalysisAuthoringJobState;
}

/**
 * Represents a list of retrieved trained models.
 */
@clientName("ProjectTrainedModels", "csharp")
model TextAnalysisAuthoringProjectTrainedModels {
  /**
   * The list of projects.
   */
  value: TextAnalysisAuthoringProjectTrainedModel[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents a trained model.
 */
@clientName("ProjectTrainedModel", "csharp")
@resource("models")
@parentResource(TextAnalysisAuthoringProjectMetadata)
model TextAnalysisAuthoringProjectTrainedModel {
  /**
   * The trained model label.
   */
  @key("trainedModelLabel")
  @visibility
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
@clientName("EvaluationJobState", "csharp")
@resource("evaluate/jobs")
@parentResource(TextAnalysisAuthoringProjectTrainedModel)
model TextAnalysisAuthoringEvaluationJobState {
  ...TextAnalysisAuthoringJobState;

  /**
   * Represents evaluation task detailed result.
   */
  result: TextAnalysisAuthoringEvaluationJobResult;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("EvaluationJobResult", "csharp")
model TextAnalysisAuthoringEvaluationJobResult {
  /**
   * Represents the options used running the evaluation.
   */
  evaluationOptions: TextAnalysisAuthoringEvaluationOptions;

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
@clientName("EvaluationResults", "csharp")
model TextAnalysisAuthoringEvaluationResults {
  /**
   * The list of projects.
   */
  value: TextAnalysisAuthoringDocumentEvaluationResult[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents the evaluation result of a document.
 */
@clientName("DocumentEvaluationResult", "csharp")
@resource("evaluation/result")
@parentResource(TextAnalysisAuthoringProjectTrainedModel)
@discriminator("projectKind")
model TextAnalysisAuthoringDocumentEvaluationResult {
  /**
   * Represents the project kind.
   */
  @key
  @visibility
  projectKind: ProjectKind;

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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model StringIndexTypeQueryParameter {
  /**
   * Specifies the method used to interpret string offsets. For additional
   * information see https://aka.ms/text-analytics-offsets.
   */
  @query("stringIndexType")
  stringIndexType: StringIndexType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ProjectKindQueryParameter {
  /**
   * The project kind, default value is CustomSingleLabelClassification.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @query("projectKind")
  ProjectKind?: ProjectKind;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model SupportedPrebuiltEntitiesQueryParameter {
  /**
   * The project kind, default value is CustomSingleLabelClassification.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @query("projectKind")
  ProjectKind?: ProjectKind;

  /**
   * The language to get supported prebuilt entities for. Required if multilingual
   * is false. This is BCP-47 representation of a language. For example, use "en"
   * for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  @query("language")
  language?: string;

  /**
   * Whether to get the support prebuilt entities for multilingual or monolingual
   * projects. If true, the language parameter is ignored.
   */
  @query("multilingual")
  multilingual?: string;
}

/**
 * Represents the summary for an evaluation operation.
 */
@discriminator("projectKind")
@clientName("EvaluationSummary", "csharp")
model TextAnalysisAuthoringEvaluationSummary {
  /**
   * Represents the project type that the evaluation ran on.
   */
  projectKind: ProjectKind;

  /**
   * Represents the options used running the evaluation.
   */
  evaluationOptions: TextAnalysisAuthoringEvaluationOptions;
}

/**
 * Represents the state of loading a snapshot job.
 */
@clientName("LoadSnapshotJobState", "csharp")
@resource("load-snapshot/jobs")
@parentResource(TextAnalysisAuthoringProjectTrainedModel)
model TextAnalysisAuthoringLoadSnapshotJobState {
  ...TextAnalysisAuthoringJobState;
}

/**
 * Represents the assigned deployment resources.
 */
@added(Versions.v2023_04_15_preview)
@clientName("AssignedDeploymentResources", "csharp")
model TextAnalysisAuthoringAssignedDeploymentResources {
  /**
   * The list of projects.
   */
  value: TextAnalysisAuthoringAssignedDeploymentResource[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents the assigned deployment resource.
 */
@added(Versions.v2023_04_15_preview)
@clientName("AssignedDeploymentResource", "csharp")
@resource("resources")
@parentResource(TextAnalysisAuthoringProjectMetadata)
model TextAnalysisAuthoringAssignedDeploymentResource {
  /**
   * The resource ID.
   */
  @key
  @visibility
  azureResourceId: string;

  /**
   * The resource region.
   */
  region: string;
}

/**
 * Represents the options for assigning Azure resources to a project.
 */
@clientName("AssignDeploymentResourcesOptions")
model TextAnalysisAuthoringAssignDeploymentResourcesOptions {
  /**
   * Represents the metadata for the resources to be assigned.
   */
  resourcesMetadata: TextAnalysisAuthoringResourceMetadata[];
}

/**
 * Represents metadata for the Azure resource..
 */
@clientName("ResourceMetadata")
model TextAnalysisAuthoringResourceMetadata {
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
@clientName("UnassignDeploymentResourcesOptions")
model TextAnalysisAuthoringUnassignDeploymentResourcesOptions {
  /**
   * Represents the assigned resource IDs to be unassigned.
   */
  assignedResourceIds: string[];
}

/**
 * Represents the state of a assign deployment resources job.
 */
@added(Versions.v2023_04_15_preview)
@clientName("AssignDeploymentResourcesJobState", "csharp")
@resource("resources/assign/jobs")
@parentResource(TextAnalysisAuthoringProjectMetadata)
model TextAnalysisAuthoringAssignDeploymentResourcesJobState {
  ...TextAnalysisAuthoringJobState;
}

/**
 * Represents the state of a unassign deployment resources job.
 */
@added(Versions.v2023_04_15_preview)
@clientName("UnassignDeploymentResourcesJobState", "csharp")
@resource("resources/unassign/jobs")
@parentResource(TextAnalysisAuthoringProjectMetadata)
model TextAnalysisAuthoringUnassignDeploymentResourcesJobState {
  ...TextAnalysisAuthoringJobState;
}

/**
 * Represents a list of retrieved training jobs.
 */
@clientName("TrainingJobs", "csharp")
model TextAnalysisAuthoringTrainingJobs {
  /**
   * The list of projects.
   */
  value: TextAnalysisAuthoringTrainingJobState[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents the state of a training job.
 */
@clientName("TrainingJobState", "csharp")
@resource("train/jobs")
@parentResource(TextAnalysisAuthoringProjectMetadata)
model TextAnalysisAuthoringTrainingJobState {
  ...TextAnalysisAuthoringJobState;

  /**
   * Represents training tasks detailed result.
   */
  result: TextAnalysisAuthoringTrainingJobResult;
}

/**
 * Represents the output of a training job.
 */
@clientName("TrainingJobResult", "csharp")
model TextAnalysisAuthoringTrainingJobResult {
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
  trainingStatus: TextAnalysisAuthoringSubTrainingJobState;

  /**
   * Represents model evaluation status.
   */
  evaluationStatus?: TextAnalysisAuthoringSubTrainingJobState;

  /**
   * Represents the estimate end date time for training and evaluation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  estimatedEndDateTime?: utcDateTime;
}

/**
 * Represents the detailed state of a training sub-operation.
 */
@clientName("SubTrainingJobState", "csharp")
model TextAnalysisAuthoringSubTrainingJobState {
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
@resource("authoring/analyze-text/projects/global/deletion-jobs")
@clientName("ProjectDeletionJobState", "csharp")
model TextAnalysisAuthoringProjectDeletionJobState {
  ...TextAnalysisAuthoringJobState;
}

/**
 * Represents the metadata for deployments assigned to a resource.
 */
@added(Versions.v2023_04_15_preview)
@clientName("AssignedResourceDeploymentsMetadata", "csharp")
model TextAnalysisAuthoringAssignedResourceDeploymentsMetadata {
  /**
   * The list of projects.
   */
  value: TextAnalysisAuthoringAssignedProjectDeploymentsMetadata[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents the metadata for assigned deployments for a project.
 */
@resource("authoring/analyze-text/projects/global/deployments/resources")
@clientName("AssignedProjectDeploymentsMetadata", "csharp")
@added(Versions.v2023_04_15_preview)
model TextAnalysisAuthoringAssignedProjectDeploymentsMetadata {
  /**
   * Represents the project name.
   */
  @key
  @visibility
  projectName: string;

  /**
   * Represents the resource region.
   */
  deploymentsMetadata: TextAnalysisAuthoringAssignedProjectDeploymentMetadata[];
}

/**
 * Represents the metadata for an assigned deployment
 */
@clientName("AssignedProjectDeploymentMetadata", "csharp")
model TextAnalysisAuthoringAssignedProjectDeploymentMetadata {
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
@clientName("SupportedLanguages", "csharp")
model TextAnalysisAuthoringSupportedLanguages {
  /**
   * The list of projects.
   */
  value: TextAnalysisAuthoringSupportedLanguage[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents a supported language.
 */
@resource("authoring/analyze-text/projects/global/languages")
@clientName("SupportedLanguage", "csharp")
model TextAnalysisAuthoringSupportedLanguage {
  /**
   * The language name.
   */
  @key
  @visibility
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
@added(Versions.v2023_04_15_preview)
@clientName("PrebuiltEntities", "csharp")
model TextAnalysisAuthoringPrebuiltEntities {
  /**
   * The list of projects.
   */
  value: TextAnalysisAuthoringPrebuiltEntity[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents a supported prebuilt entity.
 */
@added(Versions.v2023_04_15_preview)
@resource("authoring/analyze-text/projects/global/prebuilt-entities")
@clientName("PrebuiltEntity", "csharp")
model TextAnalysisAuthoringPrebuiltEntity {
  /**
   * The prebuilt entity category.
   */
  @key
  @visibility
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
@clientName("TrainingConfigVersions", "csharp")
model TextAnalysisAuthoringTrainingConfigVersions {
  /**
   * The list of projects.
   */
  value: TextAnalysisAuthoringTrainingConfigVersion[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents a training config version.
 */
@resource("authoring/analyze-text/projects/global/training-config-versions")
@clientName("TrainingConfigVersion", "csharp")
model TextAnalysisAuthoringTrainingConfigVersion {
  /**
   * Represents the version of the config.
   */
  @key
  @visibility
  trainingConfigVersion: string;

  /**
   * Represents the training config version expiration date.
   */
  modelExpirationDate: plainDate;
}

/**
 * Represents a cell in a confusion matrix.
 */
@clientName("ConfusionMatrixCell", "csharp")
model TextAnalysisAuthoringConfusionMatrixCell {
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
@clientName("CustomEntityRecognitionDocumentEvaluationResult", "csharp")
model TextAnalysisAuthoringCustomEntityRecognitionDocumentEvaluationResult
  extends TextAnalysisAuthoringDocumentEvaluationResult {
  /**
   * Represents the evaluation prediction for entity recognition.
   */
  customEntityRecognitionResult: TextAnalysisAuthoringDocumentEntityRecognitionEvaluationResult;

  /**
   * Represents the project kind.
   */
  projectKind: "CustomEntityRecognition";
}

/**
 * Represents the entity recognition evaluation result for a document.
 */
@clientName("DocumentEntityRecognitionEvaluationResult", "csharp")
model TextAnalysisAuthoringDocumentEntityRecognitionEvaluationResult {
  /**
   * Represents the document labelled entities.
   */
  entities: TextAnalysisAuthoringDocumentEntityRegionEvaluationResult[];
}

/**
 * Represents the evaluation comparison between the expected and predicted
 * entities of a document region.
 */
@clientName("DocumentEntityRegionEvaluationResult", "csharp")
model TextAnalysisAuthoringDocumentEntityRegionEvaluationResult {
  /**
   * Represents the region's expected entity labels.
   */
  expectedEntities: TextAnalysisAuthoringDocumentEntityLabelEvaluationResult[];

  /**
   * Represents the region's predicted entity labels.
   */
  predictedEntities: TextAnalysisAuthoringDocumentEntityLabelEvaluationResult[];

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
@clientName("DocumentEntityLabelEvaluationResult", "csharp")
model TextAnalysisAuthoringDocumentEntityLabelEvaluationResult {
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
@clientName("CustomEntityRecognitionEvaluationSummary", "csharp")
model TextAnalysisAuthoringCustomEntityRecognitionEvaluationSummary
  extends TextAnalysisAuthoringEvaluationSummary {
  /**
   * Contains the data related to extraction evaluation.
   */
  customEntityRecognitionEvaluation: TextAnalysisAuthoringEntityRecognitionEvaluationSummary;

  /**
   * Represents the project type that the evaluation ran on.
   */
  projectKind: "CustomEntityRecognition";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConfusionMatrix", "csharp")
model TextAnalysisAuthoringConfusionMatrix
  is Record<TextAnalysisAuthoringConfusionMatrixRow>;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConfusionMatrixRow", "csharp")
model TextAnalysisAuthoringConfusionMatrixRow
  is Record<TextAnalysisAuthoringConfusionMatrixCell>;

/**
 * Represents the evaluation summary for a custom entity recognition project.
 */
@clientName("EntityRecognitionEvaluationSummary", "csharp")
model TextAnalysisAuthoringEntityRecognitionEvaluationSummary {
  /**
   * Represents the confusion matrix between two entities (the two entities can be
   * the same). The matrix is between the entity that was labelled and the entity
   * that was predicted.
   */
  confusionMatrix: TextAnalysisAuthoringConfusionMatrix;

  /**
   * Represents the entities evaluation
   */
  entities: Record<TextAnalysisAuthoringEntityEvaluationSummary>;

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
@clientName("EntityEvaluationSummary", "csharp")
model TextAnalysisAuthoringEntityEvaluationSummary {
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
@added(Versions.v2023_04_15_preview)
@clientName("CustomHealthcareDocumentEvaluationResult", "csharp")
model TextAnalysisAuthoringCustomHealthcareDocumentEvaluationResult
  extends TextAnalysisAuthoringDocumentEvaluationResult {
  /**
   * Represents the evaluation prediction for entity recognition.
   */
  customHealthcareResult: TextAnalysisAuthoringDocumentHealthcareEvaluationResult;

  /**
   * Represents the project kind.
   */
  projectKind: "CustomHealthcare";
}

/**
 * Represents the healthcare evaluation result for a document.
 */
@clientName("DocumentHealthcareEvaluationResult", "csharp")
model TextAnalysisAuthoringDocumentHealthcareEvaluationResult {
  /**
   * Represents the document labelled entities.
   */
  entities: TextAnalysisAuthoringDocumentEntityRegionEvaluationResult[];
}

/**
 * Represents the evaluation summary for a custom health care project.
 */
@added(Versions.v2023_04_15_preview)
@clientName("CustomHealthcareEvaluationSummary", "csharp")
model TextAnalysisAuthoringCustomHealthcareEvaluationSummary
  extends TextAnalysisAuthoringEvaluationSummary {
  /**
   * Contains the data related to health care evaluation.
   */
  customHealthcareEvaluation: TextAnalysisAuthoringEntityRecognitionEvaluationSummary;

  /**
   * Represents the project type that the evaluation ran on.
   */
  projectKind: "CustomHealthcare";
}

/**
 * Represents the document evaluation result for a custom multi-label
 * classification project.
 */
@clientName("CustomMultiLabelClassificationDocumentEvaluationResult", "csharp")
model TextAnalysisAuthoringCustomMultiLabelClassificationDocumentEvaluationResult
  extends TextAnalysisAuthoringDocumentEvaluationResult {
  /**
   * Represents the evaluation prediction for multi label classification.
   */
  customMultiLabelClassificationResult: TextAnalysisAuthoringDocumentMultiLabelClassificationEvaluationResult;

  /**
   * Represents the project kind.
   */
  projectKind: "CustomMultiLabelClassification";
}

/**
 * Represents the comparison between the expected and predicted classes that are
 * result from the evaluation operation.
 */
@clientName("DocumentMultiLabelClassificationEvaluationResult", "csharp")
model TextAnalysisAuthoringDocumentMultiLabelClassificationEvaluationResult {
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
@clientName("CustomMultiLabelClassificationEvaluationSummary", "csharp")
model TextAnalysisAuthoringCustomMultiLabelClassificationEvaluationSummary
  extends TextAnalysisAuthoringEvaluationSummary {
  /**
   * Contains the data related to multi label classification evaluation.
   */
  customMultiLabelClassificationEvaluation: TextAnalysisAuthoringMultiLabelClassificationEvaluationSummary;

  /**
   * Represents the project type that the evaluation ran on.
   */
  projectKind: "CustomMultiLabelClassification";
}

/**
 * Represents the evaluation summary for a multi-label classification project.
 */
@clientName("MultiLabelClassificationEvaluationSummary", "csharp")
model TextAnalysisAuthoringMultiLabelClassificationEvaluationSummary {
  /**
   * Represents the classes evaluation
   */
  classes: Record<TextAnalysisAuthoringMultiLabelClassEvaluationSummary>;

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
@clientName("MultiLabelClassEvaluationSummary", "csharp")
model TextAnalysisAuthoringMultiLabelClassEvaluationSummary {
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
@clientName("CustomSingleLabelClassificationDocumentEvaluationResult", "csharp")
model TextAnalysisAuthoringCustomSingleLabelClassificationDocumentEvaluationResult
  extends TextAnalysisAuthoringDocumentEvaluationResult {
  /**
   * Represents the evaluation prediction for single label classification.
   */
  customSingleLabelClassificationResult: TextAnalysisAuthoringDocumentSingleLabelClassificationEvaluationResult;

  /**
   * Represents the project kind.
   */
  projectKind: "CustomSingleLabelClassification";
}

/**
 * Represents the comparison between the expected and predicted class that result
 * from an evaluation operation.
 */
@clientName("DocumentSingleLabelClassificationEvaluationResult", "csharp")
model TextAnalysisAuthoringDocumentSingleLabelClassificationEvaluationResult {
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
@clientName("CustomSingleLabelClassificationEvaluationSummary", "csharp")
model TextAnalysisAuthoringCustomSingleLabelClassificationEvaluationSummary
  extends TextAnalysisAuthoringEvaluationSummary {
  /**
   * Contains the data related to single label classification evaluation.
   */
  customSingleLabelClassificationEvaluation: TextAnalysisAuthoringSingleLabelClassificationEvaluationSummary;

  /**
   * Represents the project type that the evaluation ran on.
   */
  projectKind: "CustomSingleLabelClassification";
}

/**
 * Represents the evaluation summary for a custom single-label classification
 * project.
 */
@clientName("SingleLabelClassificationEvaluationSummary", "csharp")
model TextAnalysisAuthoringSingleLabelClassificationEvaluationSummary {
  /**
   * Represents the confusion matrix between two classes (the two classes can be the
   * same). The matrix is between the class that was labelled and the class that was
   * predicted.
   */
  confusionMatrix: TextAnalysisAuthoringConfusionMatrix;

  /**
   * Represents the classes evaluation
   */
  classes: Record<TextAnalysisAuthoringSingleLabelClassEvaluationSummary>;

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
@clientName("SingleLabelClassEvaluationSummary", "csharp")
model TextAnalysisAuthoringSingleLabelClassEvaluationSummary {
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
@added(Versions.v2023_04_15_preview)
@clientName("CustomTextSentimentDocumentEvaluationResult", "csharp")
model TextAnalysisAuthoringCustomTextSentimentDocumentEvaluationResult
  extends TextAnalysisAuthoringDocumentEvaluationResult {
  /**
   * Represents the evaluation prediction for text sentiment.
   */
  customTextSentimentResult: TextAnalysisAuthoringDocumentTextSentimentEvaluationResult;

  /**
   * Represents the project kind.
   */
  projectKind: "CustomTextSentiment";
}

/**
 * Represents the comparison between the expected and predicted sentiment that
 * result from an evaluation operation.
 */
@clientName("DocumentTextSentimentEvaluationResult", "csharp")
model TextAnalysisAuthoringDocumentTextSentimentEvaluationResult {
  /**
   * Represents the document's expected sentiment labels.
   */
  expectedSentimentSpans: TextAnalysisAuthoringDocumentSentimentLabelEvaluationResult[];

  /**
   * Represents the document's predicted sentiment labels.
   */
  predictedSentimentSpans: TextAnalysisAuthoringDocumentSentimentLabelEvaluationResult[];
}

/**
 * Represents an evaluation result Sentiment label.
 */
@clientName("DocumentSentimentLabelEvaluationResult", "csharp")
model TextAnalysisAuthoringDocumentSentimentLabelEvaluationResult {
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
@added(Versions.v2023_04_15_preview)
@clientName("CustomTextSentimentEvaluationSummary", "csharp")
model TextAnalysisAuthoringCustomTextSentimentEvaluationSummary
  extends TextAnalysisAuthoringEvaluationSummary {
  /**
   * Contains the data related to custom sentiment evaluation.
   */
  customTextSentimentEvaluation: TextAnalysisAuthoringTextSentimentEvaluationSummary;

  /**
   * Represents the project type that the evaluation ran on.
   */
  projectKind: "CustomTextSentiment";
}

/**
 * Represents the evaluation summary for a custom text sentiment project.
 */
@clientName("TextSentimentEvaluationSummary", "csharp")
model TextAnalysisAuthoringTextSentimentEvaluationSummary {
  /**
   * Represents evaluation of span level sentiments
   */
  spanSentimentsEvaluation: TextAnalysisAuthoringSpanSentimentEvaluationSummary;

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
@clientName("SpanSentimentEvaluationSummary", "csharp")
model TextAnalysisAuthoringSpanSentimentEvaluationSummary {
  /**
   * Represents the confusion matrix between two sentiments (the two sentiments can
   * be the same). The matrix is between the sentiment that was labelled and the
   * sentiment that was predicted.
   */
  confusionMatrix: TextAnalysisAuthoringConfusionMatrix;

  /**
   * Represents the sentiment evaluation
   */
  sentiments: Record<TextAnalysisAuthoringSentimentEvaluationSummary>;

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
@clientName("SentimentEvaluationSummary", "csharp")
model TextAnalysisAuthoringSentimentEvaluationSummary {
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
@clientName("ExportedClass", "csharp")
model TextAnalysisAuthoringExportedClass {
  /**
   * The class category.
   */
  category?: string;
}

/**
 * Represents an entity in an exported project with composite entities enabled.
 */
@clientName("ExportedCompositeEntity", "csharp")
model TextAnalysisAuthoringExportedCompositeEntity {
  /**
   * The behavior to follow when the entity's components overlap with each other.
   */
  compositionSetting?: CompositionSetting;

  /**
   * The list component of the entity.
   */
  list?: TextAnalysisAuthoringExportedEntityList;

  /**
   * The prebuilt entities components.
   */
  prebuilts?: TextAnalysisAuthoringExportedPrebuiltEntity[];

  /**
   * The entity category.
   */
  category?: string;
}

/**
 * Represents a list component of an entity.
 */
@clientName("ExportedEntityList", "csharp")
model TextAnalysisAuthoringExportedEntityList {
  /**
   * The sub-lists of the list component.
   */
  sublists?: TextAnalysisAuthoringExportedEntitySublist[];
}

/**
 * Represents a sub-list inside a list component.
 */
@clientName("ExportedEntitySublist", "csharp")
model TextAnalysisAuthoringExportedEntitySublist {
  /**
   * The key of the sub-list.
   */
  listKey?: string;

  /**
   * The phrases of that correspond to the sub-list.
   */
  synonyms?: TextAnalysisAuthoringExportedEntityListSynonym[];
}

/**
 * Represents a list of synonyms inside a list component
 */
@clientName("ExportedEntityListSynonym", "csharp")
model TextAnalysisAuthoringExportedEntityListSynonym {
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
@clientName("ExportedPrebuiltEntity", "csharp")
model TextAnalysisAuthoringExportedPrebuiltEntity {
  /**
   * The prebuilt entity category.
   */
  category: string;
}

/**
 * Represents an exported document for a custom abstractive summarization project.
 */
@clientName("ExportedCustomAbstractiveSummarizationDocument", "csharp")
model TextAnalysisAuthoringExportedCustomAbstractiveSummarizationDocument {
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
@added(Versions.v2023_04_15_preview)
@clientName("ExportedCustomAbstractiveSummarizationProjectAssets", "csharp")
model TextAnalysisAuthoringExportedCustomAbstractiveSummarizationProjectAssets
  extends TextAnalysisAuthoringExportedProjectAssets {
  /**
   * The list of documents belonging to this project.
   */
  documents?: TextAnalysisAuthoringExportedCustomAbstractiveSummarizationDocument[];

  /**
   * The type of the project the assets belong to.
   */
  projectKind: "CustomAbstractiveSummarization";
}

/**
 * Represents an exported document for a custom entity recognition project.
 */
@clientName("ExportedCustomEntityRecognitionDocument", "csharp")
model TextAnalysisAuthoringExportedCustomEntityRecognitionDocument {
  /**
   * The list of entity labels belonging to the document.
   */
  entities?: TextAnalysisAuthoringExportedDocumentEntityRegion[];

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
@clientName("ExportedDocumentEntityRegion", "csharp")
model TextAnalysisAuthoringExportedDocumentEntityRegion {
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
  labels?: TextAnalysisAuthoringExportedDocumentEntityLabel[];
}

/**
 * Represents an entity label for a document.
 */
@clientName("ExportedDocumentEntityLabel", "csharp")
model TextAnalysisAuthoringExportedDocumentEntityLabel {
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
@clientName("ExportedCustomEntityRecognitionProjectAssets", "csharp")
model TextAnalysisAuthoringExportedCustomEntityRecognitionProjectAssets
  extends TextAnalysisAuthoringExportedProjectAssets {
  /**
   * The list of entities belonging to the project.
   */
  entities?: TextAnalysisAuthoringExportedEntity[];

  /**
   * The list of documents belonging to the project.
   */
  documents?: TextAnalysisAuthoringExportedCustomEntityRecognitionDocument[];

  /**
   * The type of the project the assets belong to.
   */
  projectKind: "CustomEntityRecognition";
}

/**
 * Represents an entity in an exported project.
 */
@clientName("ExportedEntity", "csharp")
model TextAnalysisAuthoringExportedEntity {
  /**
   * The entity category.
   */
  category?: string;

  /**
   * Short description for entity category. Required when enabling synthetic data generation.
   */
  @added(Versions.v2024_11_15_preview)
  description?: string;
}

/**
 * Represents an exported document for a CustomHealthcare project.
 */
@clientName("ExportedCustomHealthcareDocument", "csharp")
model TextAnalysisAuthoringExportedCustomHealthcareDocument {
  /**
   * The list of entity labels belonging to the document.
   */
  entities?: TextAnalysisAuthoringExportedDocumentEntityRegion[];

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
@added(Versions.v2023_04_15_preview)
@clientName("ExportedCustomHealthcareProjectAssets", "csharp")
model TextAnalysisAuthoringExportedCustomHealthcareProjectAssets
  extends TextAnalysisAuthoringExportedProjectAssets {
  /**
   * The list of entities belonging to the project.
   */
  entities?: TextAnalysisAuthoringExportedCompositeEntity[];

  /**
   * The list of documents belonging to the project.
   */
  documents?: TextAnalysisAuthoringExportedCustomHealthcareDocument[];

  /**
   * The type of the project the assets belong to.
   */
  projectKind: "CustomHealthcare";
}

/**
 * Represents an exported document of a custom multi-label classification project.
 */
@clientName("ExportedCustomMultiLabelClassificationDocument", "csharp")
model TextAnalysisAuthoringExportedCustomMultiLabelClassificationDocument {
  /**
   * The document classes.
   */
  classes?: TextAnalysisAuthoringExportedDocumentClass[];

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
#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ExportedDocumentClass", "csharp")
model TextAnalysisAuthoringExportedDocumentClass {
  category?: string;
}

/**
 * Represents the exported assets for a custom multi-label classification project.
 */
@clientName("ExportedCustomMultiLabelClassificationProjectAssets", "csharp")
model TextAnalysisAuthoringExportedCustomMultiLabelClassificationProjectAssets
  extends TextAnalysisAuthoringExportedProjectAssets {
  /**
   * The list of classes in the project.
   */
  classes?: TextAnalysisAuthoringExportedClass[];

  /**
   * The list of documents in the project.
   */
  documents?: TextAnalysisAuthoringExportedCustomMultiLabelClassificationDocument[];

  /**
   * The type of the project the assets belong to.
   */
  projectKind: "CustomMultiLabelClassification";
}

/**
 * Represents an exported document for a custom single-label classification
 * project.
 */
@clientName("ExportedCustomSingleLabelClassificationDocument", "csharp")
model TextAnalysisAuthoringExportedCustomSingleLabelClassificationDocument {
  /**
   * The class of the documents.
   */
  class?: TextAnalysisAuthoringExportedDocumentClass;

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
@clientName("ExportedCustomSingleLabelClassificationProjectAssets", "csharp")
model TextAnalysisAuthoringExportedCustomSingleLabelClassificationProjectAssets
  extends TextAnalysisAuthoringExportedProjectAssets {
  /**
   * The list of classes belonging to this project.
   */
  classes?: TextAnalysisAuthoringExportedClass[];

  /**
   * The list of documents belonging to this project.
   */
  documents?: TextAnalysisAuthoringExportedCustomSingleLabelClassificationDocument[];

  /**
   * The type of the project the assets belong to.
   */
  projectKind: "CustomSingleLabelClassification";
}

/**
 * Represents an exported document for a custom text sentiment project.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ExportedCustomTextSentimentDocument", "csharp")
model TextAnalysisAuthoringExportedCustomTextSentimentDocument {
  sentimentSpans?: TextAnalysisAuthoringExportedDocumentSentimentLabel[];

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
@clientName("ExportedDocumentSentimentLabel", "csharp")
model TextAnalysisAuthoringExportedDocumentSentimentLabel {
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
@added(Versions.v2023_04_15_preview)
@clientName("ExportedCustomTextSentimentProjectAssets", "csharp")
model TextAnalysisAuthoringExportedCustomTextSentimentProjectAssets
  extends TextAnalysisAuthoringExportedProjectAssets {
  /**
   * The list of documents belonging to the project.
   */
  documents?: TextAnalysisAuthoringExportedCustomTextSentimentDocument[];

  /**
   * The type of the project the assets belong to.
   */
  projectKind: "CustomTextSentiment";
}
