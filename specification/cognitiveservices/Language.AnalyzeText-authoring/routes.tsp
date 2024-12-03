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

namespace Language.Text.Authoring;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias languageOperations = ResourceOperations<ServiceTraits, ErrorResponse>;

interface AnalyzeTextAuthoring {
  /**
   * Lists the existing projects.
   */
  listProjects is languageOperations.ResourceList<
    AnalyzeTextAuthoringProjectMetadata,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Gets the details of a project.
   */
  getProject is languageOperations.ResourceRead<AnalyzeTextAuthoringProjectMetadata>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to rename the body"
  @createsOrUpdatesResource(AnalyzeTextAuthoringProjectMetadata)
  @parameterVisibility
  @patch
  createProject is Foundations.ResourceOperation<
    AnalyzeTextAuthoringProjectMetadata,
    {
      @doc("This request has a JSON Merge Patch body.")
      @TypeSpec.Http.header("Content-Type")
      contentType: "application/merge-patch+json";

      /** The request body */
      @bodyRoot body: AnalyzeTextAuthoringCreateProjectOptions;
    },
    Foundations.ResourceCreatedOrOkResponse<AnalyzeTextAuthoringProjectMetadata>,
    {},
    ErrorResponse
  >;

  /**
   * Deletes a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}")
  @delete
  @pollingOperation(AnalyzeTextAuthoring.getProjectDeletionStatus)
  deleteProject is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Generates a copy project operation authorization to the current target Azure
   * resource.
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_15_preview)
  @actionSeparator("/:")
  @action("authorize-copy")
  copyProjectAuthorization is languageOperations.ResourceAction<
    AnalyzeTextAuthoringProjectMetadata,
    AnalyzeTextAuthoringCopyAuthorizationOptions,
    AnalyzeTextAuthoringCopyProjectOptions
  >;

  /**
   * Copies an existing project to another Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/:copy")
  @post
  @pollingOperation(AnalyzeTextAuthoring.getCopyProjectStatus)
  @added(Versions.v2023_04_15_preview)
  copyProject is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;

      /**
       * The copy project info.
       */
      @body
      body: AnalyzeTextAuthoringCopyProjectOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Triggers a job to export a project's data.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/:export")
  @post
  @pollingOperation(AnalyzeTextAuthoring.getExportStatus)
  export is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;

      /**
       * Specifies the method used to interpret string offsets. For additional
       * information see https://aka.ms/text-analytics-offsets.
       */
      @query("stringIndexType")
      stringIndexType: StringIndexType;

      /**
       * Kind of asset to export.
       */
      @query("assetKind")
      assetKind?: string;

      /**
       * Trained model label to export. If the trainedModelLabel is null, the default
       * behavior is to export the current working copy.
       */
      @query("trainedModelLabel")
      trainedModelLabel?: string;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Triggers a job to import a project. If a project with the same name already
   * exists, the data of that project is replaced.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/:import")
  @post
  @pollingOperation(AnalyzeTextAuthoring.getImportStatus)
  `import` is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;

      /**
       * The format of the project to import. The currently supported formats are json
       * and aml formats. If not provided, the default is set to json.
       */
      @added(Versions.v2023_04_15_preview)
      @header
      format?: string;

      /**
       * The project data to import.
       */
      @body
      body: AnalyzeTextAuthoringExportedProject;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Triggers a training job for a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/:train")
  @post
  @pollingOperation(AnalyzeTextAuthoring.getTrainingStatus)
  train is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;

      /**
       * The training input parameters.
       */
      @body
      body: AnalyzeTextAuthoringTrainingJobOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing copy project job.
   */
  @added(Versions.v2023_04_15_preview)
  getCopyProjectStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringCopyProjectJobState>;

  /**
   * Lists the deployments belonging to a project.
   */
  listDeployments is languageOperations.ResourceList<
    AnalyzeTextAuthoringProjectDeployment,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Gets the details of a deployment.
   */
  getDeployment is languageOperations.ResourceRead<AnalyzeTextAuthoringProjectDeployment>;

