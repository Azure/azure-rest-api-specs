import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./ops.tsp";

using TypeSpec.Versioning;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.QuestionAnswering.Authoring;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias LanguageOperations = ResourceOperations<ServiceTraits, ErrorResponse>;

interface QuestionAnsweringProjects {
  /**
   * Gets all projects for a user.
   */
  listProjects is LanguageOperations.ResourceList<
    QuestionAnsweringProjectMetadata,
    ListProjectsQueryParams
  >;

  /**
   * Get the requested project metadata.
   */
  getProjectDetails is LanguageOperations.ResourceRead<QuestionAnsweringProjectMetadata>;

  /**
   * Create or update a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to rename the body"
  createProject is ResourceCreateOrUpdateWithJsonContentType<
    QuestionAnsweringProjectMetadata,
    {},
    ServiceTraits,
    ErrorResponse
  >;

  /**
   * Delete the project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "GA'd method"
  @route("/authoring/query-knowledgebases/projects/{projectName}")
  @delete
  @pollingOperation(QuestionAnsweringProjects.getDeleteStatus)
  deleteProject is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
      @path
      projectName: string;
    },
    DeleteProjectAcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of a Project delete job.
   */
  getDeleteStatus is LanguageOperations.ResourceRead<QuestionAnsweringAuthoringProjectDeletionJobState>;

  /**
   * Export project metadata and assets.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "GA'd method"
  @route("/authoring/query-knowledgebases/projects/{projectName}/:export")
  @post
  @pollingOperation(QuestionAnsweringProjects.getExportStatus)
  export is Foundations.LongRunningOperation<
    {
      /** The name of the project to use. */
      @maxLength(100)
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
      @path
      projectName: string;

