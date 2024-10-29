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

namespace Language.Authoring.Conversations;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
union ProjectKind {
  string,

  /**
   * A project to build natural language into apps, bots, and IoT devices.
   */
  Conversation: "Conversation",

  /**
   * A project to connect and orchestrate Conversation, Custom question answering and LUIS projects together in one single project.
   */
  Orchestration: "Orchestration",

  /**
   * A project to build conversation summarization models which are able to summarize long conversations.
   */
  @added(Versions.v2023_04_15_preview)
  CustomConversationSummarization: "CustomConversationSummarization",
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("StringIndexType", "csharp")
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("OrchestrationTargetProjectKind", "csharp")
union OrchestrationTargetProjectKind {
  string,
  Luis: "Luis",
  Conversation: "Conversation",
  QuestionAnswering: "QuestionAnswering",
}

/**
 * Represents a list of retrieved projects' metadata.
 */
@clientName("ProjectsMetadata", "csharp")
model ConversationalAnalysisAuthoringProjectsMetadata {
  /**
   * The list of projects.
   */
  value: ConversationalAnalysisAuthoringProjectMetadata[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents the metadata of a project.
 */
@resource("authoring/analyze-conversations/projects")
@clientName("ProjectMetadata", "csharp")
model ConversationalAnalysisAuthoringProjectMetadata {
  /**
   * Represents the project creation datetime.
   */
  createdDateTime: utcDateTime;

  /**
   * Represents the project creation datetime.
   */
  lastModifiedDateTime: utcDateTime;

  /**
   * Represents the project last trained datetime.
   */
  lastTrainedDateTime?: utcDateTime;

  /**
   * Represents the project last deployed datetime.
   */
  lastDeployedDateTime?: utcDateTime;

  /**
   * Represents the project kind.
   */
  @visibility("create", "read")
  projectKind: ProjectKind;

  /**
   * The project settings.
   */
  @visibility("create", "read")
  settings?: ConversationalAnalysisAuthoringProjectSettings;

  /**
   * The storage container name in case of conversation summarization.
   */
  @visibility("create", "read")
  @added(Versions.v2023_04_15_preview)
  storageInputContainerName?: string;

  /**
   * The new project name.
   */
  @key("projectName")
  @visibility("create", "read")
  @maxLength(100)
  projectName: string;

  /**
   * Whether the project would be used for multiple languages or not.
   */
  @visibility("create", "read")
  multilingual?: boolean;

  /**
   * The project description.
   */
  @visibility("create", "read")
  description?: string;

  /**
   * The project language. This is BCP-47 representation of a language. For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish etc.
   */
  @visibility("create", "read")
  language: string;
}

/**
 * Represents the settings used to define the project behavior.
 */
@clientName("ProjectSettings", "csharp")
model ConversationalAnalysisAuthoringProjectSettings {
  /**
   * The threshold of the intent with the highest confidence, at which the prediction will automatically be changed to "None". The value of the threshold should be between 0 and 1 inclusive.
   */
  confidenceThreshold: float32;
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
@clientName("CreateProjectOptions", "csharp")
model ConversationalAnalysisAuthoringCreateProjectOptions {
  /**
   * Represents the project kind.
   */
  projectKind: ProjectKind;

  /**
   * The project settings.
   */
  settings?: ConversationalAnalysisAuthoringProjectSettings;

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
@clientName("CopyAuthorizationOptions", "csharp")
model ConversationalAnalysisAuthoringCopyAuthorizationOptions {
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
 * Represents the options for copying an existing project to another Azure
 * resource.
 */
@added(Versions.v2023_04_15_preview)
@clientName("CopyProjectOptions", "csharp")
model ConversationalAnalysisAuthoringCopyProjectOptions {
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
@clientName("ExportedProject", "csharp")
model ConversationalAnalysisAuthoringExportedProject {
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
  metadata: ConversationalAnalysisAuthoringCreateProjectOptions;

  /**
   * Represents the project assets.
   */
  assets?: ConversationalAnalysisAuthoringExportedProjectAssets;
}

/**
 * Represents the assets of an exported project.
 */
@discriminator("projectKind")
@clientName("ExportedProjectAssets", "csharp")
model ConversationalAnalysisAuthoringExportedProjectAssets {
  /**
   * The type of project containing the assets.
   */
  projectKind: ProjectKind;
}

/**
 * Represents the options for starting a new training job.
 */
@clientName("TrainingJobOptions", "csharp")
model ConversationalAnalysisAuthoringTrainingJobOptions {
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
  evaluationOptions?: ConversationalAnalysisAuthoringEvaluationOptions;
}

/**
 * Represents the options used running the evaluation.
 */
@clientName("EvaluationOptions", "csharp")
model ConversationalAnalysisAuthoringEvaluationOptions {
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
@parentResource(ConversationalAnalysisAuthoringProjectMetadata)
model ConversationalAnalysisAuthoringCopyProjectJobState {
  ...ConversationalAnalysisAuthoringJobState;
}

/**
 * Represents a job's state.
 */
@clientName("JobState", "csharp")
model ConversationalAnalysisAuthoringJobState {
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
@clientName("ProjectDeployments", "csharp")
model ConversationalAnalysisAuthoringProjectDeployments {
  /**
   * The list of retrieved deployments.
   */
  value: ConversationalAnalysisAuthoringProjectDeployment[];

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
@parentResource(ConversationalAnalysisAuthoringProjectMetadata)
model ConversationalAnalysisAuthoringProjectDeployment {
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
  assignedResources: ConversationalAnalysisAuthoringDeploymentResource[];
}

/**
 * Represents an Azure resource assigned to a deployment.
 */
@clientName("DeploymentResource", "csharp")
model ConversationalAnalysisAuthoringDeploymentResource {
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
model ConversationalAnalysisAuthoringCreateDeploymentOptions {
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
@clientName("DeleteDeploymentOptions", "csharp")
model ConversationalAnalysisAuthoringDeleteDeploymentOptions {
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
@parentResource(ConversationalAnalysisAuthoringProjectDeployment)
@resource("jobs")
model ConversationalAnalysisAuthoringDeploymentJobState {
  ...ConversationalAnalysisAuthoringJobState;
}

/**
 * Represents the state of an existing delete deployment from specific resources job.
 */
@clientName("DeploymentDeleteFromResourcesJobState", "csharp")
@parentResource(ConversationalAnalysisAuthoringProjectDeployment)
@resource("delete-from-resources/jobs")
model ConversationalAnalysisAuthoringDeploymentDeleteFromResourcesJobState {
  ...ConversationalAnalysisAuthoringJobState;
}

/**
 * Represents the state of a deployment job.
 */
@clientName("SwapDeploymentsJobState", "csharp")
@parentResource(ConversationalAnalysisAuthoringProjectMetadata)
@resource("deployments/swap/jobs")
model ConversationalAnalysisAuthoringSwapDeploymentsJobState {
  ...ConversationalAnalysisAuthoringJobState;
}

/**
 * Represents the options for swapping two deployments together.
 */
@clientName("SwapDeploymentsOptions", "csharp")
model ConversationalAnalysisAuthoringSwapDeploymentsOptions {
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
@parentResource(ConversationalAnalysisAuthoringProjectMetadata)
model ConversationalAnalysisAuthoringExportProjectJobState {
  ...ConversationalAnalysisAuthoringJobState;

  /**
   * The URL to use in order to download the exported project.
   */
  resultUrl?: string;
}

/**
 * Represents the state of an import job.
 */
@clientName("ImportProjectJobState", "csharp")
@resource("import/jobs")
@parentResource(ConversationalAnalysisAuthoringProjectMetadata)
model ConversationalAnalysisAuthoringImportProjectJobState {
  ...ConversationalAnalysisAuthoringJobState;
}

/**
 * Represents a list of retrieved trained models.
 */
@clientName("ProjectTrainedModels", "csharp")
model ConversationalAnalysisAuthoringProjectTrainedModels {
  /**
   * The list of trained models.
   */
  value: ConversationalAnalysisAuthoringProjectTrainedModel[];

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
@parentResource(ConversationalAnalysisAuthoringProjectMetadata)
model ConversationalAnalysisAuthoringProjectTrainedModel {
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
@parentResource(ConversationalAnalysisAuthoringProjectTrainedModel)
model ConversationalAnalysisAuthoringEvaluationJobState {
  ...ConversationalAnalysisAuthoringJobState;

  /**
   * Represents evaluation task detailed result.
   */
  result: ConversationalAnalysisAuthoringEvaluationJobResult;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("EvaluationJobResult", "csharp")
model ConversationalAnalysisAuthoringEvaluationJobResult {
  /**
   * Represents the options used running the evaluation.
   */
  evaluationOptions: ConversationalAnalysisAuthoringEvaluationOptions;

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
@clientName("EvaluationResults", "csharp")
model ConversationalAnalysisAuthoringEvaluationResults {
  /**
   * The utterances evaluation results.
   */
  value: ConversationalAnalysisAuthoringUtteranceEvaluationResult[];

  /**
   * The next page link.
   */
  nextLink: string;
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

/**
 * Represents the evaluation result for an utterance.
 */
@clientName("UtteranceEvaluationResult", "csharp")
@resource("evaluation/result")
@parentResource(ConversationalAnalysisAuthoringProjectTrainedModel)
model ConversationalAnalysisAuthoringUtteranceEvaluationResult {
  /**
   * Represents the utterance text.
   */
  @key
  @visibility
  text: string;

  /**
   * Represents the utterance language. This is BCP-47 representation of a language.
   * For example, use "en" for English, "en-gb" for English (UK), "es" for Spanish
   * etc.
   */
  language: string;

  /**
   * Represents the entities results for the utterance.
   */
  entitiesResult: ConversationalAnalysisAuthoringUtteranceEntitiesEvaluationResult;

  /**
   * Represents the intents results for the utterance.
   */
  intentsResult: ConversationalAnalysisAuthoringUtteranceIntentsEvaluationResult;
}

/**
 * Represents the comparison between the expected and predicted entities for an
 * utterance.
 */
@clientName("UtteranceEntitiesEvaluationResult", "csharp")
model ConversationalAnalysisAuthoringUtteranceEntitiesEvaluationResult {
  /**
   * Represents the expected entity labels.
   */
  expectedEntities: ConversationalAnalysisAuthoringUtteranceEntityEvaluationResult[];

  /**
   * Represents the predicted entity labels.
   */
  predictedEntities: ConversationalAnalysisAuthoringUtteranceEntityEvaluationResult[];
}

/**
 * Represents the evaluation output of an entity label or prediction.
 */
@clientName("UtteranceEntityEvaluationResult", "csharp")
model ConversationalAnalysisAuthoringUtteranceEntityEvaluationResult {
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
@clientName("UtteranceIntentsEvaluationResult", "csharp")
model ConversationalAnalysisAuthoringUtteranceIntentsEvaluationResult {
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
@clientName("EvaluationSummary", "csharp")
model ConversationalAnalysisAuthoringEvaluationSummary {
  /**
   * Contains the data related to entities evaluation.
   */
  entitiesEvaluation: ConversationalAnalysisAuthoringEntitiesEvaluationSummary;

  /**
   * Contains the data related to intents evaluation.
   */
  intentsEvaluation: ConversationalAnalysisAuthoringIntentsEvaluationSummary;

  /**
   * The options that were used while running the evaluation.
   */
  evaluationOptions?: ConversationalAnalysisAuthoringEvaluationOptions;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConfusionMatrix", "csharp")
model ConversationalAnalysisAuthoringConfusionMatrix
  is Record<ConversationalAnalysisAuthoringConfusionMatrixRow>;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("ConfusionMatrixRow", "csharp")
model ConversationalAnalysisAuthoringConfusionMatrixRow
  is Record<ConversationalAnalysisAuthoringConfusionMatrixCell>;

/**
 * Represents the evaluation result summary for the project's entities.
 */
@clientName("EntitiesEvaluationSummary", "csharp")
model ConversationalAnalysisAuthoringEntitiesEvaluationSummary {
  /**
   * Represents the confusion matrix between two entities (the two entities can be
   * the same). The matrix is between the entity that was labelled and the entity
   * that was predicted.
   */
  confusionMatrix: ConversationalAnalysisAuthoringConfusionMatrix;

  /**
   * Represents the entities evaluation summary.
   */
  entities: Record<ConversationalAnalysisAuthoringEntityEvaluationSummary>;

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
@clientName("ConfusionMatrixCell", "csharp")
model ConversationalAnalysisAuthoringConfusionMatrixCell {
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
@clientName("EntityEvaluationSummary", "csharp")
model ConversationalAnalysisAuthoringEntityEvaluationSummary {
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
@clientName("IntentsEvaluationSummary", "csharp")
model ConversationalAnalysisAuthoringIntentsEvaluationSummary {
  /**
   * Represents the confusion matrix between two intents (the two intents can be the
   * same). The matrix is between the intent that was labelled and the intent that
   * was predicted.
   */
  confusionMatrix: ConversationalAnalysisAuthoringConfusionMatrix;

  /**
   * Represents the intents evaluation summary.
   */
  intents: Record<ConversationalAnalysisAuthoringIntentEvaluationSummary>;

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
@clientName("IntentEvaluationSummary", "csharp")
model ConversationalAnalysisAuthoringIntentEvaluationSummary {
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
@clientName("LoadSnapshotJobState", "csharp")
@resource("load-snapshot/jobs")
@parentResource(ConversationalAnalysisAuthoringProjectTrainedModel)
model ConversationalAnalysisAuthoringLoadSnapshotJobState {
  ...ConversationalAnalysisAuthoringJobState;
}

/**
 * Represents the assigned deployment resources.
 */
@added(Versions.v2023_04_15_preview)
@clientName("AssignedDeploymentResources", "csharp")
model ConversationalAnalysisAuthoringAssignedDeploymentResources {
  /**
   * The list of assigned deployment resources.
   */
  value: ConversationalAnalysisAuthoringAssignedDeploymentResource[];

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
@parentResource(ConversationalAnalysisAuthoringProjectMetadata)
model ConversationalAnalysisAuthoringAssignedDeploymentResource {
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
@added(Versions.v2023_04_15_preview)
@clientName("AssignDeploymentResourcesOptions", "csharp")
model ConversationalAnalysisAuthoringAssignDeploymentResourcesOptions {
  /**
   * Represents the metadata for the resources to be assigned.
   */
  resourcesMetadata: ConversationalAnalysisAuthoringResourceMetadata[];
}

/**
 * Represents metadata for the Azure resource..
 */
@clientName("ResourceMetadata", "csharp")
model ConversationalAnalysisAuthoringResourceMetadata {
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
@clientName("UnassignDeploymentResourcesOptions", "csharp")
model ConversationalAnalysisAuthoringUnassignDeploymentResourcesOptions {
  /**
   * Represents the assigned resource IDs to be unassigned.
   */
  assignedResourceIds: string[];
}

/**
 * Represents the state of a deployment resources job.
 */
@added(Versions.v2023_04_15_preview)
@clientName("DeploymentResourcesJobState", "csharp")
@resource("resources/assign/jobs")
@parentResource(ConversationalAnalysisAuthoringProjectMetadata)
model ConversationalAnalysisAuthoringDeploymentResourcesJobState {
  ...ConversationalAnalysisAuthoringJobState;
}

/**
 * Represents a list of retrieved training jobs.
 */
@clientName("TrainingJobs", "csharp")
model ConversationalAnalysisAuthoringTrainingJobs {
  /**
   * The list of jobs.
   */
  value: ConversationalAnalysisAuthoringTrainingJobState[];

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
@parentResource(ConversationalAnalysisAuthoringProjectMetadata)
model ConversationalAnalysisAuthoringTrainingJobState {
  ...ConversationalAnalysisAuthoringJobState;

  /**
   * Represents training tasks detailed result.
   */
  result: ConversationalAnalysisAuthoringTrainingJobResult;
}

/**
 * Represents the output of a training job.
 */
@clientName("TrainingJobResult", "csharp")
model ConversationalAnalysisAuthoringTrainingJobResult {
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
  trainingStatus: ConversationalAnalysisAuthoringSubTrainingJobState;

  /**
   * Represents model evaluation status.
   */
  evaluationStatus?: ConversationalAnalysisAuthoringSubTrainingJobState;

  /**
   * Represents the estimated end date time for training and evaluation.
   */
  estimatedEndDateTime?: utcDateTime;
}

/**
 * Represents the detailed state of a training sub-operation.
 */
@clientName("SubTrainingJobState", "csharp")
model ConversationalAnalysisAuthoringSubTrainingJobState {
  /**
   * Represents progress percentage.
   */
  percentComplete: int32;

  /**
   * Represents the start date time.
   */
  startDateTime?: utcDateTime;

  /**
   * Represents the end date time.
   */
  endDateTime?: utcDateTime;

  /**
   * Represents the status of the sub-operation.
   */
  status: JobStatus;
}

/**
 * Represents the state of a project deletion job.
 */
@clientName("ProjectDeletionJobState", "csharp")
model ConversationalAnalysisAuthoringProjectDeletionJobState {
  ...ConversationalAnalysisAuthoringJobState;
}

/**
 * Represents the metadata for deployments assigned to a resource.
 */
@added(Versions.v2023_04_15_preview)
@clientName("AssignedResourceDeploymentsMetadata", "csharp")
model ConversationalAnalysisAuthoringAssignedResourceDeploymentsMetadata {
  /**
   * The list of retrieved assigned project deployments.
   */
  value: ConversationalAnalysisAuthoringAssignedProjectDeploymentsMetadata[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents the metadata for assigned deployments for a project.
 */
@added(Versions.v2023_04_15_preview)
@clientName("AssignedProjectDeploymentsMetadata", "csharp")
model ConversationalAnalysisAuthoringAssignedProjectDeploymentsMetadata {
  /**
   * Represents the project name.
   */
  projectName: string;

  /**
   * Represents the resource region.
   */
  deploymentsMetadata: ConversationalAnalysisAuthoringAssignedProjectDeploymentMetadata[];
}

/**
 * Represents the metadata for an assigned deployment
 */
@added(Versions.v2023_04_15_preview)
@clientName("AssignedProjectDeploymentMetadata", "csharp")
model ConversationalAnalysisAuthoringAssignedProjectDeploymentMetadata {
  /**
   * Represents the deployment name.
   */
  deploymentName: string;

  /**
   * Represents deployment last deployed time.
   */
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
model ConversationalAnalysisAuthoringSupportedLanguages {
  /**
   * The list of the languages.
   */
  value: ConversationalAnalysisAuthoringSupportedLanguage[];

  /**
   * The next page link.
   */
  nextLink?: string;
}
/**
 * Represents a supported language.
 */
@clientName("SupportedLanguage", "csharp")
model ConversationalAnalysisAuthoringSupportedLanguage {
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
@clientName("PrebuiltEntities", "csharp")
model ConversationalAnalysisAuthoringPrebuiltEntities {
  /**
   * The supported prebuilt entities.
   */
  value: ConversationalAnalysisAuthoringPrebuiltEntity[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents a supported prebuilt entity.
 */
@clientName("PrebuiltEntity", "csharp")
model ConversationalAnalysisAuthoringPrebuiltEntity {
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
@clientName("TrainingConfigVersions", "csharp")
model ConversationalAnalysisAuthoringTrainingConfigVersions {
  /**
   * The list of the training config versions.
   */
  value: ConversationalAnalysisAuthoringTrainingConfigVersion[];

  /**
   * The next page link.
   */
  nextLink?: string;
}

/**
 * Represents a training config version.
 */
@clientName("TrainingConfigVersion", "csharp")
model ConversationalAnalysisAuthoringTrainingConfigVersion {
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
 * Represents an entity with its components.
 */
@clientName("ConversationExportedEntity", "csharp")
model ConversationalAnalysisAuthoringConversationExportedEntity {
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
  list?: ConversationalAnalysisAuthoringExportedEntityList;

  /**
   * The prebuilt entities components.
   */
  prebuilts?: ConversationalAnalysisAuthoringExportedPrebuiltEntity[];

  /**
   * The regex component of the entity.
   */
  regex?: ConversationalAnalysisAuthoringExportedEntityRegex;

  /**
   * The required components. Allowed values are 'learned', 'list', 'prebuilts' and 'regex'.
   */
  requiredComponents?: string[];
}

/**
 * Represents a list component of an entity.
 */
@clientName("ExportedEntityList", "csharp")
model ConversationalAnalysisAuthoringExportedEntityList {
  /**
   * The sub-lists of the list component.
   */
  sublists?: ConversationalAnalysisAuthoringExportedEntitySublist[];
}

/**
 * Represents a sub-list inside a list component.
 */
@clientName("ExportedEntitySublist", "csharp")
model ConversationalAnalysisAuthoringExportedEntitySublist {
  /**
   * The key of the sub-list.
   */
  listKey?: string;

  /**
   * The phrases of that correspond to the sub-list.
   */
  synonyms?: ConversationalAnalysisAuthoringExportedEntityListSynonym[];
}

/**
 * Represents a list of synonyms inside a list component
 */
@clientName("ExportedEntityListSynonym", "csharp")
model ConversationalAnalysisAuthoringExportedEntityListSynonym {
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
model ConversationalAnalysisAuthoringExportedPrebuiltEntity {
  /**
   * The prebuilt entity category.
   */
  category: string;
}

/**
 * Represents a regex component of an entity.
 */
@clientName("ExportedEntityRegex", "csharp")
model ConversationalAnalysisAuthoringExportedEntityRegex {
  /**
   * The regex expressions of the regex component. These expressions follow the .NET
   * regex syntax. For reference, check here:
   * https://learn.microsoft.com/dotnet/standard/base-types/regular-expressions
   */
  expressions?: ConversationalAnalysisAuthoringExportedEntityRegexExpression[];
}

/**
 * Represents a regex expression inside a regex component. This expression follows
 * the .NET regex syntax. For reference, check here:
 * https://learn.microsoft.com/dotnet/standard/base-types/regular-expressions
 */
@clientName("ExportedEntityRegexExpression", "csharp")
model ConversationalAnalysisAuthoringExportedEntityRegexExpression {
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
@clientName("ConversationExportedIntent", "csharp")
model ConversationalAnalysisAuthoringConversationExportedIntent {
  /**
   * The intent category.
   */
  category: string;
}

/**
 * Represents the exported assets of a conversational project.
 */
@clientName("ConversationExportedProjectAssets", "csharp")
model ConversationalAnalysisAuthoringConversationExportedProjectAssets
  extends ConversationalAnalysisAuthoringExportedProjectAssets {
  /**
   * The intents defined in the project.
   */
  intents?: ConversationalAnalysisAuthoringConversationExportedIntent[];

  /**
   * The entities defined in the project.
   */
  entities?: ConversationalAnalysisAuthoringConversationExportedEntity[];

  /**
   * The utterances defined in the project.
   */
  utterances?: ConversationalAnalysisAuthoringConversationExportedUtterance[];

  /**
   * The type of project containing the assets.
   */
  projectKind: "Conversation";
}

/**
 * Represents an exported utterance for a conversational project.
 */
@clientName("ConversationExportedUtterance", "csharp")
model ConversationalAnalysisAuthoringConversationExportedUtterance {
  /**
   * Represents the entity labels of the utterance.
   */
  entities?: ConversationalAnalysisAuthoringExportedUtteranceEntityLabel[];

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
@clientName("ExportedUtteranceEntityLabel", "csharp")
model ConversationalAnalysisAuthoringExportedUtteranceEntityLabel {
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
@clientName("ConversationSummarizationExportedProjectAssets", "csharp")
model ConversationalAnalysisAuthoringConversationSummarizationExportedProjectAssets {
  /**
   * Represents the conversations of the project.
   */
  conversations?: ConversationalAnalysisAuthoringCustomConversationSummarizationConversation[];
}

/**
 * Represents an exported conversation for a custom conversation summarization.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
@clientName("CustomConversationSummarizationConversation", "csharp")
model ConversationalAnalysisAuthoringCustomConversationSummarizationConversation {
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
@clientName("ExportedConversationOrchestration", "csharp")
model ConversationalAnalysisAuthoringExportedConversationOrchestration {
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
@clientName("ExportedConversationOrchestrationOptions", "csharp")
model ConversationalAnalysisAuthoringExportedConversationOrchestrationOptions
  extends ConversationalAnalysisAuthoringExportedOrchestrationOptions {
  /**
   * The Conversational project target details.
   */
  conversationOrchestration: ConversationalAnalysisAuthoringExportedConversationOrchestration;

  /**
   * The kind of the target used in the orchestration flow.
   */
  targetProjectKind: "Conversation";
}

/**
 * Represents the options used to define the orchestration behavior of an intent.
 */
@discriminator("targetProjectKind")
@clientName("ExportedOrchestrationOptions", "csharp")
model ConversationalAnalysisAuthoringExportedOrchestrationOptions {
  targetProjectKind: OrchestrationTargetProjectKind;
}

/**
 * Defines the orchestration details for a LUIS application target.
 */
@clientName("ExportedLuisOrchestration", "csharp")
model ConversationalAnalysisAuthoringExportedLuisOrchestration {
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
@clientName("ExportedLuisOrchestrationOptions", "csharp")
model ConversationalAnalysisAuthoringExportedLuisOrchestrationOptions
  extends ConversationalAnalysisAuthoringExportedOrchestrationOptions {
  /**
   * The LUIS application target details.
   */
  luisOrchestration: ConversationalAnalysisAuthoringExportedLuisOrchestration;

  /**
   * The kind of the target used in the orchestration flow.
   */
  targetProjectKind: "Luis";
}

/**
 * Defines the orchestration details for a Question Answering project target.
 */
@clientName("ExportedQuestionAnsweringOrchestration", "csharp")
model ConversationalAnalysisAuthoringExportedQuestionAnsweringOrchestration {
  /**
   * The name of the target project.
   */
  projectName: string;
}

/**
 * Represents the orchestration options for a Question Answering project target.
 */
@clientName("ExportedQuestionAnsweringOrchestrationOptions", "csharp")
model ConversationalAnalysisAuthoringExportedQuestionAnsweringOrchestrationOptions
  extends ConversationalAnalysisAuthoringExportedOrchestrationOptions {
  /**
   * The Question Answering project details.
   */
  questionAnsweringOrchestration: ConversationalAnalysisAuthoringExportedQuestionAnsweringOrchestration;

  /**
   * The kind of the target used in the orchestration flow.
   */
  targetProjectKind: "QuestionAnswering";
}

/**
 * Represents an exported intent for an orchestration project.
 */
@clientName("OrchestrationExportedIntent", "csharp")
model ConversationalAnalysisAuthoringOrchestrationExportedIntent {
  /**
   * Specifies the behavior of this intent in the orchestration flow.
   */
  orchestration?: ConversationalAnalysisAuthoringExportedOrchestrationOptions;

  /**
   * The intent category.
   */
  category: string;
}

/**
 * Represents the assets of an orchestration project.
 */
@clientName("OrchestrationExportedProjectAssets", "csharp")
model ConversationalAnalysisAuthoringOrchestrationExportedProjectAssets
  extends ConversationalAnalysisAuthoringExportedProjectAssets {
  /**
   * Represents the intents of the project.
   */
  intents?: ConversationalAnalysisAuthoringOrchestrationExportedIntent[];

  /**
   * Represents the utterances of the project.
   */
  utterances?: ConversationalAnalysisAuthoringOrchestrationExportedUtterance[];

  /**
   * The type of project containing the assets.
   */
  projectKind: "Orchestration";
}

/**
 * Represents an utterance of an orchestration project.
 */
@clientName("OrchestrationExportedUtterance", "csharp")
model ConversationalAnalysisAuthoringOrchestrationExportedUtterance {
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
 * Represents an exported trained model.
 */
@clientName("ExportedTrainedModel", "csharp")
@resource("exported-models")
@parentResource(ConversationalAnalysisAuthoringProjectMetadata)
model ConversationalAnalysisAuthoringExportedTrainedModel {
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
 * Represents the state of a job to create or updated an exported model.
 */
@added(Versions.v2024_11_15_preview)
@clientName("ExportedModelJobState", "csharp")
@resource("jobs")
@parentResource(ConversationalAnalysisAuthoringExportedTrainedModel)
model ConversationalAnalysisAuthoringExportedModelJobState {
  ...ConversationalAnalysisAuthoringJobState;
}
/**
 * Represents the properties for the model file.
 */
@clientName("ModelFile", "csharp")
@added(Versions.v2024_11_15_preview)
model ConversationalAnalysisAuthoringModelFile {
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
@clientName("ExportedModelOptions")
@added(Versions.v2024_11_15_preview)
model ConversationalAnalysisAuthoringExportedModelOptions {
  /**
   * The trained model label.
   */
  trainedModelLabel: string;
}