  /**
   * Creates a new deployment or replaces an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}")
  @put
  @pollingOperation(AnalyzeTextAuthoring.getDeploymentStatus)
  deployProject is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
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
      body: AnalyzeTextAuthoringCreateDeploymentOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Deletes a project deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}")
  @delete
  @pollingOperation(AnalyzeTextAuthoring.getDeploymentStatus)
  deleteDeployment is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
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
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}/:delete-from-resources")
  @post
  @pollingOperation(
    AnalyzeTextAuthoring.getDeploymentDeleteFromResourcesStatus
  )
  @added(Versions.v2023_04_15_preview)
  deleteDeploymentFromResources is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
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
      body: AnalyzeTextAuthoringDeleteDeploymentOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing delete deployment from specific resources job.
   */
  @added(Versions.v2023_04_15_preview)
  getDeploymentDeleteFromResourcesStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringDeploymentDeleteFromResourcesJobState>;

  /**
   * Gets the status of an existing deployment job.
   */
  getDeploymentStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringDeploymentJobState>;

  /**
   * Swaps two existing deployments with each other.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/deployments/:swap")
  @post
  @pollingOperation(AnalyzeTextAuthoring.getSwapDeploymentsStatus)
  swapDeployments is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;

      /**
       * The job object to swap two deployments.
       */
      @body
      body: AnalyzeTextAuthoringSwapDeploymentsOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing swap deployment job.
   */
  getSwapDeploymentsStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringSwapDeploymentsJobState>;

  /**
   * Gets the status of an export job. Once job completes, returns the project
   * metadata, and assets.
   */
  getExportStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringExportProjectJobState>;

  /**
   * Lists the exported models belonging to a project.
   */
  @added(Versions.v2023_04_15_preview)
  listExportedModels is languageOperations.ResourceList<
    AnalyzeTextAuthoringExportedTrainedModel,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Gets the details of an exported model.
   */
  @added(Versions.v2023_04_15_preview)
  getExportedModel is languageOperations.ResourceRead<AnalyzeTextAuthoringExportedTrainedModel>;

  /**
   * Creates a new exported model or replaces an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}")
  @put
  @pollingOperation(AnalyzeTextAuthoring.getExportedModelJobStatus)
  @added(Versions.v2023_04_15_preview)
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
      body: AnalyzeTextAuthoringExportedModelOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Deletes an existing exported model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}")
  @delete
  @pollingOperation(AnalyzeTextAuthoring.getExportedModelJobStatus)
  @added(Versions.v2023_04_15_preview)
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
   * Gets the status for an existing job to create or update an exported model.
   */
  @added(Versions.v2023_04_15_preview)
  getExportedModelJobStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringExportedModelJobState>;

  /**
   * Gets the details and URL needed to download the exported model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}/manifest")
  @get
  @added(Versions.v2023_04_15_preview)
  getExportedModelManifest is Azure.Core.Foundations.Operation<
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
    AnalyzeTextAuthoringExportedModelManifest,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status for an import.
   */
  getImportStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringImportProjectJobState>;

  /**
   * Lists the trained models belonging to a project.
   */
  listTrainedModels is languageOperations.ResourceList<
    AnalyzeTextAuthoringProjectTrainedModel,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Gets the details of a trained model.
   */
  getTrainedModel is languageOperations.ResourceRead<AnalyzeTextAuthoringProjectTrainedModel>;

  /**
   * Deletes an existing trained model.
   */
  deleteTrainedModel is languageOperations.ResourceDelete<AnalyzeTextAuthoringProjectTrainedModel>;

  /**
   * Triggers evaluation operation on a trained model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/:evaluate")
  @post
  @pollingOperation(AnalyzeTextAuthoring.getEvaluationStatus)
  @added(Versions.v2023_04_15_preview)
  evaluateModel is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
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
      body: AnalyzeTextAuthoringEvaluationOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/:load-snapshot")
  @post
  @pollingOperation(AnalyzeTextAuthoring.getLoadSnapshotStatus)
  loadSnapshot is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
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
  getEvaluationStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringEvaluationJobState>;

  /**
   * Gets the detailed results of the evaluation for a trained model. This includes
   * the raw inference results for the data included in the evaluation process.
   */
  getModelEvaluationResults is languageOperations.ResourceList<
    AnalyzeTextAuthoringDocumentEvaluationResult,
    ListQueryParametersTrait<StandardListQueryParameters &
      StringIndexTypeQueryParameter>
  >;

