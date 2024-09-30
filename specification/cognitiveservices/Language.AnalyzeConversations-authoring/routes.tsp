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
    ListQueryParametersTrait<StandardListQueryParameters>
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
  @action("authorize-copy")
  copyProjectAuthorization is languageOperations.ResourceAction<ConversationalAnalysisAuthoringProjectMetadata,
  ConversationalAnalysisAuthoringCopyAuthorizationOptions,ConversationalAnalysisAuthoringCopyProjectOptions>;

  /**
   * Copies an existing project to another Azure resource.
   */
  @post
  @pollingOperation(ConversationalAnalysisAuthoring.getCopyProjectStatus)
  @added(Versions.v2023_04_15_preview)
  @actionSeparator("/:")
  copy is languageOperations.LongRunningResourceAction<
    ConversationalAnalysisAuthoringProjectMetadata,
    ConversationalAnalysisAuthoringCopyProjectOptions,
   ConversationalAnalysisAuthoringProjectMetadata
  >;

  /**
   * Triggers a job to export a project's data.
   */
  @post
  @pollingOperation(ConversationalAnalysisAuthoring.getExportStatus)
  export is languageOperations.LongRunningResourceAction<
    ConversationalAnalysisAuthoringProjectMetadata,
    {
      /**
       * The format of the exported project file to use.
       */
      @query
      format?: ConversationalAnalysisAuthoringExportedProjectFormat;

      /**
       * Specifies the method used to interpret string offsets. For additional
       * information see https://aka.ms/text-analytics-offsets.
       */
      @query
      stringIndexType: ConversationalAnalysisAuthoringStringIndexType;

      /**
       * Kind of asset to export.
       */
      @query
      assetKind?: string;

      /**
       * Trained model label to export. If the trainedModelLabel is null, the default behavior is to export the current working copy.
       */
      @query
      trainedModelLabel?: string;
    },
   ConversationalAnalysisAuthoringProjectMetadata
  >;

  /**
   * Triggers a job to import a project. If a project with the same name already
   * exists, the data of that project is replaced.
   */
  @post
  @pollingOperation(ConversationalAnalysisAuthoring.getImportStatus)
  `import` is languageOperations.LongRunningResourceAction<
    ConversationalAnalysisAuthoringProjectMetadata,
    {
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
   ConversationalAnalysisAuthoringProjectMetadata
  >;

  /**
   * Triggers a training job for a project.
   */
  @post
  @pollingOperation(ConversationalAnalysisAuthoring.getTrainingStatus)
  train is languageOperations.LongRunningResourceAction<
    ConversationalAnalysisAuthoringProjectMetadata,
    ConversationalAnalysisAuthoringTrainingJobOptions,
    ConversationalAnalysisAuthoringProjectMetadata
  >;

  /**
   * Gets the status of an existing copy project job.
   */
// ToDo
  @added(Versions.v2023_04_15_preview)
  getCopyProjectStatus is languageOperations.ResourceRead<ConversationalAnalysisAuthoringCopyProjectJobState>;

  /**
   * Lists the deployments belonging to a project.
   */
  listDeployments is languageOperations.ResourceList<
    ConversationalAnalysisAuthoringProjectDeployment,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

   /**
   * Swaps two existing deployments with each other.
   */
  @pollingOperation(ConversationalAnalysisAuthoring.getSwapDeploymentsStatus)
  @actionSeparator("/:")
  @action("swap")
  swapDeployments is languageOperations.LongRunningResourceCollectionAction<
  ConversationalAnalysisAuthoringProjectDeployment,
  ConversationalAnalysisAuthoringSwapDeploymentsOptions,
  ConversationalAnalysisAuthoringProjectDeployment
>;

  /**
   * Gets the details of a deployment.
   */
  @get
  getDeployment is languageOperations.ResourceRead<ConversationalAnalysisAuthoringProjectDeployment>;

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
  @pollingOperation(ConversationalAnalysisAuthoring.getDeploymentStatus)
  deleteDeployment is languageOperations.LongRunningResourceDelete<ConversationalAnalysisAuthoringProjectDeployment>;

  /**
   * Deletes a project deployment from the specified assigned resources.
   */
  @pollingOperation(
    ConversationalAnalysisAuthoring.getDeploymentDeleteFromResourcesStatus
  )
  @action("delete-from-resources")
  @actionSeparator("/:")
  @added(Versions.v2023_04_15_preview)
  deleteDeploymentFromResources is languageOperations.LongRunningResourceAction<
  ConversationalAnalysisAuthoringProjectDeployment,
  ConversationalAnalysisAuthoringDeleteDeploymentOptions,
  ConversationalAnalysisAuthoringProjectDeployment
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
  getDeploymentStatus is languageOperations.ResourceRead<ConversationalAnalysisAuthoringDeploymentJobState>;


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
  listTrainedModels  is languageOperations.ResourceList<
    ConversationalAnalysisAuthoringProjectTrainedModel,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Gets the details of a trained model.
   */
  getTrainedModel is languageOperations.ResourceRead<ConversationalAnalysisAuthoringProjectTrainedModel>;

  /**
   * Deletes an existing trained model.
   */
  deleteTrainedModel is languageOperations.ResourceDelete<ConversationalAnalysisAuthoringProjectTrainedModel>;

  /**
   * Triggers evaluation operation on a trained model.
   */
  @action("evaluate")
  @actionSeparator("/:")
  @pollingOperation(ConversationalAnalysisAuthoring.getEvaluationStatus)
  @added(Versions.v2023_04_15_preview)
  evaluateModel is languageOperations.LongRunningResourceAction<
  ConversationalAnalysisAuthoringProjectTrainedModel,
  ConversationalAnalysisAuthoringEvaluationOptions,
  ConversationalAnalysisAuthoringProjectTrainedModel
>;

  /**
   * Restores the snapshot of this trained model to be the current working directory
   * of the project.
   */
  @action("load-snapshot")
  @actionSeparator("/:")
  @pollingOperation(ConversationalAnalysisAuthoring.getLoadSnapshotStatus)
  loadSnapshot is languageOperations.LongRunningResourceAction<
  ConversationalAnalysisAuthoringProjectTrainedModel,
  {},
  ConversationalAnalysisAuthoringProjectTrainedModel
>;

  /**
   * Gets the status for an evaluation job.
   */
  @added(Versions.v2023_04_15_preview)
  getEvaluationStatus is languageOperations.ResourceRead<ConversationalAnalysisAuthoringEvaluationJobState>;

  /**
   * Gets the detailed results of the evaluation for a trained model. This includes
   * the raw inference results for the data included in the evaluation process.
   */
  getModelEvaluationResults is languageOperations.ResourceList<
    ConversationalAnalysisAuthoringUtteranceEvaluationResult,
    ListQueryParametersTrait<StandardListQueryParameters & StringIndexTypeQueryParameter>
  >;
 

  /**
   * Gets the evaluation summary of a trained model. The summary includes high level
   * performance measurements of the model e.g., F1, Precision, Recall, etc.
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
    ConversationalAnalysisAuthoringEvaluationSummary,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status for loading a snapshot.
   */
  getLoadSnapshotStatus is languageOperations.ResourceRead<ConversationalAnalysisAuthoringLoadSnapshotJobState>;

  /**
   * Lists the deployments resources assigned to the project.
   */
  @added(Versions.v2023_04_15_preview)
  listDeploymentResources is languageOperations.ResourceList<ConversationalAnalysisAuthoringAssignedDeploymentResource,
ListQueryParametersTrait<StandardListQueryParameters>>;

  /**
   * Assign new Azure resources to a project to allow deploying new deployments to
   * them. This API is available only via AAD authentication and not supported via
   * subscription key authentication. For more details about AAD authentication,
   * check here:
   * https://learn.microsoft.com/en-us/azure/cognitive-services/authentication?tabs=powershell#authenticate-with-azure-active-directory
   */
  @action("assign")
  @actionSeparator("/:")
  @pollingOperation(
    ConversationalAnalysisAuthoring.getAssignDeploymentResourcesStatus
  )
  @added(Versions.v2023_04_15_preview)
  assignDeploymentResources is languageOperations.LongRunningResourceCollectionAction<ConversationalAnalysisAuthoringAssignedDeploymentResource,
ConversationalAnalysisAuthoringAssignDeploymentResourcesOptions,
ConversationalAnalysisAuthoringAssignedDeploymentResource
>;

  /**
   * Unassign resources from a project. This disallows deploying new deployments to
   * these resources, and deletes existing deployments assigned to them.
   */
  @pollingOperation(
    ConversationalAnalysisAuthoring.getUnassignDeploymentResourcesStatus
  )
  @added(Versions.v2023_04_15_preview)
  @action("unassign")
  @actionSeparator("/:")
  unassignDeploymentResources is languageOperations.LongRunningResourceCollectionAction<ConversationalAnalysisAuthoringAssignedDeploymentResource,
ConversationalAnalysisAuthoringUnassignDeploymentResourcesOptions,
ConversationalAnalysisAuthoringAssignedDeploymentResource
>;

  /**
   * Gets the status of an existing assign deployment resources job.
   */
  @added(Versions.v2023_04_15_preview)
  getAssignDeploymentResourcesStatus is languageOperations.ResourceRead<ConversationalAnalysisAuthoringDeploymentResourcesJobState>;

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
  listTrainingJobs is languageOperations.ResourceList<ConversationalAnalysisAuthoringTrainingJobState,
ListQueryParametersTrait<StandardListQueryParameters>>;

  /**
   * Gets the status for a training job.
   */
  getTrainingStatus is languageOperations.ResourceRead<ConversationalAnalysisAuthoringTrainingJobState>;

  /**
   * Triggers a cancellation for a running training job.
   */
  @actionSeparator("/:")
  @action("cancel")
  @pollingOperation(ConversationalAnalysisAuthoring.getTrainingStatus)
  cancelTrainingJob is languageOperations.LongRunningResourceAction<
  ConversationalAnalysisAuthoringTrainingJobState,
  {},
  ConversationalAnalysisAuthoringTrainingJobState
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
