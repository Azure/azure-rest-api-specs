import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace MicrosoftCognitiveLanguageService;

interface TextAnalysisAuthoringOperations {
  /**
   * Lists the existing projects.
   */
  @route("/authoring/analyze-text/projects")
  @get
  listProjects is Azure.Core.Foundations.Operation<
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
    ProjectsMetadata
  >;

  /**
   * Gets the details of a project.
   */
  @route("/authoring/analyze-text/projects/{projectName}")
  @get
  getProject is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;
    },
    ProjectMetadata
  >;

  /**
   * Creates a new project or updates an existing one.
   */
  @route("/authoring/analyze-text/projects/{projectName}")
  @patch
  createProject is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The project parameters.
       */
      @body
      body: CreateProjectOptions;
    },
    ProjectMetadata
  >;

  /**
   * Deletes a project.
   */
  @route("/authoring/analyze-text/projects/{projectName}")
  @delete
  deleteProject is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;
    },
    void
  >;

  /**
   * Generates a copy project operation authorization to the current target Azure
   * resource.
   */
  @route("/authoring/analyze-text/projects/{projectName}/:authorize-copy")
  @post
  copyProjectAuthorization is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The copy project authorization info.
       */
      @body
      body: CopyAuthorizationOptions;
    },
    CopyProjectOptions
  >;

  /**
   * Copies an existing project to another Azure resource.
   */
  @route("/authoring/analyze-text/projects/{projectName}/:copy")
  @post
  copyProject is Azure.Core.Foundations.Operation<
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
      body: CopyProjectOptions;
    },
    void
  >;

  /**
   * Triggers a job to export a project's data.
   */
  @route("/authoring/analyze-text/projects/{projectName}/:export")
  @post
  export is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
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
    void
  >;

  /**
   * Triggers a job to import a project. If a project with the same name already
   * exists, the data of that project is replaced.
   */
  @route("/authoring/analyze-text/projects/{projectName}/:import")
  @post
  `import` is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The format of the project to import. The currently supported formats are json
       * and aml formats. If not provided, the default is set to json.
       */
      @header
      format?: string;

      /**
       * The project data to import.
       */
      @body
      body: ExportedProject;
    },
    void
  >;

  /**
   * Triggers a training job for a project.
   */
  @route("/authoring/analyze-text/projects/{projectName}/:train")
  @post
  train is Azure.Core.Foundations.Operation<
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
      body: TrainingJobOptions;
    },
    void
  >;

  /**
   * Gets the status of an existing copy project job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/copy/jobs/{jobId}")
  @get
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
    CopyProjectJobState
  >;

  /**
   * Lists the deployments belonging to a project.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments")
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
    ProjectDeployments
  >;

  /**
   * Gets the details of a deployment.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}")
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
    ProjectDeployment
  >;

  /**
   * Creates a new deployment or replaces an existing one.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}")
  @put
  deployProject is Azure.Core.Foundations.Operation<
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
      body: CreateDeploymentOptions;
    },
    void
  >;

  /**
   * Deletes a project deployment.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}")
  @delete
  deleteDeployment is Azure.Core.Foundations.Operation<
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
    void
  >;

  /**
   * Deletes a project deployment from the specified assigned resources.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}/:delete-from-resources")
  @post
  deleteDeploymentFromResources is Azure.Core.Foundations.Operation<
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
      body: DeleteDeploymentOptions;
    },
    void
  >;

  /**
   * Gets the status of an existing delete deployment from specific resources job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}/delete-from-resources/jobs/{jobId}")
  @get
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
    DeploymentJobState
  >;

  /**
   * Gets the status of an existing deployment job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}/jobs/{jobId}")
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
    DeploymentJobState
  >;

  /**
   * Swaps two existing deployments with each other.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments/:swap")
  @post
  swapDeployments is Azure.Core.Foundations.Operation<
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
      body: SwapDeploymentsOptions;
    },
    void
  >;

  /**
   * Gets the status of an existing swap deployment job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments/swap/jobs/{jobId}")
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
    DeploymentJobState
  >;

  /**
   * Gets the status of an export job. Once job completes, returns the project
   * metadata, and assets.
   */
  @route("/authoring/analyze-text/projects/{projectName}/export/jobs/{jobId}")
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
    ExportProjectJobState
  >;

  /**
   * Lists the exported models belonging to a project.
   */
  @route("/authoring/analyze-text/projects/{projectName}/exported-models")
  @get
  listExportedModels is Azure.Core.Foundations.Operation<
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
    ExportedTrainedModels
  >;

  /**
   * Gets the details of an exported model.
   */
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}")
  @get
  getExportedModel is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The exported model name.
       */
      @path
      exportedModelName: string;
    },
    ExportedTrainedModel
  >;

  /**
   * Creates a new exported model or replaces an existing one.
   */
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}")
  @put
  createOrUpdateExportedModel is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
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
    void
  >;

  /**
   * Deletes an existing exported model.
   */
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}")
  @delete
  deleteExportedModel is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The exported model name.
       */
      @path
      exportedModelName: string;
    },
    void
  >;

  /**
   * Gets the status for an existing job to create or update an exported model.
   */
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}/jobs/{jobId}")
  @get
  getExportedModelJobStatus is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The exported model name.
       */
      @path
      exportedModelName: string;

      /**
       * The job ID.
       */
      @path
      jobId: string;
    },
    ExportedModelJobState
  >;

  /**
   * Gets the details and URL needed to download the exported model.
   */
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}/manifest")
  @get
  getExportedModelManifest is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The exported model name.
       */
      @path
      exportedModelName: string;
    },
    ExportedModelManifest
  >;

  /**
   * Gets the status for an import.
   */
  @route("/authoring/analyze-text/projects/{projectName}/import/jobs/{jobId}")
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
    ImportProjectJobState
  >;

  /**
   * Lists the trained models belonging to a project.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models")
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
    ProjectTrainedModels
  >;

  /**
   * Gets the details of a trained model.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}")
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
    ProjectTrainedModel
  >;

  /**
   * Deletes an existing trained model.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}")
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
    void
  >;

  /**
   * Triggers evaluation operation on a trained model.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/:evaluate")
  @post
  evaluateModel is Azure.Core.Foundations.Operation<
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
      body: EvaluationOptions;
    },
    void
  >;

  /**
   * Restores the snapshot of this trained model to be the current working directory
   * of the project.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/:load-snapshot")
  @post
  loadSnapshot is Azure.Core.Foundations.Operation<
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
    void
  >;

  /**
   * Gets the status for an evaluation job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/evaluate/jobs/{jobId}")
  @get
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
    EvaluationJobState
  >;

  /**
   * Gets the detailed results of the evaluation for a trained model. This includes
   * the raw inference results for the data included in the evaluation process.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/evaluation/result")
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
      stringIndexType: StringIndexType;

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
    EvaluationResults
  >;

  /**
   * Gets the evaluation summary of a trained model. The summary includes high level
   * performance measurements of the model e.g., F1, Precision, Recall, etc.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/evaluation/summary-result")
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
    EvaluationSummary
  >;

  /**
   * Gets the status for loading a snapshot.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/load-snapshot/jobs/{jobId}")
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
    LoadSnapshotJobState
  >;

  /**
   * Lists the deployments resources assigned to the project.
   */
  @route("/authoring/analyze-text/projects/{projectName}/resources")
  @get
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
    AssignedDeploymentResources
  >;

  /**
   * Assign new Azure resources to a project to allow deploying new deployments to
   * them. This API is available only via AAD authentication and not supported via
   * subscription key authentication. For more details about AAD authentication,
   * check here:
   * https://learn.microsoft.com/en-us/azure/cognitive-services/authentication?tabs=powershell#authenticate-with-azure-active-directory
   */
  @route("/authoring/analyze-text/projects/{projectName}/resources/:assign")
  @post
  assignDeploymentResources is Azure.Core.Foundations.Operation<
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
      body: AssignDeploymentResourcesOptions;
    },
    void
  >;

  /**
   * Unassign resources from a project. This disallows deploying new deployments to
   * these resources, and deletes existing deployments assigned to them.
   */
  @route("/authoring/analyze-text/projects/{projectName}/resources/:unassign")
  @post
  unassignDeploymentResources is Azure.Core.Foundations.Operation<
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
      body: UnassignDeploymentResourcesOptions;
    },
    void
  >;

  /**
   * Gets the status of an existing assign deployment resources job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/resources/assign/jobs/{jobId}")
  @get
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
    DeploymentResourcesJobState
  >;

  /**
   * Gets the status of an existing unassign deployment resources job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/resources/unassign/jobs/{jobId}")
  @get
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
    DeploymentResourcesJobState
  >;

  /**
   * Lists the non-expired training jobs created for a project.
   */
  @route("/authoring/analyze-text/projects/{projectName}/train/jobs")
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
    TrainingJobs
  >;

  /**
   * Gets the status for a training job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/train/jobs/{jobId}")
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
    TrainingJobState
  >;

  /**
   * Triggers a cancellation for a running training job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/train/jobs/{jobId}/:cancel")
  @post
  cancelTrainingJob is Azure.Core.Foundations.Operation<
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
    void
  >;

  /**
   * Gets the status for a project deletion job.
   */
  @route("/authoring/analyze-text/projects/global/deletion-jobs/{jobId}")
  @get
  getProjectDeletionStatus is Azure.Core.Foundations.Operation<
    {
      /**
       * The job ID.
       */
      @path
      jobId: string;
    },
    ProjectDeletionJobState
  >;

  /**
   * Lists the deployments to which an Azure resource is assigned. This doesn't
   * return deployments belonging to projects owned by this resource. It only
   * returns deployments belonging to projects owned by other resources.
   */
  @route("/authoring/analyze-text/projects/global/deployments/resources")
  @get
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
    AssignedResourceDeploymentsMetadata
  >;

  /**
   * Lists the supported languages.
   */
  @route("/authoring/analyze-text/projects/global/languages")
  @get
  getSupportedLanguages is Azure.Core.Foundations.Operation<
    {
      /**
       * The project kind, default value is CustomSingleLabelClassification.
       */
      @query("projectKind")
      ProjectKind?: ProjectKind;

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
    SupportedLanguages
  >;

  /**
   * Lists the supported prebuilt entities that can be used while creating composed
   * entities.
   */
  @route("/authoring/analyze-text/projects/global/prebuilt-entities")
  @get
  getSupportedPrebuiltEntities is Azure.Core.Foundations.Operation<
    {
      /**
       * The project kind, default value is CustomSingleLabelClassification.
       */
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
    PrebuiltEntities
  >;

  /**
   * Lists the support training config version for a given project type.
   */
  @route("/authoring/analyze-text/projects/global/training-config-versions")
  @get
  listTrainingConfigVersions is Azure.Core.Foundations.Operation<
    {
      /**
       * The project kind.
       */
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
    TrainingConfigVersions
  >;
}
