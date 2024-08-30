import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.Authoring;


alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias languageOperations = ResourceOperations<ServiceTraits, ErrorResponse>;


/**
 * Gets the details of a project.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get project details")
@get
op getProject is languageOperations.ResourceRead<
  ProjectMetadata
>;


alias ShowStatsQueryParameter = TraitContext.Create;
/**
 * Creates a new project or updates an existing one.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Create project")
op createProject is languageOperations.ResourceCreateOrUpdate<ProjectMetadata>;

/**
 * Deletes a project.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Delete project")
@pollingOperation(getProjectDeletionStatus)
op deleteProject is languageOperations.LongRunningResourceDelete<ProjectMetadata>;

/**
 * Generates a copy project operation authorization to the current target Azure
 * resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@summary("Copy project authorization")
@post
op `authorize-copy` is languageOperations.ResourceAction<
ProjectMetadata,
CopyAuthorizationOptions,
CopyProjectOptions
>
;

/**
 * Copies an existing project to another Azure resource.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Copy project")
@post
@pollingOperation(getCopyProjectStatus)
op copy is languageOperations.LongRunningResourceAction <
  ProjectMetadata,
  CopyProjectOptions,
  CopyProjectJobState,
  ErrorResponse, 
  {}
>;

/**
 * Triggers a job to export a project's data.
 */
@summary("Export project")
@post
@pollingOperation(getExportStatus)
op export is languageOperations.LongRunningResourceAction <
  ProjectMetadata,
  {
    /**
     * The format of the exported project file to use.
     */
    @query("format")
    format?: ExportedProjectFormat;

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
  ExportProjectJobState, 
  ErrorResponse, 
  {}
>;

/**
 * Triggers a job to import a project. If a project with the same name already
 * exists, the data of that project is replaced.
 */
@summary("Import project")
@post
@pollingOperation(getImportStatus)
op `import` is languageOperations.LongRunningResourceAction <
  ProjectMetadata,
  {
    /**
     * The format of the exported project file to use.
     */
    @query("format")
    format?: ExportedProjectFormat;

    /**
     * The project data to import.
     */
    @body
    body: ExportedProject;
  },
  ImportProjectJobState, 
  ErrorResponse, 
  {}
>;

/**
 * Triggers a training job for a project.
 */
@summary("Train project")
@post
@pollingOperation(getTrainingStatus)
op train is languageOperations.LongRunningResourceAction <
  ProjectMetadata,
  TrainingJobOptions,
  TrainingJobState,
  ErrorResponse, 
  {}
>;

/**
 * Gets the status of an existing copy project job.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get copy project status")
@route("/{projectName}/copy/jobs/{jobId}")
@get
op getCopyProjectStatus is Foundations.Operation<
  {
    /**
     * The project name.
     */
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("List deployments")
@get
op listDeployments is languageOperations.ResourceList<
    ProjectDeployment,
  ListProjectsQueryParameters  
>;

/**
 * Gets the details of a deployment.
 */
@summary("Get deployment details")
@get
op getDeployment is languageOperations.ResourceRead<
  ProjectDeployment
>;

/**
 * Creates a new deployment or replaces an existing one.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Update deployment")
@route("/projects/{projectName}/deployments/{deploymentName}")
@put
@pollingOperation(getDeploymentStatus)
op deployProject is Foundations.LongRunningOperation<
  {
    /**
     * The project name.
     */
    @path
    projectName: string;

    /**
     * The deployment name.
     */
    @path
    deploymentName: string;

    /**
     * The new deployment info.
     */
    @body
    body: CreateDeploymentOptions;
  },
  AcceptedResponse,
  {},
  ErrorResponse
>;

/**
 * Deletes a project deployment.
 */
@summary("Delete deployment")
@pollingOperation(getDeploymentStatus)
op deleteDeployment is languageOperations.LongRunningResourceDelete<
  ProjectDeployment
>;

/**
 * Deletes a project deployment from the specified assigned resources.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@summary("Delete deployment from resources")
@pollingOperation(getDeploymentDeleteFromResourcesStatus)
op `delete-from-resources` is languageOperations.LongRunningResourceAction<
  ProjectDeployment,
  DeleteDeploymentOptions,
  DeploymentJobState,
  ErrorResponse,
  {}
>;

/**
 * Gets the status of an existing delete deployment from specific resources job.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get deployment deletion from resources status")
@route("/projects/{projectName}/deployments/{deploymentName}/delete-from-resources/jobs/{jobId}")
@get
op getDeploymentDeleteFromResourcesStatus is Foundations.Operation<
  {
    /**
     * The project name.
     */
    @path
    projectName: string;

    /**
     * The deployment name.
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get deployment status")
@route("/projects/{projectName}/deployments/{deploymentName}/jobs/{jobId}")
@get
op getDeploymentStatus is Foundations.Operation<
  {
    /**
     * The project name.
     */
    @path
    projectName: string;

    /**
     * The deployment name.
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Swap deployments")
@route("/projects/{projectName}/deployments/:swap")
@post
@pollingOperation(getSwapDeploymentsStatus)
op swapDeployments is Foundations.LongRunningOperation<
  {
    /**
     * The project name.
     */
    @path
    projectName: string;

    /**
     * The job object to swap two deployments.
     */
    @body
    body: SwapDeploymentsOptions;
  },
  AcceptedResponse,
  {},
  ErrorResponse
