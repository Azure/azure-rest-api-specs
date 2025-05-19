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

alias languageOperations = ResourceOperations<
  ServiceTraits,
  Foundations.ErrorResponse
>;

/**
 * Lists the existing projects.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@clientName("listProjects", "csharp")
op textAnalysisAuthoringListProjects is languageOperations.ResourceList<
  TextAnalysisAuthoringProjectMetadata,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the deployments belonging to a project.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@clientName("listDeployments", "csharp")
op textAnalysisAuthoringListDeployments is languageOperations.ResourceList<
  TextAnalysisAuthoringProjectDeployment,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the exported models belonging to a project.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@clientName("listExportedModels", "csharp")
@added(Versions.v2023_04_15_preview)
op textAnalysisAuthoringListExportedModels is languageOperations.ResourceList<
  TextAnalysisAuthoringExportedTrainedModel,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the trained models belonging to a project.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@clientName("listTrainedModels", "csharp")
op textAnalysisAuthoringListTrainedModels is languageOperations.ResourceList<
  TextAnalysisAuthoringProjectTrainedModel,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the deployments resources assigned to the project.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@clientName("listDeploymentResources", "csharp")
@added(Versions.v2023_04_15_preview)
op textAnalysisAuthoringListDeploymentResources is languageOperations.ResourceList<
  TextAnalysisAuthoringAssignedDeploymentResource,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the non-expired training jobs created for a project.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@clientName("listTrainingJobs", "csharp")
op textAnalysisAuthoringListTrainingJobs is languageOperations.ResourceList<
  TextAnalysisAuthoringTrainingJobState,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the deployments to which an Azure resource is assigned. This doesn't return deployments belonging to projects owned by this resource. It only returns deployments belonging to projects owned by other resources.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@clientName("listAssignedResourceDeployments", "csharp")
@added(Versions.v2023_04_15_preview)
op textAnalysisAuthoringListAssignedResourceDeployments is languageOperations.ResourceList<
  TextAnalysisAuthoringAssignedProjectDeploymentsMetadata,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the supported languages.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
@clientName("getSupportedLanguages", "csharp")
op textAnalysisAuthoringGetSupportedLanguages is languageOperations.ResourceList<
  TextAnalysisAuthoringSupportedLanguage,
  ListQueryParametersTrait<ProjectKindQueryParameter &
    StandardListQueryParameters>
>;

/**
 * Lists the supported prebuilt entities that can be used while creating composed entities.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
@clientName("getSupportedPrebuiltEntities", "csharp")
@added(Versions.v2023_04_15_preview)
op textAnalysisAuthoringGetSupportedPrebuiltEntities is languageOperations.ResourceList<
  TextAnalysisAuthoringPrebuiltEntity,
  SupportedPrebuiltEntitiesQueryParameter & StandardListQueryParameters
>;

/**
 * Lists the support training config version for a given project type.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@clientName("listTrainingConfigVersions", "csharp")
op textAnalysisAuthoringListTrainingConfigVersions is languageOperations.ResourceList<
  TextAnalysisAuthoringTrainingConfigVersion,
  ListQueryParametersTrait<ProjectKindQueryParameter &
    StandardListQueryParameters>
>;

interface TextAuthoringProject {
  /**
   * Gets the status for an import.
   */
  getImportStatus is languageOperations.ResourceRead<TextAnalysisAuthoringImportProjectJobState>;

  /**
   * Gets the status of an export job. Once job completes, returns the project metadata, and assets.
   */
  getExportStatus is languageOperations.ResourceRead<TextAnalysisAuthoringExportProjectJobState>;

  /**
   * Gets the details of a project.
   */
  getProject is languageOperations.ResourceRead<TextAnalysisAuthoringProjectMetadata>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to rename the body"
  @createsOrUpdatesResource(TextAnalysisAuthoringProjectMetadata)
  @patch(#{ implicitOptionality: false })
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
    Foundations.ErrorResponse
  >;

  /**
   * Deletes a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}")
  @delete
  @pollingOperation(TextAuthoringProject.getProjectDeletionStatus)
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
    Foundations.ErrorResponse
  >;

  /**
   * Generates a copy project operation authorization to the current target Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_15_preview)
  @actionSeparator("/:")
  @action("authorize-copy")
  @clientName("AuthorizeProjectCopy", "csharp")
  copyProjectAuthorization is languageOperations.ResourceAction<
    TextAnalysisAuthoringProjectMetadata,
    TextAnalysisAuthoringCopyAuthorizationOptions,
    TextAnalysisAuthoringCopyProjectOptions
  >;

  /**
   * Copies an existing project to another Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/:copy")
  @post
  @pollingOperation(TextAuthoringProject.getCopyProjectStatus)
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
      body: TextAnalysisAuthoringCopyProjectOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Triggers a job to export a project's data.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/:export")
  @post
  @pollingOperation(TextAuthoringProject.getExportStatus)
  export is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;

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
  @route("/authoring/analyze-text/projects/{projectName}/:import")
  @post
  @pollingOperation(TextAuthoringProject.getImportStatus)
  `import` is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @path
      projectName: string;

      /**
       * The format of the project to import. The currently supported formats are json and aml formats. If not provided, the default is set to json.
       */
      @added(Versions.v2023_04_15_preview)
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
    Foundations.ErrorResponse
  >;

  /**
   * Triggers a training job for a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/:train")
  @post
  @pollingOperation(TextAuthoringProject.getTrainingStatus)
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
      body: TextAnalysisAuthoringTrainingJobOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status of an existing copy project job.
   */
  @added(Versions.v2023_04_15_preview)
  getCopyProjectStatus is languageOperations.ResourceRead<TextAnalysisAuthoringCopyProjectJobState>;

  /**
   * Gets the status for a training job.
   */
  getTrainingStatus is languageOperations.ResourceRead<TextAnalysisAuthoringTrainingJobState>;

  /**
   * Triggers a cancellation for a running training job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/train/jobs/{jobId}/:cancel")
  @post
  @pollingOperation(TextAuthoringProject.getTrainingStatus)
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
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status for a project deletion job.
   */
  getProjectDeletionStatus is languageOperations.ResourceRead<TextAnalysisAuthoringProjectDeletionJobState>;

  /**
   * Unassign resources from a project. This disallows deploying new deployments to these resources, and deletes existing deployments assigned to them.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/resources/:unassign")
  @post
  @pollingOperation(TextAuthoringProject.getUnassignDeploymentResourcesStatus)
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
      body: TextAnalysisAuthoringUnassignDeploymentResourcesOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status of an existing unassign deployment resources job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/resources/unassign/jobs/{jobId}")
  @get
  @added(Versions.v2023_04_15_preview)
  getUnassignDeploymentResourcesStatus is Azure.Core.Foundations.Operation<
    {
      /**
       * The new project name.
       */
      @path
      projectName: string;

      /**
       * The job ID.
       */
      @path
      jobId: string;
    },
    TextAnalysisAuthoringDeploymentResourcesJobState,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Assign new Azure resources to a project to allow deploying new deployments to them. This API is available only via AAD authentication and not supported via subscription key authentication. For more details about AAD authentication, check here: https://learn.microsoft.com/en-us/azure/cognitive-services/authentication?tabs=powershell#authenticate-with-azure-active-directory
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/resources/:assign")
  @post
  @pollingOperation(TextAuthoringProject.getAssignDeploymentResourcesStatus)
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
      body: TextAnalysisAuthoringAssignDeploymentResourcesOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status of an existing assign deployment resources job.
   */
  @added(Versions.v2023_04_15_preview)
  getAssignDeploymentResourcesStatus is languageOperations.ResourceRead<TextAnalysisAuthoringDeploymentResourcesJobState>;

  /**
   * Swaps two existing deployments with each other.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/deployments/:swap")
  @post
  @pollingOperation(TextAuthoringProject.getSwapDeploymentsStatus)
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
      body: TextAnalysisAuthoringSwapDeploymentsOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status of an existing swap deployment job.
   */
  getSwapDeploymentsStatus is languageOperations.ResourceRead<TextAnalysisAuthoringSwapDeploymentsJobState>;
}

