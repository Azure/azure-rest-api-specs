import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
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

alias languageOperations = ResourceOperations<ServiceTraits, ErrorResponse>;

interface AnalyzeConversationAuthoring {
  /**
   * Lists the existing projects.
   */
  listProjects is languageOperations.ResourceList<
    AnalyzeConversationAuthoringProjectMetadata,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

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
      @bodyRoot body: AnalyzeConversationAuthoringCreateProjectOptions;
    },
    Foundations.ResourceCreatedOrOkResponse<AnalyzeConversationAuthoringProjectMetadata>,
    {},
    ErrorResponse
  >;

  /**
   * Deletes a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}")
  @delete
  @pollingOperation(AnalyzeConversationAuthoring.getProjectDeletionStatus)
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
    ErrorResponse
  >;

  /**
   * Generates a copy project operation authorization to the current target Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @post
  @added(Versions.v2023_04_15_preview)
  @actionSeparator("/:")
  @action("authorize-copy")
  copyProjectAuthorization is languageOperations.ResourceAction<
    AnalyzeConversationAuthoringProjectMetadata,
    AnalyzeConversationAuthoringCopyAuthorizationOptions,
    AnalyzeConversationAuthoringCopyProjectOptions
  >;

  /**
   * Copies an existing project to another Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:copy")
  @post
  @pollingOperation(AnalyzeConversationAuthoring.getCopyProjectStatus)
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
      body: AnalyzeConversationAuthoringCopyProjectOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Triggers a job to export a project's data.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:export")
  @post
  @pollingOperation(AnalyzeConversationAuthoring.getExportStatus)
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
    ErrorResponse
  >;

  /**
   * Triggers a job to import a project. If a project with the same name already exists, the data of that project is replaced.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:import")
  @post
  @pollingOperation(AnalyzeConversationAuthoring.getImportStatus)
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
      body: AnalyzeConversationAuthoringExportedProject;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Triggers a training job for a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:train")
  @post
  @pollingOperation(AnalyzeConversationAuthoring.getTrainingStatus)
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
      body: AnalyzeConversationAuthoringTrainingJobOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing copy project job.
   */
  @added(Versions.v2023_04_15_preview)
  getCopyProjectStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringCopyProjectJobState>;

  /**
   * Lists the deployments belonging to a project.
   */
  listDeployments is languageOperations.ResourceList<
    AnalyzeConversationAuthoringProjectDeployment,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Swaps two existing deployments with each other.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/:swap")
  @post
  @pollingOperation(AnalyzeConversationAuthoring.getSwapDeploymentsStatus)
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
      body: AnalyzeConversationAuthoringSwapDeploymentsOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
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
  @pollingOperation(AnalyzeConversationAuthoring.getDeploymentStatus)
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
      body: AnalyzeConversationAuthoringCreateDeploymentOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Deletes a project deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}")
  @delete
  @pollingOperation(AnalyzeConversationAuthoring.getDeploymentStatus)
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
    ErrorResponse
  >;

  /**
   * Deletes a project deployment from the specified assigned resources.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}/:delete-from-resources")
  @post
  @pollingOperation(
    AnalyzeConversationAuthoring.getDeploymentDeleteFromResourcesStatus
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
      body: AnalyzeConversationAuthoringDeleteDeploymentOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
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
   * Gets the status of an export job. Once job completes, returns the project metadata, and assets.
   */
  getExportStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringExportProjectJobState>;

  /**
   * Gets the status for an import.
   */
  getImportStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringImportProjectJobState>;

  /**
   * Lists the trained models belonging to a project.
   */
  listTrainedModels is languageOperations.ResourceList<
    AnalyzeConversationAuthoringProjectTrainedModel,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

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
  @pollingOperation(AnalyzeConversationAuthoring.getEvaluationStatus)
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
      body: AnalyzeConversationAuthoringEvaluationOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Restores the snapshot of this trained model to be the current working directory of the project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/:load-snapshot")
  @post
  @pollingOperation(AnalyzeConversationAuthoring.getLoadSnapshotStatus)
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
    ErrorResponse
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
    ErrorResponse
  >;

  /**
   * Gets the status for loading a snapshot.
   */
  getLoadSnapshotStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringLoadSnapshotJobState>;

  /**
   * Lists the deployments resources assigned to the project.
   */
  @added(Versions.v2023_04_15_preview)
  listDeploymentResources is languageOperations.ResourceList<
    AnalyzeConversationAuthoringAssignedDeploymentResource,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Assign new Azure resources to a project to allow deploying new deployments to them. This API is available only via AAD authentication and not supported via subscription key authentication. For more details about AAD authentication, check here: https://learn.microsoft.com/en-us/azure/cognitive-services/authentication?tabs=powershell#authenticate-with-azure-active-directory
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/:assign")
  @post
  @pollingOperation(
    AnalyzeConversationAuthoring.getAssignDeploymentResourcesStatus
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
      body: AnalyzeConversationAuthoringAssignDeploymentResourcesOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Unassign resources from a project. This disallows deploying new deployments to these resources, and deletes existing deployments assigned to them.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/:unassign")
  @post
  @pollingOperation(
    AnalyzeConversationAuthoring.getUnassignDeploymentResourcesStatus
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
      body: AnalyzeConversationAuthoringUnassignDeploymentResourcesOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
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
    ErrorResponse
  >;

  /**
   * Lists the non-expired training jobs created for a project.
   */
  listTrainingJobs is languageOperations.ResourceList<
    AnalyzeConversationAuthoringTrainingJobState,
    ListQueryParametersTrait<StandardListQueryParameters>
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
  @pollingOperation(AnalyzeConversationAuthoring.getTrainingStatus)
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
    ErrorResponse
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
    ErrorResponse
  >;

  /**
   * Lists the deployments to which an Azure resource is assigned. This doesn't return deployments belonging to projects owned by this resource. It only returns deployments belonging to projects owned by other resources.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  @route("/authoring/analyze-conversations/projects/global/deployments/resources")
  @get
  @added(Versions.v2023_04_15_preview)
  listAssignedResourceDeployments is Azure.Core.Foundations.Operation<
    {
      /**
       * The maximum number of resources to return from the collection.
       */
      @query("top")
      top?: int32;

      /**
       * An offset into the collection of the first resource to be returned.
       */
      @query("skip")
      skip?: int32;

      /**
       * The maximum number of resources to include in a single response.
       */
      @query("maxpagesize")
      maxpagesize?: int32;
    },
    AnalyzeConversationAuthoringAssignedResourceDeploymentsMetadata,
    {},
    ErrorResponse
  >;

  /**
   * Lists the supported languages for the given project type.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/global/languages")
  @get
  getSupportedLanguages is Azure.Core.Foundations.Operation<
    {
      /**
       * The project kind.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style"
      @query("projectKind")
      ProjectKind: ProjectKind;

      /**
       * The maximum number of resources to return from the collection.
       */
      @query("top")
      top?: int32;

      /**
       * An offset into the collection of the first resource to be returned.
       */
      @query("skip")
      skip?: int32;

      /**
       * The maximum number of resources to include in a single response.
       */
      @query("maxpagesize")
      maxpagesize?: int32;
    },
    AnalyzeConversationAuthoringSupportedLanguages,
    {},
    ErrorResponse
  >;

  /**
   * Lists the supported prebuilt entities that can be used while creating composed entities.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/global/prebuilt-entities")
  @get
  getSupportedPrebuiltEntities is Azure.Core.Foundations.Operation<
    {
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

      /**
       * The maximum number of resources to return from the collection.
       */
      @query("top")
      top?: int32;

      /**
       * An offset into the collection of the first resource to be returned.
       */
      @query("skip")
      skip?: int32;

      /**
       * The maximum number of resources to include in a single response.
       */
      @query("maxpagesize")
      maxpagesize?: int32;
    },
    AnalyzeConversationAuthoringPrebuiltEntities,
    {},
    ErrorResponse
  >;

  /**
   * Lists the support training config version for a given project type.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  @route("/authoring/analyze-conversations/projects/global/training-config-versions")
  @get
  listTrainingConfigVersions is Azure.Core.Foundations.Operation<
    {
      /**
       * The project kind.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style"
      @query("projectKind")
      ProjectKind: ProjectKind;

      /**
       * The maximum number of resources to return from the collection.
       */
      @query("top")
      top?: int32;

      /**
       * An offset into the collection of the first resource to be returned.
       */
      @query("skip")
      skip?: int32;

      /**
       * The maximum number of resources to include in a single response.
       */
      @query("maxpagesize")
      maxpagesize?: int32;
    },
    AnalyzeConversationAuthoringTrainingConfigVersions,
    {},
    ErrorResponse
  >;

  /**
   * Gets the details of an exported model.
   */
  @added(Versions.v2024_11_15_preview)
  getExportedModel is languageOperations.ResourceRead<AnalyzeConversationAuthoringExportedTrainedModel>;
  /**
   * Lists the exported models belonging to a project.
   */
  @added(Versions.v2024_11_15_preview)
  listExportedModels is languageOperations.ResourceList<
    AnalyzeConversationAuthoringExportedTrainedModel,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
  /**
   * Deletes an existing exported model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/exported-models/{exportedModelName}")
  @delete
  @pollingOperation(AnalyzeConversationAuthoring.getExportedModelJobStatus)
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
    ErrorResponse
  >;
  /**
   * Creates a new exported model or replaces an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/exported-models/{exportedModelName}")
  @put
  @pollingOperation(AnalyzeConversationAuthoring.getExportedModelJobStatus)
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
      body: ExportedModelOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;
  /**
   * Gets the status for an existing job to create or update an exported model.
   */
  @added(Versions.v2024_11_15_preview)
  getExportedModelJobStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringExportedModelJobState>;
}