      /** Optional export parameters. See `ExportQueryParameters`. */
      ...ExportQueryParameters;
    },
    ExportJobResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of an Export job, once job completes, returns the project
   * metadata, and assets.
   */
  @get
  getExportStatus is LanguageOperations.ResourceRead<QuestionAnsweringAuthoringExportJobState>;

  /**
   * Import project assets.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "GA'd method"
  @sharedRoute
  @route("/authoring/query-knowledgebases/projects/{projectName}/:import")
  @post
  @pollingOperation(QuestionAnsweringProjects.getImportStatus)
  `import` is Foundations.LongRunningOperation<
    {
      /** The name of the project to use. */
      @maxLength(100)
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
      @path
      projectName: string;

      /** Optional import parameters. See `ImportQueryParameters`. */
      ...ImportQueryParameters;

      /** Project assets the needs to be imported. */
      @bodyRoot
      body?: ImportJobOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Import project assets from file.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "endpoint has already been GA'd"
  #suppress "@azure-tools/typespec-azure-core/byos" "method overload `import` already support byos with fileUri"
  #suppress "@azure-tools/typespec-autorest/unsupported-multipart-type" "method overload `import` already support byos with fileUri"
  @added(Versions.v2025_05_15_preview)
  @sharedRoute
  @route("/authoring/query-knowledgebases/projects/{projectName}/:import")
  @pollingOperation(QuestionAnsweringProjects.getImportStatus)
  importFromFiles is Foundations.LongRunningOperation<
    {
      @doc("This request has a multi-part body.")
      @TypeSpec.Http.header("Content-Type")
      contentType: "multipart/form-data";

      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
      @path
      projectName: string;

      /**
       * Kind of the asset of the project.
       */
      @query("assetKind")
      assetKind?: AssestKind;

      /**
       * Collection of files containing project assets the needs to be imported.
       */
      @multipartBody
      body: ImportFiles;
    },
    AcceptedResponse,
    ServiceTraits,
    ErrorResponse
  >;

  /**
   * Gets the status of an Import job.
   */
  getImportStatus is LanguageOperations.ResourceRead<QuestionAnsweringAuthoringImportJobState>;

  /**
   * Deploy project to production.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "GA'd method"
  @route("/authoring/query-knowledgebases/projects/{projectName}/deployments/{deploymentName}")
  @put
  @pollingOperation(QuestionAnsweringProjects.getDeployStatus)
  deployProject is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
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
   * Gets the status of a Deploy job.
   */
  getDeployStatus is LanguageOperations.ResourceRead<QuestionAnsweringAuthoringProjectDeploymentJobState>;

  /**
   * List all deployments of a project.
   */
  listDeployments is LanguageOperations.ResourceList<
    ProjectDeployment,
    ListDeploymentsQueryParams
  >;

  /**
   * Gets all the synonyms of a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "GA'd method"
  getSynonyms is LanguageOperations.ResourceList<
    WordAlterations,
    ListSynonymsQueryParams
  >;

  /**
   * Updates all the synonyms of a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "GA'd method"
  @route("/authoring/query-knowledgebases/projects/{projectName}/synonyms")
  @put
  updateSynonyms is Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
      @path
      projectName: string;

      /**
       * All the synonyms of a project.
       */
      @bodyRoot
      body: SynonymAssets;
    },
    UpdateSynonymsWithNoContentResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets all the sources of a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "GA'd method"
  getSources is LanguageOperations.ResourceList<
    QnaSourceRecord,
    ListSourcesQueryParams
  >;

  /**
   * Updates the sources of a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "GA'd method"
  @route("/authoring/query-knowledgebases/projects/{projectName}/sources")
  @sharedRoute
  @patch(#{ implicitOptionality: true })
  @pollingOperation(QuestionAnsweringProjects.getUpdateSourcesStatus)
  updateSources is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
      @path
      projectName: string;

      /**
       * Update sources parameters of a project.
       */
      #suppress "@azure-tools/typespec-azure-core/request-body-problem" "GA'd method input"
      @bodyRoot
      body: UpdateSourceRecord[];
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Updates the sources of a project from files.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "endpoint has already been GA'd"
  #suppress "@azure-tools/typespec-azure-core/byos" "method overload `updateSources` already support byos with fileUri"
  #suppress "@azure-tools/typespec-autorest/unsupported-multipart-type" "method overload `updateSources` already support byos with fileUri"
  @added(Versions.v2025_05_15_preview)
  @sharedRoute
  @patch(#{ implicitOptionality: true })
  @route("/authoring/query-knowledgebases/projects/{projectName}/sources")
  @pollingOperation(QuestionAnsweringProjects.getUpdateSourcesStatus)
  updateSourcesFromFiles is Foundations.LongRunningOperation<
    {
      @doc("This request has a multi-part body.")
      @TypeSpec.Http.header("Content-Type")
      contentType: "multipart/form-data";

      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
      @path
      projectName: string;

      /**
       * Collection of files containing project assets the needs to be imported.
       */
      @multipartBody
      body: UpdateSourceFiles;
    },
    AcceptedResponse,
    ServiceTraits,
    ErrorResponse
  >;

  /**
   * Gets the status of update sources job.
   */
  getUpdateSourcesStatus is LanguageOperations.ResourceRead<QuestionAnsweringAuthoringUpdateSourcesJobState>;

  /**
   * Gets all the QnAs of a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "GA'd method"
  getQnas is LanguageOperations.ResourceList<
    RetrieveQnaRecord,
    ListQnaQueryParams
  >;

  /**
   * Updates the QnAs of a project.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "GA'd method"
  @route("/authoring/query-knowledgebases/projects/{projectName}/qnas")
  @patch(#{ implicitOptionality: true })
  @pollingOperation(QuestionAnsweringProjects.getUpdateQnasStatus)
  updateQnas is Foundations.LongRunningOperation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
      @path
      projectName: string;

      /**
       * Update QnAs parameters of a project.
       */
      @bodyRoot
      body: UpdateQnaOptions;
    },
    AcceptedResponse,
    {},
    ErrorResponse
  >;

  /**
   * Gets the status of update QnAs job.
   */
  getUpdateQnasStatus is LanguageOperations.ResourceRead<QuestionAnsweringAuthoringUpdateQnasJobState>;

  /**
   * Update Active Learning feedback.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "GA'd method"
  @route("/authoring/query-knowledgebases/projects/{projectName}/feedback")
  @post
  addFeedback is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the project to use.
       */
      @maxLength(100)
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
      @path
      projectName: string;

      /**
       * Feedback for Active Learning.
       */
      @bodyRoot
      body: ActiveLearningFeedback;
    },
    AddFeedBackNoContentResponse,
    {},
    ErrorResponse
  >;
}