interface TextAuthoringDeployment {
  /**
   * Gets the details of a deployment.
   */
  getDeployment is languageOperations.ResourceRead<TextAnalysisAuthoringProjectDeployment>;

  /**
   * Deletes a project deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}")
  @delete
  @pollingOperation(TextAuthoringDeployment.getDeploymentStatus)
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
    Foundations.ErrorResponse
  >;

  /**
   * Deletes a project deployment from the specified assigned resources.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}/:delete-from-resources")
  @post
  @pollingOperation(
    TextAuthoringDeployment.getDeploymentDeleteFromResourcesStatus
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
      body: TextAnalysisAuthoringDeleteDeploymentOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status of an existing delete deployment from specific resources job.
   */
  @added(Versions.v2023_04_15_preview)
  getDeploymentDeleteFromResourcesStatus is languageOperations.ResourceRead<TextAnalysisAuthoringDeploymentDeleteFromResourcesJobState>;

  /**
   * Gets the status of an existing deployment job.
   */
  getDeploymentStatus is languageOperations.ResourceRead<TextAnalysisAuthoringDeploymentJobState>;

  /**
   * Creates a new deployment or replaces an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/deployments/{deploymentName}")
  @put
  @pollingOperation(TextAuthoringDeployment.getDeploymentStatus)
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
      body: TextAnalysisAuthoringCreateDeploymentOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;
}

interface TextAuthoringExportedModel {
  /**
   * Gets the details of an exported model.
   */
  @added(Versions.v2023_04_15_preview)
  getExportedModel is languageOperations.ResourceRead<TextAnalysisAuthoringExportedTrainedModel>;