  /**
   * Gets the evaluation summary of a trained model. The summary includes high level
   * performance measurements of the model e.g., F1, Precision, Recall, etc.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/evaluation/summary-result")
  @get
  getModelEvaluationSummary is Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;

      /**
       * The trained model label.
       */
      @path
      trainedModelLabel: string;
    },
    AnalyzeTextAuthoringEvaluationSummary,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status for loading a snapshot.
   */
  getLoadSnapshotStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringLoadSnapshotJobState>;

  /**
   * Lists the deployments resources assigned to the project.
   */
  @added(Versions.v2023_04_15_preview)
  listDeploymentResources is languageOperations.ResourceList<
    AnalyzeTextAuthoringAssignedDeploymentResource,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Assign new Azure resources to a project to allow deploying new deployments to
   * them. This API is available only via AAD authentication and not supported via
   * subscription key authentication. For more details about AAD authentication,
   * check here:
   * https://learn.microsoft.com/en-us/azure/cognitive-services/authentication?tabs=powershell#authenticate-with-azure-active-directory
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/resources/:assign")
  @post
  @pollingOperation(AnalyzeTextAuthoring.getAssignDeploymentResourcesStatus)
  @added(Versions.v2023_04_15_preview)
  assignDeploymentResources is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;

      /**
       * The new project resources info.
       */
      @body
      body: AnalyzeTextAuthoringAssignDeploymentResourcesOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Unassign resources from a project. This disallows deploying new deployments to
   * these resources, and deletes existing deployments assigned to them.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/resources/:unassign")
  @post
  @pollingOperation(AnalyzeTextAuthoring.getUnassignDeploymentResourcesStatus)
  @added(Versions.v2023_04_15_preview)
  unassignDeploymentResources is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;

      /**
       * The info for the deployment resources to be deleted.
       */
      @body
      body: AnalyzeTextAuthoringUnassignDeploymentResourcesOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing assign deployment resources job.
   */
  @added(Versions.v2023_04_15_preview)
  getAssignDeploymentResourcesStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringAssignDeploymentResourcesJobState>;

  /**
   * Gets the status of an existing unassign deployment resources job.
   */
  @added(Versions.v2023_04_15_preview)
  getUnassignDeploymentResourcesStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringUnassignDeploymentResourcesJobState>;

  /**
   * Lists the non-expired training jobs created for a project.
   */
  listTrainingJobs is languageOperations.ResourceList<
    AnalyzeTextAuthoringTrainingJobState,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Gets the status for a training job.
   */
  getTrainingStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringTrainingJobState>;

  /**
   * Triggers a cancellation for a running training job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/train/jobs/{jobId}/:cancel")
  @post
  @pollingOperation(AnalyzeTextAuthoring.getTrainingStatus)
  cancelTrainingJob is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
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
  getProjectDeletionStatus is languageOperations.ResourceRead<AnalyzeTextAuthoringProjectDeletionJobState>;

  /**
   * Lists the deployments to which an Azure resource is assigned. This doesn't
   * return deployments belonging to projects owned by this resource. It only
   * returns deployments belonging to projects owned by other resources.
   */
  @added(Versions.v2023_04_15_preview)
  listAssignedResourceDeployments is languageOperations.ResourceList<
    AnalyzeTextAuthoringAssignedProjectDeploymentsMetadata,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Lists the supported languages.
   */
  getSupportedLanguages is languageOperations.ResourceList<
    AnalyzeTextAuthoringSupportedLanguage,
    ListQueryParametersTrait<ProjectKindQueryParameter &
      StandardListQueryParameters>
  >;

  /**
   * Lists the supported prebuilt entities that can be used while creating composed
   * entities.
   */
  @added(Versions.v2023_04_15_preview)
  getSupportedPrebuiltEntities is languageOperations.ResourceList<
    AnalyzeTextAuthoringPrebuiltEntity,
    SupportedPrebuiltEntitiesQueryParameter & StandardListQueryParameters
  >;

  /**
   * Lists the support training config version for a given project type.
   */
  listTrainingConfigVersions is languageOperations.ResourceList<
    AnalyzeTextAuthoringTrainingConfigVersion,
    ListQueryParametersTrait<ProjectKindQueryParameter &
      StandardListQueryParameters>
  >;
}
