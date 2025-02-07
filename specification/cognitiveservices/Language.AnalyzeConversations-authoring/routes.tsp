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

alias languageOperations = ResourceOperations<ServiceTraits, Foundations.ErrorResponse>;

interface ConversationAuthoringDeploymentResources {
    /**
   * Assign new Azure resources to a project to allow deploying new deployments to them. This API is available only via AAD authentication and not supported via subscription key authentication. For more details about AAD authentication, check here: https://learn.microsoft.com/en-us/azure/cognitive-services/authentication?tabs=powershell#authenticate-with-azure-active-directory
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/:assign")
  @post
  @pollingOperation(
    ConversationAuthoringDeploymentResources.getAssignDeploymentResourcesStatus
  )
  @added(Versions.v2023_04_15_preview)
op  assignDeploymentResources is Foundations.LongRunningOperation<
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
      details: AnalyzeConversationAuthoringAssignDeploymentResourcesOptions;
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
    ConversationAuthoringDeploymentResources.getUnassignDeploymentResourcesStatus
  )
  @added(Versions.v2023_04_15_preview)
op  unassignDeploymentResources is Foundations.LongRunningOperation<
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
      details: AnalyzeConversationAuthoringUnassignDeploymentResourcesOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

   /**
   * Gets the status of an existing assign deployment resources job.
   */
  @added(Versions.v2023_04_15_preview)
op  getAssignDeploymentResourcesStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringDeploymentResourcesJobState>;
    
/**
   * Gets the status of an existing unassign deployment resources job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/resources/unassign/jobs/{jobId}")
  @get
  @added(Versions.v2023_04_15_preview)
op  getUnassignDeploymentResourcesStatus is Azure.Core.Foundations.Operation<
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

/**
   * Lists the deployments resources assigned to the project.
   */
  @added(Versions.v2023_04_15_preview)
op  listDeploymentResources is languageOperations.ResourceList<
    AnalyzeConversationAuthoringAssignedDeploymentResource,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

/**
   * Lists the deployments to which an Azure resource is assigned. This doesn't return deployments belonging to projects owned by this resource. It only returns deployments belonging to projects owned by other resources.
   */
  @added(Versions.v2023_04_15_preview)
 op listAssignedResourceDeployments is languageOperations.ResourceList<
    AnalyzeConversationAuthoringAssignedProjectDeploymentsMetadata,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}

interface ConversationAuthoringDeployments {
     /**
   * Lists the deployments belonging to a project.
   */
op  listDeployments is languageOperations.ResourceList<
    AnalyzeConversationAuthoringProjectDeployment,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Swaps two existing deployments with each other.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/:swap")
  @post
  @pollingOperation(ConversationAuthoringDeployments.getSwapDeploymentsStatus)
op  swapDeployments is Foundations.LongRunningOperation<
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
      details: AnalyzeConversationAuthoringSwapDeploymentsOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the details of a deployment.
   */
  @get
op  getDeployment is languageOperations.ResourceRead<AnalyzeConversationAuthoringProjectDeployment>;

/**
   * Creates a new deployment or replaces an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/deployments/{deploymentName}")
  @put
  @pollingOperation(ConversationAuthoringDeployments.getDeploymentStatus)
op  deployProject is Foundations.LongRunningOperation<
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
      details: AnalyzeConversationAuthoringCreateDeploymentOptions;
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
op  deleteDeployment is Foundations.LongRunningOperation<
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
 op deleteDeploymentFromResources is Foundations.LongRunningOperation<
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
      details: AnalyzeConversationAuthoringDeleteDeploymentOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

  /**
   * Gets the status of an existing delete deployment from specific resources job.
   */
  @added(Versions.v2023_04_15_preview)
op  getDeploymentDeleteFromResourcesStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringDeploymentDeleteFromResourcesJobState>;

  /**
   * Gets the status of an existing deployment job.
   */
 op getDeploymentStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringDeploymentJobState>;

  /**
   * Gets the status of an existing swap deployment job.
   */
op  getSwapDeploymentsStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringSwapDeploymentsJobState>;

}

interface ConversationAuthoringProjects {
  /**
   * Lists the existing projects.
   */
op listProjects is languageOperations.ResourceList<
    AnalyzeConversationAuthoringProjectMetadata,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Gets the details of a project.
   */
 op getProject is languageOperations.ResourceRead<AnalyzeConversationAuthoringProjectMetadata>;

  /**
   * Creates a new project or updates an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to rename the body"
  @createsOrUpdatesResource(AnalyzeConversationAuthoringProjectMetadata)
  @parameterVisibility
  @patch
op  createProject is Foundations.ResourceOperation<
    AnalyzeConversationAuthoringProjectMetadata,
    {
      @doc("This request has a JSON Merge Patch body.")
      @TypeSpec.Http.header("Content-Type")
      contentType: "application/merge-patch+json";

      /** The request body */
      @bodyRoot details: AnalyzeConversationAuthoringCreateProjectOptions;
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
op  deleteProject is Foundations.LongRunningOperation<
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
op  getProjectDeletionStatus is Azure.Core.Foundations.Operation<
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
   * Lists the supported languages for the given project type.
   */
op  listSupportedLanguages is languageOperations.ResourceList<
    AnalyzeConversationAuthoringSupportedLanguage,
    ListQueryParametersTrait<StandardListQueryParameters &
      ProjectKindQueryParameter>
  >;

