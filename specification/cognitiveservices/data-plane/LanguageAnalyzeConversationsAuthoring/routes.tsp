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
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
op conversationAuthoringListDeployments is languageOperations.ResourceList<
  AnalyzeConversationAuthoringProjectDeployment,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the existing projects.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
op conversationAuthoringListProjects is languageOperations.ResourceList<
  AnalyzeConversationAuthoringProjectMetadata,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the supported languages for the given project type.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
op conversationAuthoringListSupportedLanguages is languageOperations.ResourceList<
  AnalyzeConversationAuthoringSupportedLanguage,
  ListQueryParametersTrait<StandardListQueryParameters &
    ProjectKindQueryParameter>
>;

/**
 * Lists the deployments to which an Azure resource is assigned. This doesn't return deployments belonging to projects owned by this resource. It only returns deployments belonging to projects owned by other resources.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@added(Versions.v2025_11_01)
op conversationAuthoringListAssignedResourceDeployments is languageOperations.ResourceList<
  AnalyzeConversationAuthoringAssignedProjectDeploymentsMetadata,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the Language or AIService resources assigned to the project.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@added(Versions.v2025_11_01)
@renamedFrom(
  Versions.v2025_05_15_preview,
  "conversationAuthoringListProjectResources"
)
@renamedFrom(
  Versions.v2025_11_15_preview,
  "ConversationAuthoringListDeploymentResources"
)
op conversationAuthoringListProjectResources is languageOperations.ResourceList<
  AnalyzeConversationAuthoringProjectResourceInfo,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the supported prebuilt entities that can be used while creating composed entities.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
op conversationAuthoringListSupportedPrebuiltEntities is languageOperations.ResourceList<
  AnalyzeConversationAuthoringPrebuiltEntity,
  ListQueryParametersTrait<StandardListQueryParameters &
    SupportedPrebuiltEntitiesQueryParameter>
>;

/**
 * Lists the support training config version for a given project type.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
op conversationAuthoringListTrainingConfigVersions is languageOperations.ResourceList<
  AnalyzeConversationAuthoringTrainingConfigVersion,
  ListQueryParametersTrait<StandardListQueryParameters &
    ProjectKindQueryParameter>
>;

/**
 * Lists the non-expired training jobs created for a project.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
op conversationAuthoringListTrainingJobs is languageOperations.ResourceList<
  AnalyzeConversationAuthoringTrainingJobState,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the trained models belonging to a project.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
op conversationAuthoringListTrainedModels is languageOperations.ResourceList<
  AnalyzeConversationAuthoringProjectTrainedModel,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

/**
 * Lists the exported models belonging to a project.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@added(Versions.v2025_05_15_preview)
op conversationAuthoringListExportedModels is languageOperations.ResourceList<
  AnalyzeConversationAuthoringExportedTrainedModel,
  ListQueryParametersTrait<StandardListQueryParameters>
>;

interface ConversationAuthoringDeployment {
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
  @pollingOperation(ConversationAuthoringDeployment.getDeploymentStatus)
  @access(Access.internal, "python")
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
  @pollingOperation(ConversationAuthoringDeployment.getDeploymentStatus)
  @access(Access.internal, "python")
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
   * Deletes a deployment from the specified project-assigned resources.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}/:delete-from-resources")
  @post
  @pollingOperation(
    ConversationAuthoringDeployment.getDeploymentDeleteFromResourcesStatus
  )
  @access(Access.internal, "python")
  @added(Versions.v2025_11_01)
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
       * The Language or AIService resource list for deleting the deployment.\r\n            The deployment will only be deleted from the specified resources, and will remain for the rest.
       */
      @body
      @clientName("details", "csharp")
      @typeChangedFrom(
        Versions.v2025_05_15_preview,
        AnalyzeConversationAuthoringProjectAzureResourceIds
      )
      @typeChangedFrom(
        Versions.v2025_11_15_preview,
        AnalyzeConversationAuthoringDeleteDeploymentOptions
      )
      body: AnalyzeConversationAuthoringProjectAzureResourceIds;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status of an existing delete deployment from specific resources job.
   */
  @added(Versions.v2025_11_01)
  getDeploymentDeleteFromResourcesStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringDeploymentDeleteFromResourcesJobState>;

  /**
   * Gets the status of an existing deployment job.
   */
  getDeploymentStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringDeploymentJobState>;
}

