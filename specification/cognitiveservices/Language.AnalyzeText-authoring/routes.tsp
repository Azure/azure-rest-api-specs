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

interface TextAnalysisAuthoring {
  /**
   * Lists the existing projects.
   */
  @route("/authoring/analyze-text/projects")
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
    TextAnalysisAuthoringProjectsMetadata
  >;

  /**
   * Gets the details of a project.
   */
  @route("/authoring/analyze-text/projects/{projectName}")
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
    TextAnalysisAuthoringProjectMetadata
  >;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to rename the body"
  //@pollingOperation(Widgets.getWidgetOperationStatus)
  @createsOrUpdatesResource(TextAnalysisAuthoringProjectMetadata)
  @parameterVisibility
  @patch
  createProject is Foundations.ResourceOperation<
    TextAnalysisAuthoringProjectMetadata,
    {
      @doc("This request has a JSON Merge Patch body.")
      @TypeSpec.Http.header("Content-Type")
      contentType: "application/merge-patch+json";

      /** The request body */
      @bodyRoot body: TextAnalysisAuthoringCreateProjectOptions;
    },
    Foundations.ResourceCreatedOrOkResponse<TextAnalysisAuthoringProjectMetadata>,
    {},
    ErrorResponse
  >;

  /**
   * Deletes a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}")
  @delete
  @pollingOperation(TextAnalysisAuthoring.getProjectDeletionStatus)
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
   * Generates a copy project operation authorization to the current target Azure
   * resource.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/:authorize-copy")
  @post
  @added(Versions.v2023_04_15_preview)
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
      body: TextAnalysisAuthoringCopyAuthorizationOptions;
    },
    TextAnalysisAuthoringCopyProjectOptions,
    {},
    ErrorResponse
  >;

/**
   * Copies an existing project to another Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/:copy")
  @post
  @pollingOperation(TextAnalysisAuthoring.getCopyProjectStatus)
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
      body: TextAnalysisAuthoringCopyProjectOptions;
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
  @pollingOperation(TextAnalysisAuthoring.getExportStatus)
  export is Foundations.LongRunningOperation<
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
      stringIndexType: TextAnalysisAuthoringStringIndexType;

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
  @pollingOperation(TextAnalysisAuthoring.getImportStatus)
  `import` is Foundations.LongRunningOperation<
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
      body: TextAnalysisAuthoringExportedProject;
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
  @pollingOperation(TextAnalysisAuthoring.getTrainingStatus)
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
      body: TextAnalysisAuthoringTrainingJobOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing copy project job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/copy/jobs/{jobId}")
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
    TextAnalysisAuthoringCopyProjectJobState
  >;

  /**
   * Lists the deployments belonging to a project.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments")
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
    TextAnalysisAuthoringProjectDeployments
  >;

  /**
   * Gets the details of a deployment.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}")
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
    TextAnalysisAuthoringProjectDeployment
  >;

   /**
   * Creates a new deployment or replaces an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}")
  @put
  @pollingOperation(TextAnalysisAuthoring.getDeploymentStatus)
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
      body: TextAnalysisAuthoringCreateDeploymentOptions;
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
  @pollingOperation(TextAnalysisAuthoring.getDeploymentStatus)
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
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}/:delete-from-resources")
  @post
  @pollingOperation(
    TextAnalysisAuthoring.getDeploymentDeleteFromResourcesStatus
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
      body: TextAnalysisAuthoringDeleteDeploymentOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing delete deployment from specific resources job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}/delete-from-resources/jobs/{jobId}")
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
    TextAnalysisAuthoringDeploymentJobState
  >;

  /**
   * Gets the status of an existing deployment job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}/jobs/{jobId}")
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
    TextAnalysisAuthoringDeploymentJobState
  >;

  /**
   * Swaps two existing deployments with each other.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/deployments/:swap")
  @post
  @pollingOperation(TextAnalysisAuthoring.getSwapDeploymentsStatus)
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
      body: TextAnalysisAuthoringSwapDeploymentsOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing swap deployment job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/deployments/swap/jobs/{jobId}")
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
    TextAnalysisAuthoringDeploymentJobState
  >;

  /**
   * Gets the status of an export job. Once job completes, returns the project
   * metadata, and assets.
   */
  @route("/authoring/analyze-text/projects/{projectName}/export/jobs/{jobId}")
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
    TextAnalysisAuthoringExportProjectJobState
  >;

  /**
   * Lists the exported models belonging to a project.
   */
  @route("/authoring/analyze-text/projects/{projectName}/exported-models")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
    TextAnalysisAuthoringExportedTrainedModels
  >;

  /**
   * Gets the details of an exported model.
   */
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
    TextAnalysisAuthoringExportedTrainedModel
  >;

