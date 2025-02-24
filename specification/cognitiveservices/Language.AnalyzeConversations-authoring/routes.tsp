import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models/project.tsp";
import "./models/common.tsp";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.Conversations.Authoring;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias languageOperations = ResourceOperations<
  ServiceTraits,
  Foundations.ErrorResponse
>;

/**
 * Lists the deployments belonging to a project.
 */
op listDeployments is languageOperations.ResourceList<
  AnalyzeConversationAuthoringProjectDeployment,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the existing projects.
 */
op listProjects is languageOperations.ResourceList<
  AnalyzeConversationAuthoringProjectMetadata,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the supported languages for the given project type.
 */
op listSupportedLanguages is languageOperations.ResourceList<
  AnalyzeConversationAuthoringSupportedLanguage,
  ListQueryParametersTrait<StandardListQueryParameters &
    ProjectKindQueryParameter>
>;

/**
 * Lists the deployments to which an Azure resource is assigned. This doesn't return deployments belonging to projects owned by this resource. It only returns deployments belonging to projects owned by other resources.
 */
@added(Versions.v2023_04_15_preview)
op listAssignedResourceDeployments is languageOperations.ResourceList<
  AnalyzeConversationAuthoringAssignedProjectDeploymentsMetadata,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the deployments resources assigned to the project.
 */
@added(Versions.v2023_04_15_preview)
op listDeploymentResources is languageOperations.ResourceList<
  AnalyzeConversationAuthoringAssignedDeploymentResource,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the supported prebuilt entities that can be used while creating composed entities.
 */
op listSupportedPrebuiltEntities is languageOperations.ResourceList<
  AnalyzeConversationAuthoringPrebuiltEntity,
  ListQueryParametersTrait<StandardListQueryParameters &
    SupportedPrebuiltEntitiesQueryParameter>
>;

/**
 * Lists the support training config version for a given project type.
 */
op listTrainingConfigVersions is languageOperations.ResourceList<
  AnalyzeConversationAuthoringTrainingConfigVersion,
  ListQueryParametersTrait<StandardListQueryParameters &
    ProjectKindQueryParameter>
>;

/**
 * Lists the non-expired training jobs created for a project.
 */
op listTrainingJobs is languageOperations.ResourceList<
  AnalyzeConversationAuthoringTrainingJobState,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the trained models belonging to a project.
 */
op listTrainedModels is languageOperations.ResourceList<
  AnalyzeConversationAuthoringProjectTrainedModel,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the exported models belonging to a project.
 */
@added(Versions.v2024_11_15_preview)
op listExportedModels is languageOperations.ResourceList<
  AnalyzeConversationAuthoringExportedTrainedModel,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

interface ConversationAuthoringDeployments {
  /**
   * Swaps two existing deployments with each other.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/:swap")
  @post
  @pollingOperation(ConversationAuthoringDeployments.getSwapDeploymentsStatus)
  swapDeployments is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The job object to swap two deployments.
       */
      @body
      @clientName("details", "csharp")
      body: AnalyzeConversationAuthoringSwapDeploymentsOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the details of a deployment.
   */
  @get
  getDeployment is languageOperations.ResourceRead<AnalyzeConversationAuthoringProjectDeployment>;

  /**
   * Creates a new deployment or replaces an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}")
  @put
  @pollingOperation(ConversationAuthoringDeployments.getDeploymentStatus)
  deployProject is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The name of the specific deployment of the project to use.
       */
      @path
      deploymentName: string;