interface ConversationAuthoringProject {
  /**
   * Assign new Language or AIService Azure resources to a project to allowing deployment to them. This API is available only via AAD authentication and not supported via subscription key authentication. For more details about AAD authentication, check here: https://learn.microsoft.com/en-us/azure/cognitive-services/authentication?tabs=powershell#authenticate-with-azure-active-directory
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/:assign")
  @post
  @pollingOperation(
    ConversationAuthoringProject.getAssignProjectResourcesStatus
  )
  @access(Access.internal, "python")
  @added(Versions.v2025_11_01)
  @renamedFrom(Versions.v2025_05_15_preview, "assignProjectResources")
  @renamedFrom(Versions.v2025_11_15_preview, "AssignDeploymentResources")
  assignProjectResources is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The new project resources to be assigned.
       */
      @body
      @clientName("details", "csharp")
      body: AnalyzeConversationAuthoringProjectResourceAssignments;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Unassign resources from a project. This disallows deployment to these resources.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/:unassign")
  @post
  @pollingOperation(
    ConversationAuthoringProject.getUnassignProjectResourcesStatus
  )
  @access(Access.internal, "python")
  @added(Versions.v2025_11_01)
  @renamedFrom(Versions.v2025_05_15_preview, "unassignProjectResources")
  @renamedFrom(Versions.v2025_11_15_preview, "unassignDeploymentResources")
  unassignProjectResources is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @path
      projectName: string;

      /**
       * The list of Language or AIService Azure resource IDs to be unassigned.
       */
      @body
      @clientName("details", "csharp")
      @typeChangedFrom(
        Versions.v2025_05_15_preview,
        AnalyzeConversationAuthoringProjectAzureResourceIds
      )
      @typeChangedFrom(
        Versions.v2025_11_15_preview,
        AnalyzeConversationAuthoringUnassignDeploymentResourcesOptions
      )
      body: AnalyzeConversationAuthoringProjectAzureResourceIds;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status of an existing assign project resources job.
   */
  @added(Versions.v2025_11_01)
  @renamedFrom(Versions.v2025_05_15_preview, "getAssignProjectResourcesStatus")
  @renamedFrom(
    Versions.v2025_11_15_preview,
    "getAssignDeploymentResourcesStatus"
  )
  getAssignProjectResourcesStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringProjectResourcesJobState>;

  /**
   * Gets the status of an existing unassign project resources job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/unassign/jobs/{jobId}")
  @get
  @added(Versions.v2025_11_01)
  @renamedFrom(
    Versions.v2025_05_15_preview,
    "getUnassignProjectResourcesStatus"
  )
  @renamedFrom(
    Versions.v2025_11_15_preview,
    "getUnassignDeploymentResourcesStatus"
  )
  getUnassignProjectResourcesStatus is Azure.Core.Foundations.Operation<
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
    AnalyzeConversationAuthoringProjectResourcesJobState,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Swaps two existing deployments with each other.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/:swap")
  @post
  @pollingOperation(ConversationAuthoringProject.getSwapDeploymentsStatus)
  @access(Access.internal, "python")
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
   * Gets the status of an existing swap deployment job.
   */
  getSwapDeploymentsStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringSwapDeploymentsJobState>;
  /**
   * Gets the details of a project.
   */
  getProject is languageOperations.ResourceRead<AnalyzeConversationAuthoringProjectMetadata>;

  /**
   * Creates a new project or updates an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to rename the body"
  @createsOrUpdatesResource(AnalyzeConversationAuthoringProjectMetadata)
  @patch(#{ implicitOptionality: false })
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
  @pollingOperation(ConversationAuthoringProject.getProjectDeletionStatus)
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
  @pollingOperation(ConversationAuthoringProject.getExportStatus)
  @access(Access.internal, "python")
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
  @pollingOperation(ConversationAuthoringProject.getImportStatus)
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
  @added(Versions.v2025_05_15_preview)
  @actionSeparator("/:")
  @action("authorize-copy")
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
  @pollingOperation(ConversationAuthoringProject.getCopyProjectStatus)
  @access(Access.internal, "python")
  @added(Versions.v2025_05_15_preview)
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
  @added(Versions.v2025_05_15_preview)
  getCopyProjectStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringCopiedProjectJobState>;

  /**
   * Triggers a training job for a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:train")
  @post
  @pollingOperation(ConversationAuthoringProject.getTrainingStatus)
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
  @pollingOperation(ConversationAuthoringProject.getTrainingStatus)
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

interface ConversationAuthoringExportedModel {
  /**
   * Gets the details of an exported model.
   */
  @added(Versions.v2025_05_15_preview)
  getExportedModel is languageOperations.ResourceRead<AnalyzeConversationAuthoringExportedTrainedModel>;

  /**
   * Deletes an existing exported model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/exported-models/{exportedModelName}")
  @delete
  @pollingOperation(
    ConversationAuthoringExportedModel.getExportedModelJobStatus
  )
  @added(Versions.v2025_05_15_preview)
  @access(Access.internal, "python")
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
  @pollingOperation(
    ConversationAuthoringExportedModel.getExportedModelJobStatus
  )
  @added(Versions.v2025_05_15_preview)
  @access(Access.internal, "python")
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
  @added(Versions.v2025_05_15_preview)
  getExportedModelJobStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringExportedModelJobState>;
}
interface ConversationAuthoringTrainedModel {
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
  @pollingOperation(ConversationAuthoringTrainedModel.getEvaluationStatus)
  @added(Versions.v2025_05_15_preview)
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
  @pollingOperation(ConversationAuthoringTrainedModel.getLoadSnapshotStatus)
  @access(Access.internal, "python")
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
  @added(Versions.v2025_05_15_preview)
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
}