  /**
   * Creates a new exported model or replaces an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}")
  @put
  @pollingOperation(TextAuthoringExportedModel.getExportedModelJobStatus)
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
      body: TextAnalysisAuthoringExportedModelOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Deletes an existing exported model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/exported-models/{exportedModelName}")
  @delete
  @pollingOperation(TextAuthoringExportedModel.getExportedModelJobStatus)
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
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status for an existing job to create or update an exported model.
   */
  @added(Versions.v2023_04_15_preview)
  getExportedModelJobStatus is languageOperations.ResourceRead<TextAnalysisAuthoringExportedModelJobState>;

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
    TextAnalysisAuthoringExportedModelManifest,
    {},
    Foundations.ErrorResponse
  >;
}

interface TextAuthoringTrainedModel {
  /**
   * Gets the details of a trained model.
   */
  getTrainedModel is languageOperations.ResourceRead<TextAnalysisAuthoringProjectTrainedModel>;

  /**
   * Deletes an existing trained model.
   */
  deleteTrainedModel is languageOperations.ResourceDelete<TextAnalysisAuthoringProjectTrainedModel>;

  /**
   * Triggers evaluation operation on a trained model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/:evaluate")
  @post
  @pollingOperation(TextAuthoringTrainedModel.getEvaluationStatus)
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
      body: TextAnalysisAuthoringEvaluationOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-text/projects/{projectName}/models/{trainedModelLabel}/:load-snapshot")
  @post
  @pollingOperation(TextAuthoringTrainedModel.getLoadSnapshotStatus)
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
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status for an evaluation job.
   */
  @added(Versions.v2023_04_15_preview)
  getEvaluationStatus is languageOperations.ResourceRead<TextAnalysisAuthoringEvaluationJobState>;

  /**
   * Gets the detailed results of the evaluation for a trained model. This includes the raw inference results for the data included in the evaluation process.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  getModelEvaluationResults is languageOperations.ResourceList<
    TextAnalysisAuthoringDocumentEvaluationResult,
    ListQueryParametersTrait<StandardListQueryParameters &
      StringIndexTypeQueryParameter>
  >;

  /**
   * Gets the evaluation summary of a trained model. The summary includes high level performance measurements of the model e.g., F1, Precision, Recall, etc.
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
    TextAnalysisAuthoringEvaluationSummary,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status for loading a snapshot.
   */
  getLoadSnapshotStatus is languageOperations.ResourceRead<TextAnalysisAuthoringLoadSnapshotJobState>;
}