  /**
   * Creates a new exported model or replaces an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}")
  @put
  @pollingOperation(TextAnalysisAuthoring.getExportedModelJobStatus)
  createOrUpdateExportedModel is Foundations.LongRunningOperation<
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
      body: TextAnalysisAuthoringExportedModelOptions;
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
  @pollingOperation(TextAnalysisAuthoring.getExportedModelJobStatus)
  deleteExportedModel is Foundations.LongRunningOperation<
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
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status for an existing job to create or update an exported model.
   */
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}/jobs/{jobId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
    TextAnalysisAuthoringExportedModelJobState
  >;

  /**
   * Gets the details and URL needed to download the exported model.
   */
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}/manifest")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
    TextAnalysisAuthoringExportedModelManifest
  >;

  /**
   * Gets the status for an import.
   */
  @route("/authoring/analyze-text/projects/{projectName}/import/jobs/{jobId}")
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
    TextAnalysisAuthoringImportProjectJobState
  >;

  /**
   * Lists the trained models belonging to a project.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models")
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
    TextAnalysisAuthoringProjectTrainedModels
  >;

  /**
   * Gets the details of a trained model.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}")
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
    TextAnalysisAuthoringProjectTrainedModel
  >;

  /**
   * Deletes an existing trained model.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}")
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/:evaluate")
  @post
  @pollingOperation(TextAnalysisAuthoring.getEvaluationStatus)
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
      body: TextAnalysisAuthoringEvaluationOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/:load-snapshot")
  @post
  @pollingOperation(TextAnalysisAuthoring.getLoadSnapshotStatus)
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
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/evaluate/jobs/{jobId}")
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
    TextAnalysisAuthoringEvaluationJobState
  >;

  /**
   * Gets the detailed results of the evaluation for a trained model. This includes
   * the raw inference results for the data included in the evaluation process.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/evaluation/result")
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
      stringIndexType: TextAnalysisAuthoringStringIndexType;

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
    TextAnalysisAuthoringEvaluationResults
  >;

  /**
   * Gets the evaluation summary of a trained model. The summary includes high level
   * performance measurements of the model e.g., F1, Precision, Recall, etc.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/evaluation/summary-result")
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
    TextAnalysisAuthoringEvaluationSummary
  >;

  /**
   * Gets the status for loading a snapshot.
   */
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/load-snapshot/jobs/{jobId}")
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
    TextAnalysisAuthoringLoadSnapshotJobState
  >;

  /**
   * Lists the deployments resources assigned to the project.
   */
  @route("/authoring/analyze-text/projects/{projectName}/resources")
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
    TextAnalysisAuthoringAssignedDeploymentResources
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
  @pollingOperation(
    TextAnalysisAuthoring.getAssignDeploymentResourcesStatus
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
      body: TextAnalysisAuthoringAssignDeploymentResourcesOptions;
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
  @pollingOperation(
    TextAnalysisAuthoring.getUnassignDeploymentResourcesStatus
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
      body: TextAnalysisAuthoringUnassignDeploymentResourcesOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an existing assign deployment resources job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/resources/assign/jobs/{jobId}")
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
    TextAnalysisAuthoringDeploymentResourcesJobState
  >;

  /**
   * Gets the status of an existing unassign deployment resources job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/resources/unassign/jobs/{jobId}")
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
    TextAnalysisAuthoringDeploymentResourcesJobState
  >;

  /**
   * Lists the non-expired training jobs created for a project.
   */
  @route("/authoring/analyze-text/projects/{projectName}/train/jobs")
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
    TextAnalysisAuthoringTrainingJobs
  >;

  /**
   * Gets the status for a training job.
   */
  @route("/authoring/analyze-text/projects/{projectName}/train/jobs/{jobId}")
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
    TextAnalysisAuthoringTrainingJobState
  >;

  /**
   * Triggers a cancellation for a running training job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/train/jobs/{jobId}/:cancel")
  @post
  @pollingOperation(TextAnalysisAuthoring.getTrainingStatus)
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
  @route("/authoring/analyze-text/projects/global/deletion-jobs/{jobId}")
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
    TextAnalysisAuthoringProjectDeletionJobState
  >;

  /**
   * Lists the deployments to which an Azure resource is assigned. This doesn't
   * return deployments belonging to projects owned by this resource. It only
   * returns deployments belonging to projects owned by other resources.
   */
  @route("/authoring/analyze-text/projects/global/deployments/resources")
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
    TextAnalysisAuthoringAssignedResourceDeploymentsMetadata
  >;

  /**
   * Lists the supported languages.
   */
  @route("/authoring/analyze-text/projects/global/languages")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getSupportedLanguages is Azure.Core.Foundations.Operation<
    {
      /**
       * The project kind, default value is CustomSingleLabelClassification.
       */
      @query("projectKind")
      #suppress "@azure-tools/typespec-azure-core/casing-style"
      ProjectKind?: TextAnalysisAuthoringProjectKind;

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
    TextAnalysisAuthoringSupportedLanguages
  >;

  /**
   * Lists the supported prebuilt entities that can be used while creating composed
   * entities.
   */
  @route("/authoring/analyze-text/projects/global/prebuilt-entities")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getSupportedPrebuiltEntities is Azure.Core.Foundations.Operation<
    {
      /**
       * The project kind, default value is CustomSingleLabelClassification.
       */
      @query("projectKind")
      #suppress "@azure-tools/typespec-azure-core/casing-style"
      ProjectKind?: TextAnalysisAuthoringProjectKind;

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
    TextAnalysisAuthoringPrebuiltEntities
  >;

  /**
   * Lists the support training config version for a given project type.
   */
  @route("/authoring/analyze-text/projects/global/training-config-versions")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  listTrainingConfigVersions is Azure.Core.Foundations.Operation<
    {
      /**
       * The project kind.
       */
      @query("projectKind")
      #suppress "@azure-tools/typespec-azure-core/casing-style"
      ProjectKind: TextAnalysisAuthoringProjectKind;

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
    TextAnalysisAuthoringTrainingConfigVersions
  >;
}
