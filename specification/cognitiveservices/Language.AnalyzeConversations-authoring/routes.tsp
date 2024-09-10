import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Language.Authoring;

interface ConversationalAnalysisAuthoring {
  /**
   * Lists the existing projects.
   */
  @route("/authoring/analyze-conversations/projects")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}")
  @patch
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}")
  @delete
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/:authorize-copy")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/:copy")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/:export")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  export is Azure.Core.Foundations.Operation<
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
      @query("format")
      #suppress "@azure-tools/typespec-azure-core/casing-style"
      ExportedProjectFormat?: ExportedProjectFormat;

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
  @route("/authoring/analyze-conversations/projects/{projectName}/:import")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  `import` is Azure.Core.Foundations.Operation<
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
      @query("format")
      #suppress "@azure-tools/typespec-azure-core/casing-style"
      ExportedProjectFormat?: ExportedProjectFormat;

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
  @route("/authoring/analyze-conversations/projects/{projectName}/:train")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/copy/jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}")
  @put
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}")
  @delete
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}/:delete-from-resources")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}/delete-from-resources/jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}/jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/:swap")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/swap/jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/export/jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
   * Gets the status for an import.
   */
  @route("/authoring/analyze-conversations/projects/{projectName}/import/jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/models")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}")
  @delete
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/:evaluate")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/:load-snapshot")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/evaluate/jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/evaluation/result")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/evaluation/summary-result")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/load-snapshot/jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/resources")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/:assign")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/:unassign")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/assign/jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/unassign/jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/train/jobs")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/train/jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/{projectName}/train/jobs/{jobId}/:cancel")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/global/deletion-jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
  @route("/authoring/analyze-conversations/projects/global/deployments/resources")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
   * Lists the supported languages for the given project type.
   */
  @route("/authoring/analyze-conversations/projects/global/languages")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getSupportedLanguages is Azure.Core.Foundations.Operation<
    {
      /**
       * The project kind.
       */
      @query("projectKind")
      #suppress "@azure-tools/typespec-azure-core/casing-style"
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
    SupportedLanguages
  >;

  /**
   * Lists the supported prebuilt entities that can be used while creating composed
   * entities.
   */
  @route("/authoring/analyze-conversations/projects/global/prebuilt-entities")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
    PrebuiltEntities
  >;

  /**
   * Lists the support training config version for a given project type.
   */
  @route("/authoring/analyze-conversations/projects/global/training-config-versions")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  listTrainingConfigVersions is Azure.Core.Foundations.Operation<
    {
      /**
       * The project kind.
       */
      @query("projectKind")
      #suppress "@azure-tools/typespec-azure-core/casing-style"
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