      /**
       * The new deployment info.
       */
      @body
      @clientName("details", "csharp")
      body: AnalyzeConversationAuthoringCreateDeploymentOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Deletes a project deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}")
  @delete
  @pollingOperation(ConversationAuthoringDeployments.getDeploymentStatus)
  deleteDeployment is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The name of the specific deployment of the project to use.
       */
      @path
      deploymentName: string;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Deletes a project deployment from the specified assigned resources.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}/:delete-from-resources")
  @post
  @pollingOperation(
    ConversationAuthoringDeployments.getDeploymentDeleteFromResourcesStatus
  )
  @added(Versions.v2023_04_15_preview)
  deleteDeploymentFromResources is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The name of the specific deployment of the project to use.
       */
      @path
      deploymentName: string;

      /**
       * The options for deleting the deployment.
       */
      @body
      @clientName("details", "csharp")
      body: AnalyzeConversationAuthoringDeleteDeploymentOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status of an existing delete deployment from specific resources job.
   */
  @added(Versions.v2023_04_15_preview)
  getDeploymentDeleteFromResourcesStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringDeploymentDeleteFromResourcesJobState>;

  /**
   * Gets the status of an existing deployment job.
   */
  getDeploymentStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringDeploymentJobState>;

  /**
   * Gets the status of an existing swap deployment job.
   */
  getSwapDeploymentsStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringSwapDeploymentsJobState>;

  /**
   * Assign new Azure resources to a project to allow deploying new deployments to them. This API is available only via AAD authentication and not supported via subscription key authentication. For more details about AAD authentication, check here: https://learn.microsoft.com/en-us/azure/cognitive-services/authentication?tabs=powershell#authenticate-with-azure-active-directory
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/:assign")
  @post
  @pollingOperation(
    ConversationAuthoringDeployments.getAssignDeploymentResourcesStatus
  )
  @added(Versions.v2023_04_15_preview)
  assignDeploymentResources is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The new project resources info.
       */
      @body
      @clientName("details", "csharp")
      body: AnalyzeConversationAuthoringAssignDeploymentResourcesOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Unassign resources from a project. This disallows deploying new deployments to these resources, and deletes existing deployments assigned to them.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/:unassign")
  @post
  @pollingOperation(
    ConversationAuthoringDeployments.getUnassignDeploymentResourcesStatus
  )
  @added(Versions.v2023_04_15_preview)
  unassignDeploymentResources is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The info for the deployment resources to be deleted.
       */
      @body
      @clientName("details", "csharp")
      body: AnalyzeConversationAuthoringUnassignDeploymentResourcesOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status of an existing assign deployment resources job.
   */
  @added(Versions.v2023_04_15_preview)
  getAssignDeploymentResourcesStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringDeploymentResourcesJobState>;

  /**
   * Gets the status of an existing unassign deployment resources job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/unassign/jobs/{jobId}")
  @get
  @added(Versions.v2023_04_15_preview)
  getUnassignDeploymentResourcesStatus is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The job ID.
       */
      @path
      jobId: string;
    },
    AnalyzeConversationAuthoringDeploymentResourcesJobState,
    {},
    Foundations.ErrorResponse
  >;
}

interface ConversationAuthoringProjects {
  /**
   * Gets the details of a project.
   */
  getProject is languageOperations.ResourceRead<AnalyzeConversationAuthoringProjectMetadata>;

  /**
   * Creates a new project or updates an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to rename the body"
  @createsOrUpdatesResource(AnalyzeConversationAuthoringProjectMetadata)
  @parameterVisibility
  @patch
  createProject is Foundations.ResourceOperation<
    AnalyzeConversationAuthoringProjectMetadata,
    {
      @doc("This request has a JSON Merge Patch body.")
      @TypeSpec.Http.header("Content-Type")
      contentType: "application/merge-patch+json";

      /** The request body */
      @clientName("details", "csharp")
      @bodyRoot
      body: AnalyzeConversationAuthoringCreateProjectOptions;
    },
    Foundations.ResourceCreatedOrOkResponse<AnalyzeConversationAuthoringProjectMetadata>,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Deletes a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}")
  @delete
  @pollingOperation(ConversationAuthoringProjects.getProjectDeletionStatus)
  deleteProject is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;
  /**
   * Gets the status for a project deletion job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/global/deletion-jobs/{jobId}")
  @get
  getProjectDeletionStatus is Azure.Core.Foundations.Operation<
    {
      /**
       * The job ID.
       */
      @path
      jobId: string;
    },
    AnalyzeConversationAuthoringProjectDeletionJobState,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Triggers a job to export a project's data.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:export")
  @post
  @pollingOperation(ConversationAuthoringProjects.getExportStatus)
  export is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The format of the exported project file to use.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style"
      @query("format")
      ExportedProjectFormat?: ExportedProjectFormat;

      /**
       * Specifies the method used to interpret string offsets. For additional information see https://aka.ms/text-analytics-offsets.
       */
      @query("stringIndexType")
      stringIndexType: StringIndexType;

      /**
       * Kind of asset to export.
       */
      @query("assetKind")
      assetKind?: string;

      /**
       * Trained model label to export. If the trainedModelLabel is null, the default behavior is to export the current working copy.
       */
      @query("trainedModelLabel")
      trainedModelLabel?: string;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Triggers a job to import a project. If a project with the same name already exists, the data of that project is replaced.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:import")
  @post
  @pollingOperation(ConversationAuthoringProjects.getImportStatus)
  `import` is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The format of the exported project file to use.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style"
      @query("format")
      ExportedProjectFormat?: ExportedProjectFormat;

      /**
       * The project data to import.
       */
      @body
      @clientName("exportedProject", "csharp")
      body: AnalyzeConversationAuthoringExportedProject;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status of an export job. Once job completes, returns the project metadata, and assets.
   */
  getExportStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringExportProjectJobState>;

  /**
   * Gets the status for an import.
   */
  getImportStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringImportProjectJobState>;

  /**
   * Generates a copy project operation authorization to the current target Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @post
  @added(Versions.v2023_04_15_preview)
  @actionSeparator("/:")
  @action("authorize-copy")
  @clientName("AuthorizeProjectCopy", "csharp")
  copyProjectAuthorization is languageOperations.ResourceAction<
    AnalyzeConversationAuthoringProjectMetadata,
    AnalyzeConversationAuthoringCopyAuthorizationOptions,
    AnalyzeConversationAuthoringCopiedProjectOptions
  >;

  /**
   * Copies an existing project to another Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:copy")
  @post
  @pollingOperation(ConversationAuthoringProjects.getCopyProjectStatus)
  @added(Versions.v2023_04_15_preview)
  copyProject is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The copy project info.
       */
      @body
      @clientName("details", "csharp")
      body: AnalyzeConversationAuthoringCopiedProjectOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status of an existing copy project job.
   */
  @added(Versions.v2023_04_15_preview)
  getCopyProjectStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringCopiedProjectJobState>;

  /**
   * Triggers a training job for a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:train")
  @post
  @pollingOperation(ConversationAuthoringProjects.getTrainingStatus)
  train is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The training input parameters.
       */
      @body
      @clientName("details", "csharp")
      body: AnalyzeConversationAuthoringTrainingJobOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status for a training job.
   */
  getTrainingStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringTrainingJobState>;

  /**
   * Triggers a cancellation for a running training job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/train/jobs/{jobId}/:cancel")
  @post
  @pollingOperation(ConversationAuthoringProjects.getTrainingStatus)
  cancelTrainingJob is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The job ID.
       */
      @path
      jobId: string;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;
}