  /**
   * Triggers a job to export a project's data.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:export")
  @post
  @pollingOperation(ConversationAuthoringProjects.getExportStatus)
op  export is Foundations.LongRunningOperation<
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
op  `import` is Foundations.LongRunningOperation<
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
      exportedProject: AnalyzeConversationAuthoringExportedProject;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

/**
   * Gets the status of an export job. Once job completes, returns the project metadata, and assets.
   */
 op getExportStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringExportProjectJobState>;

  /**
   * Gets the status for an import.
   */
op  getImportStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringImportProjectJobState>;

  /**
   * Generates a copy project operation authorization to the current target Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @post
  @added(Versions.v2023_04_15_preview)
  @actionSeparator("/:")
  @action("authorize-copy")
  @clientName("AuthorizeProjectCopy", "csharp")
op  copyProjectAuthorization is languageOperations.ResourceAction<
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
op  copyProject is Foundations.LongRunningOperation<
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
      details: AnalyzeConversationAuthoringCopiedProjectOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

/**
   * Gets the status of an existing copy project job.
   */
  @added(Versions.v2023_04_15_preview)
op  getCopyProjectStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringCopiedProjectJobState>;

}
 
  
interface ConversationAuthoringTraining {
/**
   * Triggers a training job for a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/:train")
  @post
  @pollingOperation(ConversationAuthoringTraining.getTrainingStatus)
op  train is Foundations.LongRunningOperation<
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
      details: AnalyzeConversationAuthoringTrainingJobOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;

/**
   * Lists the non-expired training jobs created for a project.
   */
op  listTrainingJobs is languageOperations.ResourceList<
    AnalyzeConversationAuthoringTrainingJobState,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Gets the status for a training job.
   */
op  getTrainingStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringTrainingJobState>;

  /**
   * Triggers a cancellation for a running training job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/train/jobs/{jobId}/:cancel")
  @post
  @pollingOperation(ConversationAuthoringTraining.getTrainingStatus)
 op cancelTrainingJob is Foundations.LongRunningOperation<
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

/**
   * Lists the support training config version for a given project type.
   */
 op listTrainingConfigVersions is languageOperations.ResourceList<
    AnalyzeConversationAuthoringTrainingConfigVersion,
    ListQueryParametersTrait<StandardListQueryParameters &
      ProjectKindQueryParameter>
  >;

}
  

interface ConversationAuthoringModels {
   /**
   * Lists the trained models belonging to a project.
   */
 op listTrainedModels is languageOperations.ResourceList<
    AnalyzeConversationAuthoringProjectTrainedModel,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  /**
   * Gets the details of a trained model.
   */
op  getTrainedModel is languageOperations.ResourceRead<AnalyzeConversationAuthoringProjectTrainedModel>;

  /**
   * Deletes an existing trained model.
   */
 op deleteTrainedModel is languageOperations.ResourceDelete<AnalyzeConversationAuthoringProjectTrainedModel>;

  /**
   * Triggers evaluation operation on a trained model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/models/{trainedModelLabel}/:evaluate")
  @post
  @pollingOperation(ConversationAuthoringModels.getEvaluationStatus)
  @added(Versions.v2023_04_15_preview)
op  evaluateModel is Foundations.LongRunningOperation<
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
      details: AnalyzeConversationAuthoringEvaluationOptions;
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
op  loadSnapshot is Foundations.LongRunningOperation<
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
 op getEvaluationStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringEvaluationJobState>;

  /**
   * Gets the detailed results of the evaluation for a trained model. This includes the raw inference results for the data included in the evaluation process.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
op  getModelEvaluationResults is languageOperations.ResourceList<
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
op  getModelEvaluationSummary is Foundations.Operation<
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
op  getLoadSnapshotStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringLoadSnapshotJobState>;
}

  

interface ConversationAuthoringPrebuilts { 
    
/**
   * Lists the supported prebuilt entities that can be used while creating composed entities.
   */
op  listSupportedPrebuiltEntities is languageOperations.ResourceList<
    AnalyzeConversationAuthoringPrebuiltEntity,
    ListQueryParametersTrait<StandardListQueryParameters &
      SupportedPrebuiltEntitiesQueryParameter>
  >;
}
  
interface ConversationAuthoringExportedModels { 
  

  

  /**
   * Gets the details of an exported model.
   */
  @added(Versions.v2024_11_15_preview)
 op getExportedModel is languageOperations.ResourceRead<AnalyzeConversationAuthoringExportedTrainedModel>;
  /**
   * Lists the exported models belonging to a project.
   */
  @added(Versions.v2024_11_15_preview)
 op listExportedModels is languageOperations.ResourceList<
    AnalyzeConversationAuthoringExportedTrainedModel,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
  /**
   * Deletes an existing exported model.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/authoring/analyze-conversations/projects/{projectName}/exported-models/{exportedModelName}")
  @delete
  @pollingOperation(ConversationAuthoringExportedModels.getExportedModelJobStatus)
  @added(Versions.v2024_11_15_preview)
op  deleteExportedModel is Foundations.LongRunningOperation<
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
  @pollingOperation(ConversationAuthoringExportedModels.getExportedModelJobStatus)
  @added(Versions.v2024_11_15_preview)
op  createOrUpdateExportedModel is Foundations.LongRunningOperation<
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
      details: ExportedModelOptions;
    },
    AcceptedResponse,
    {},
    Foundations.ErrorResponse
  >;
  /**
   * Gets the status for an existing job to create or update an exported model.
   */
  @added(Versions.v2024_11_15_preview)
op  getExportedModelJobStatus is languageOperations.ResourceRead<AnalyzeConversationAuthoringExportedModelJobState>;
}
