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

namespace Language.Authoring;


alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias languageOperations = ResourceOperations<ServiceTraits, ErrorResponse>;


interface ConversationalAnalysisAuthoring {

  /**
   * Lists the existing projects.
   */
  listProjects is languageOperations.ResourceList<
    ConversationalAnalysisAuthoringProjectMetadata,
    ListQueryParametersTrait<StandardListQueryParameters & SelectQueryParameter>
  >;

  /**
   * Gets the details of a project.
   */
  getProject is languageOperations.ResourceRead<ConversationalAnalysisAuthoringProjectMetadata>;

  /**
   * Creates a new project or updates an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to rename the body"
  @createsOrUpdatesResource(ConversationalAnalysisAuthoringProjectMetadata)
  @parameterVisibility
  @patch
  createProject is Foundations.ResourceOperation<
    ConversationalAnalysisAuthoringProjectMetadata,
    {
      @doc("This request has a JSON Merge Patch body.")
      @TypeSpec.Http.header("Content-Type")
      contentType: "application/merge-patch+json";

      /** The request body */
      @bodyRoot body: ConversationalAnalysisAuthoringCreateProjectOptions;
    },
    Foundations.ResourceCreatedOrOkResponse<ConversationalAnalysisAuthoringProjectMetadata>,
    {},
    ErrorResponse
  >;

  /**
   * Deletes a project.
   */
  @pollingOperation(ConversationalAnalysisAuthoring.getProjectDeletionStatus)
  deleteProject is languageOperations.LongRunningResourceDelete<ConversationalAnalysisAuthoringProjectMetadata>;

  /**
   * Generates a copy project operation authorization to the current target Azure
   * resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @post
  @added(Versions.v2023_04_15_preview)
  @actionSeparator("/:")
  `authorize-copy` is languageOperations.ResourceAction<ConversationalAnalysisAuthoringProjectMetadata,
  ConversationalAnalysisAuthoringCopyAuthorizationOptions,ConversationalAnalysisAuthoringCopyProjectOptions>;

  /**
   * Copies an existing project to another Azure resource.
   */
  @post
  @pollingOperation(ConversationalAnalysisAuthoring.getCopyProjectStatus)
  @added(Versions.v2023_04_15_preview)
  copy is languageOperations.LongRunningResourceAction<
    ConversationalAnalysisAuthoringProjectMetadata,
    ConversationalAnalysisAuthoringCopyProjectOptions,
   ConversationalAnalysisAuthoringCopyProjectOptions & RequestIdResponseHeader
  >;

  /**
   * Triggers a job to export a project's data.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:export")
  @post
  @pollingOperation(ConversationalAnalysisAuthoring.getExportStatus)
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
      ExportedProjectFormat?: ConversationalAnalysisAuthoringExportedProjectFormat;

      /**
       * Specifies the method used to interpret string offsets. For additional
       * information see https://aka.ms/text-analytics-offsets.
       */
      @query("stringIndexType")
      stringIndexType: ConversationalAnalysisAuthoringStringIndexType;

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
   * Triggers a job to import a project. If a project with the same name already
   * exists, the data of that project is replaced.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:import")
  @post
  @pollingOperation(ConversationalAnalysisAuthoring.getImportStatus)
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
      ExportedProjectFormat?: ConversationalAnalysisAuthoringExportedProjectFormat;

      /**
       * The project data to import.
       */
      @body
      body: ConversationalAnalysisAuthoringExportedProject;
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
  @pollingOperation(ConversationalAnalysisAuthoring.getTrainingStatus)
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
      body: ConversationalAnalysisAuthoringTrainingJobOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing copy project job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/copy/jobs/{jobId}")
  @get
  @added(Versions.v2023_04_15_preview)
  getCopyProjectStatus is Azure.Core.Foundations.Operation<
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
    ConversationalAnalysisAuthoringCopyProjectJobState,
    {},
    ErrorResponse
  >;

  /**
   * Lists the deployments belonging to a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments")
  @get
  listDeployments is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

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
    ConversationalAnalysisAuthoringProjectDeployments,
    {},
    ErrorResponse
  >;

  /**
   * Gets the details of a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}")
  @get
  getDeployment is Azure.Core.Foundations.Operation<
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
    ConversationalAnalysisAuthoringProjectDeployment,
    {},
    ErrorResponse
  >;

  /**
   * Creates a new deployment or replaces an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}")
  @put
  @pollingOperation(ConversationalAnalysisAuthoring.getDeploymentStatus)
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
      body: ConversationalAnalysisAuthoringCreateDeploymentOptions;
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
  @pollingOperation(ConversationalAnalysisAuthoring.getDeploymentStatus)
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
    ConversationalAnalysisAuthoring.getDeploymentDeleteFromResourcesStatus
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
      body: ConversationalAnalysisAuthoringDeleteDeploymentOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing delete deployment from specific resources job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}/delete-from-resources/jobs/{jobId}")
  @get
  @added(Versions.v2023_04_15_preview)
  getDeploymentDeleteFromResourcesStatus is Azure.Core.Foundations.Operation<
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
       * The job ID.
       */
      @path
      jobId: string;
    },
    ConversationalAnalysisAuthoringDeploymentJobState,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing deployment job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}/jobs/{jobId}")
  @get
  getDeploymentStatus is Azure.Core.Foundations.Operation<
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
       * The job ID.
       */
      @path
      jobId: string;
    },
    ConversationalAnalysisAuthoringDeploymentJobState,
    {},
    ErrorResponse
  >;

  /**
   * Swaps two existing deployments with each other.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/:swap")
  @post
  @pollingOperation(ConversationalAnalysisAuthoring.getSwapDeploymentsStatus)
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
      body: ConversationalAnalysisAuthoringSwapDeploymentsOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing swap deployment job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/swap/jobs/{jobId}")
  @get
  getSwapDeploymentsStatus is Azure.Core.Foundations.Operation<
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
    ConversationalAnalysisAuthoringDeploymentJobState,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an export job. Once job completes, returns the project
   * metadata, and assets.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/export/jobs/{jobId}")
  @get
  getExportStatus is Azure.Core.Foundations.Operation<
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
    ConversationalAnalysisAuthoringExportProjectJobState,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status for an import.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/import/jobs/{jobId}")
  @get
  getImportStatus is Azure.Core.Foundations.Operation<
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
    ConversationalAnalysisAuthoringImportProjectJobState,
    {},
    ErrorResponse
  >;

  /**
   * Lists the trained models belonging to a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models")
  @get
  listTrainedModels is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

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
    ConversationalAnalysisAuthoringProjectTrainedModels,
    {},
    ErrorResponse
  >;

  /**
   * Gets the details of a trained model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}")
  @get
  getTrainedModel is Azure.Core.Foundations.Operation<
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
    ConversationalAnalysisAuthoringProjectTrainedModel,
    {},
    ErrorResponse
  >;

  /**
   * Deletes an existing trained model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}")
  @delete
  deleteTrainedModel is Azure.Core.Foundations.Operation<
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
    void,
    {},
    ErrorResponse
  >;

  /**
   * Triggers evaluation operation on a trained model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/:evaluate")
  @post
  @pollingOperation(ConversationalAnalysisAuthoring.getEvaluationStatus)
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
      body: ConversationalAnalysisAuthoringEvaluationOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Restores the snapshot of this trained model to be the current working directory
   * of the project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/:load-snapshot")
  @post
  @pollingOperation(ConversationalAnalysisAuthoring.getLoadSnapshotStatus)
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/evaluate/jobs/{jobId}")
  @get
  @added(Versions.v2023_04_15_preview)
  getEvaluationStatus is Azure.Core.Foundations.Operation<
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
       * The job ID.
       */
      @path
      jobId: string;
    },
    ConversationalAnalysisAuthoringEvaluationJobState,
    {},
    ErrorResponse
  >;

  /**
   * Gets the detailed results of the evaluation for a trained model. This includes
   * the raw inference results for the data included in the evaluation process.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/evaluation/result")
  @get
  getModelEvaluationResults is Azure.Core.Foundations.Operation<
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
       * Specifies the method used to interpret string offsets. For additional
       * information see https://aka.ms/text-analytics-offsets.
       */
      @query("stringIndexType")
      stringIndexType: ConversationalAnalysisAuthoringStringIndexType;

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
    ConversationalAnalysisAuthoringEvaluationResults,
    {},
    ErrorResponse
  >;

  /**
   * Gets the evaluation summary of a trained model. The summary includes high level
   * performance measurements of the model e.g., F1, Precision, Recall, etc.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/evaluation/summary-result")
  @get
  getModelEvaluationSummary is Azure.Core.Foundations.Operation<
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
    ConversationalAnalysisAuthoringEvaluationSummary,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status for loading a snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/load-snapshot/jobs/{jobId}")
  @get
  getLoadSnapshotStatus is Azure.Core.Foundations.Operation<
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
       * The job ID.
       */
      @path
      jobId: string;
    },
    ConversationalAnalysisAuthoringLoadSnapshotJobState,
    {},
    ErrorResponse
  >;

  /**
   * Lists the deployments resources assigned to the project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources")
  @get
  @added(Versions.v2023_04_15_preview)
  listDeploymentResources is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

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
    ConversationalAnalysisAuthoringAssignedDeploymentResources,
    {},
    ErrorResponse
  >;

  /**
   * Assign new Azure resources to a project to allow deploying new deployments to
   * them. This API is available only via AAD authentication and not supported via
   * subscription key authentication. For more details about AAD authentication,
   * check here:
   * https://learn.microsoft.com/en-us/azure/cognitive-services/authentication?tabs=powershell#authenticate-with-azure-active-directory
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/:assign")
  @post
  @pollingOperation(
    ConversationalAnalysisAuthoring.getAssignDeploymentResourcesStatus
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
      body: ConversationalAnalysisAuthoringAssignDeploymentResourcesOptions;
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
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/:unassign")
  @post
  @pollingOperation(
    ConversationalAnalysisAuthoring.getUnassignDeploymentResourcesStatus
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
      body: ConversationalAnalysisAuthoringUnassignDeploymentResourcesOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing assign deployment resources job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/assign/jobs/{jobId}")
  @get
  @added(Versions.v2023_04_15_preview)
  getAssignDeploymentResourcesStatus is Azure.Core.Foundations.Operation<
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
    ConversationalAnalysisAuthoringDeploymentResourcesJobState,
    {},
    ErrorResponse
  >;

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
    ConversationalAnalysisAuthoringDeploymentResourcesJobState,
    {},
    ErrorResponse
  >;

  /**
   * Lists the non-expired training jobs created for a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/train/jobs")
  @get
  listTrainingJobs is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

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
    ConversationalAnalysisAuthoringTrainingJobs,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status for a training job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/train/jobs/{jobId}")
  @get
  getTrainingStatus is Azure.Core.Foundations.Operation<
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
    ConversationalAnalysisAuthoringTrainingJobState,
    {},
    ErrorResponse
  >;

  /**
   * Triggers a cancellation for a running training job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/train/jobs/{jobId}/:cancel")
  @post
  @pollingOperation(ConversationalAnalysisAuthoring.getTrainingStatus)
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
    ConversationalAnalysisAuthoringProjectDeletionJobState,
    {},
    ErrorResponse
  >;

  /**
   * Lists the deployments to which an Azure resource is assigned. This doesn't
   * return deployments belonging to projects owned by this resource. It only
   * returns deployments belonging to projects owned by other resources.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
    ConversationalAnalysisAuthoringAssignedResourceDeploymentsMetadata,
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
      ProjectKind: ConversationalAnalysisAuthoringProjectKind;

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
    ConversationalAnalysisAuthoringSupportedLanguages,
    {},
    ErrorResponse
  >;

  /**
   * Lists the supported prebuilt entities that can be used while creating composed
   * entities.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/global/prebuilt-entities")
  @get
  getSupportedPrebuiltEntities is Azure.Core.Foundations.Operation<
    {
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
    ConversationalAnalysisAuthoringPrebuiltEntities,
    {},
    ErrorResponse
  >;

  /**
   * Lists the support training config version for a given project type.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/global/training-config-versions")
  @get
  listTrainingConfigVersions is Azure.Core.Foundations.Operation<
    {
      /**
       * The project kind.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style"
      @query("projectKind")
      ProjectKind: ConversationalAnalysisAuthoringProjectKind;

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
    ConversationalAnalysisAuthoringTrainingConfigVersions,
    {},
    ErrorResponse
  >;
}