>;

/**
 * Gets the status of an existing swap deployment job.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Gets swap deployments status")
@route("/projects/{projectName}/deployments/swap/jobs/{jobId}")
@get
op getSwapDeploymentsStatus is Foundations.Operation<
  {
    /**
     * The project name.
     */
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get export status")
@route("/projects/{projectName}/export/jobs/{jobId}")
@get
op getExportStatus is Foundations.Operation<
  {
    /**
     * The project name.
     */
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
 * Gets the result of an export job.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get export result")
@route("/projects/{projectName}/export/jobs/{jobId}/result")
@get
op getExportResult is Foundations.Operation<
  {
    /**
     * The project name.
     */
    @path
    projectName: string;

    /**
     * The job ID.
     */
    @path
    jobId: string;
  },
  ExportedProject
>;

/**
 * Gets the status for an import.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get import status")
@route("/projects/{projectName}/import/jobs/{jobId}")
@get
op getImportStatus is Foundations.Operation<
  {
    /**
     * The project name.
     */
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("List trained models")
op listTrainedModels is languageOperations.ResourceList<
  ProjectTrainedModel,
  ListProjectsQueryParameters
>;

/**
 * Gets the details of a trained model.
 */
@summary("Get trained model details")
op getTrainedModel is languageOperations.ResourceRead<ProjectTrainedModel>;

/**
 * Deletes an existing trained model.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Delete trained model")
op deleteTrainedModel is languageOperations.ResourceDelete<ProjectTrainedModel>;

/**
 * Triggers evaluation operation on a trained model.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Evaluate model")
//@route("/{projectName}/models/{trainedModelLabel}/:evaluate")
@post
@pollingOperation(getEvaluationStatus)
op evaluate is languageOperations.LongRunningResourceAction<
  ProjectTrainedModel,
  EvaluationOnDemandOptions,
  EvaluationJobState,
  ErrorResponse,
  {}
>;

/**
 * Restores the snapshot of this trained model to be the current working directory
 * of the project.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@summary("Load trained model snapshot to the working directory.")
@pollingOperation(getLoadSnapshotStatus)
op `load-snapshot` is languageOperations.LongRunningResourceAction <
  ProjectTrainedModel,
  {},
  LoadSnapshotJobState,
  ErrorResponse,
  {}
>;

/**
 * Gets the status for an evaluation job.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get evaluation status")
@route("/projects/{projectName}/models/{trainedModelLabel}/evaluate/jobs/{jobId}")
@get
op getEvaluationStatus is Foundations.Operation<
  {
    /**
     * The project name.
     */
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get trained model evaluation result")
@route("/projects/{projectName}/models/{trainedModelLabel}/evaluation/result")
@get
op getModelEvaluationResults is Foundations.Operation<
  {
    /**
     * The project name.
     */
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
     * The number of utterances to be returned.
     */
    @query("top")
    top?: int32;

    /**
     * The offset in the response.
     */
    @query("skip")
    skip?: int32;

    /**
     * The maximum number of utterances per page.
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get trained model evaluation summary")
@route("/projects/{projectName}/models/{trainedModelLabel}/evaluation/summary-result")
@get
op getModelEvaluationSummary is Foundations.Operation<
  {
    /**
     * The project name.
     */
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get load snapshot status")
@route("/projects/{projectName}/models/{trainedModelLabel}/load-snapshot/jobs/{jobId}")
@get
op getLoadSnapshotStatus is Foundations.Operation<
  {
    /**
     * The project name.
     */
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Lists deployment resources")
op listDeploymentResources is languageOperations.ResourceList<
  AssignedDeploymentResource, 
  ListProjectsQueryParameters
  >;

/**
 * Assign new Azure resources to a project to allow deploying new deployments to
 * them. This API is available only via AAD authentication and not supported via
 * subscription key authentication. For more details about AAD authentication,
 * check here:
 * https://learn.microsoft.com/en-us/azure/cognitive-services/authentication?tabs=powershell#authenticate-with-azure-active-directory
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Assign deployment resources")
@route("/projects/{projectName}/resources/:assign")
@post
@pollingOperation(getAssignDeploymentResourcesStatus)
op assignDeploymentResources is Foundations.LongRunningOperation<
  {
    /**
     * The project name.
     */
    @path
    projectName: string;

    /**
     * The new project resources info.
     */
    @body
    body: AssignDeploymentResourcesOptions;
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
@summary("Unassign deployment resources")
@route("/projects/{projectName}/resources/:unassign")
@post
@pollingOperation(getUnassignDeploymentResourcesStatus)
op unassignDeploymentResources is Foundations.LongRunningOperation<
  {
    /**
     * The project name.
     */
    @path
    projectName: string;

    /**
     * The info for the deployment resources to be deleted.
     */
    @body
    body: UnassignDeploymentResourcesOptions;
  },
  AcceptedResponse,
  {},
  ErrorResponse
>;

/**
 * Gets the status of an existing assign deployment resources job.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get assign deployment resources status")
@route("/projects/{projectName}/resources/assign/jobs/{jobId}")
@get
op getAssignDeploymentResourcesStatus is Foundations.Operation<
  {
    /**
     * The project name.
     */
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get unassign deployment resources status")
@route("/projects/{projectName}/resources/unassign/jobs/{jobId}")
@get
op getUnassignDeploymentResourcesStatus is Foundations.Operation<
  {
    /**
     * The project name.
     */
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("List training jobs")
op listTrainingJobs is languageOperations.ResourceList<
  TrainingJobState, 
  ListProjectsQueryParameters
  >;

/**
 * Gets the status for a training job.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get training status")
op getTrainingStatus is languageOperations.ResourceRead<TrainingJobState>;

/**
 * Triggers a cancellation for a running training job.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Cancel training")
@pollingOperation(getTrainingStatus)
op cancel is languageOperations.LongRunningResourceAction <
  TrainingJobState,
  {},
  TrainingJobState,
  ErrorResponse,
  {}
>;



alias ListProjectsQueryParameters = ListQueryParametersTrait<{
  /** The number of projects to be returned. */
  @query
  top?: int32;

  /** The offset in the response. */
  @query
  skip?: int32;

  /** The maximum number of projects per page. */
  @query
  maxpagesize?: int32;
}>;

/**
 * Lists the existing projects.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("List projects")
@get
op listProjects is languageOperations.ResourceList<
    ProjectMetadata,
  ListProjectsQueryParameters  
>;

/**
 * Gets the status for a project deletion job.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Get project deletion status")
@route("/projects/global/deletion-jobs/{jobId}")
@get
op getProjectDeletionStatus is Foundations.Operation<
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("Lists assigned resource deployments")
@route("/projects/global/deployments/resources")
@get
op listAssignedResourceDeployments is Foundations.Operation<
  {
    /**
     * The number of deployments to be returned.
     */
    @query("top")
    top?: int32;

    /**
     * The offset in the response.
     */
    @query("skip")
    skip?: int32;

    /**
     * The maximum number of deployments per page.
     */
    @query("maxpagesize")
    maxpagesize?: int32;
  },
  AssignedResourceDeploymentsMetadata
>;

/**
 * Lists the supported languages for the given project type.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("List supported languages")
@route("/projects/global/languages")
@get
op getSupportedLanguages is Foundations.Operation<
  {
    /**
     * The project kind.
     */
    @query("projectKind")
    projectKind: ProjectKind;

    /**
     * The number of languages to be returned.
     */
    @query("top")
    top?: int32;

    /**
     * The offset in the response.
     */
    @query("skip")
    skip?: int32;

    /**
     * The maximum number of languages per page.
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("List supported prebuilt entities")
@route("/projects/global/prebuilt-entities")
@get
op getSupportedPrebuiltEntities is Foundations.Operation<
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
     * The number of prebuilt entities to be returned.
     */
    @query("top")
    top?: int32;

    /**
     * The offset in the response.
     */
    @query("skip")
    skip?: int32;

    /**
     * The maximum number of prebuilt entities per page.
     */
    @query("maxpagesize")
    maxpagesize?: int32;
  },
  PrebuiltEntities
>;

/**
 * Lists the support training config version for a given project type.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@summary("List training config versions")
@route("/projects/global/training-config-versions")
@get
op listTrainingConfigVersions is Foundations.Operation<
  {
    /**
     * The project kind.
     */
    @query("projectKind")
    projectKind: ProjectKind;

    /**
     * The number of config versions to be returned.
     */
    @query("top")
    top?: int32;

    /**
     * The offset in the response.
     */
    @query("skip")
    skip?: int32;

    /**
     * The maximum number of config versions per page.
     */
    @query("maxpagesize")
    maxpagesize?: int32;
  },
  TrainingConfigVersions
>;