interface ConversationAuthoringModels {
  /**
   * Gets the details of a trained model.
   */
  getTrainedModel is languageOperations.ResourceRead<AnalyzeConversationAuthoringProjectTrainedModel>;

  /**
   * Deletes an existing trained model.
   */
  deleteTrainedModel is languageOperations.ResourceDelete<AnalyzeConversationAuthoringProjectTrainedModel>;

  /**
   * Triggers evaluation operation on a trained model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/:evaluate")
  @post
  @pollingOperation(ConversationAuthoringModels.getEvaluationStatus)
  @added(Versions.v2023_04_15_preview)
  evaluateModel is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The trained model label.
       */
      @path
      trainedModelLabel: string;

      /**
       * The training input parameters.
       */
      @body
      @clientName("details", "csharp")
      body: AnalyzeConversationAuthoringEvaluationOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Restores the snapshot of this trained model to be the current working directory of the project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/:load-snapshot")
  @post
  @pollingOperation(ConversationAuthoringModels.getLoadSnapshotStatus)
  loadSnapshot is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The trained model label.
       */
      @path
      trainedModelLabel: string;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;
  /**
   * Gets the status for an evaluation job.
   */
  @added(Versions.v2023_04_15_preview)
  getEvaluationStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringEvaluationJobState>;

  /**
   * Gets the detailed results of the evaluation for a trained model. This includes the raw inference results for the data included in the evaluation process.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  getModelEvaluationResults is languageOperations.ResourceList<
    AnalyzeConversationAuthoringUtteranceEvaluationResult,
    ListQueryParametersTrait<StandardListQueryParameters &
      StringIndexTypeQueryParameter>
  >;

  /**
   * Gets the evaluation summary of a trained model. The summary includes high level performance measurements of the model e.g., F1, Precision, Recall, etc.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/evaluation/summary-result")
  @get
  getModelEvaluationSummary is Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The trained model label.
       */
      @path
      trainedModelLabel: string;
    },
    AnalyzeConversationAuthoringEvaluationSummary,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status for loading a snapshot.
   */
  getLoadSnapshotStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringLoadSnapshotJobState>;

  /**
   * Gets the details of an exported model.
   */
  @added(Versions.v2024_11_15_preview)
  getExportedModel is languageOperations.ResourceRead<AnalyzeConversationAuthoringExportedTrainedModel>;

  /**
   * Deletes an existing exported model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/exported-models/{exportedModelName}")
  @delete
  @pollingOperation(ConversationAuthoringModels.getExportedModelJobStatus)
  @added(Versions.v2024_11_15_preview)
  deleteExportedModel is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;

      /**
       * The exported model name.
       */
      @path
      exportedModelName: string;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;
  /**
   * Creates a new exported model or replaces an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/exported-models/{exportedModelName}")
  @put
  @pollingOperation(ConversationAuthoringModels.getExportedModelJobStatus)
  @added(Versions.v2024_11_15_preview)
  createOrUpdateExportedModel is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;

      /**
       * The exported model name.
       */
      @path
      exportedModelName: string;

      /**
       * The exported model info.
       */
      @body
      @clientName("details", "csharp")
      body: ExportedModelOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;
  /**
   * Gets the status for an existing job to create or update an exported model.
   */
  @added(Versions.v2024_11_15_preview)
  getExportedModelJobStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringExportedModelJobState>;
}
