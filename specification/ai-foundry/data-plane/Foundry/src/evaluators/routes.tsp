import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

namespace Azure.AI.Projects;

alias EvaluatorsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.evaluations_v1_preview>;

alias ListEvaluatorVersionsParameters = {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @doc("Filter evaluators by type. Possible values: 'all', 'custom', 'builtin'.")
  @Http.query
  type?: EvaluatorType | "all";

  @doc("A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20.")
  @Http.query
  limit?: int32 = 20;
};

@tag("Evaluators")
interface Evaluators {
  // GET /evaluators/{name}/versions
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "Resource action used as a building block."
  @doc("List all versions of the given evaluator")
  @Rest.action("versions")
  @Rest.actionSeparator("/")
  @Http.get
  @list
  listVersions is Azure.Core.StandardResourceOperations.ResourceAction<
    EvaluatorVersion,
    ListEvaluatorVersionsParameters & EvaluatorsPreviewHeader,
    Azure.Core.Page<EvaluatorVersion>
  >;

  // GET /evaluators
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List the latest version of each evaluator")
  @Rest.listsResource(EvaluatorVersion)
  listLatestVersions is Azure.Core.Foundations.ResourceList<
    EvaluatorVersion,
    ListEvaluatorVersionsParameters & EvaluatorsPreviewHeader,
    Azure.Core.Page<EvaluatorVersion>
  >;

  // GET /evaluators/{name}/versions/{version}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc(
    "Get the specific version of the {name}. The service returns 404 Not Found error if the {name} does not exist.",
    EvaluatorVersion
  )
  getVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

      @doc(
        "The specific version id of the {name} to retrieve.",
        EvaluatorVersion
      )
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    Azure.Core.Foundations.ResourceOkResponse<EvaluatorVersion>
  >;

  // DELETE /evaluators/{name}/versions/{version}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc(
    "Delete the specific version of the {name}. The service returns 204 No Content if the {name} was deleted successfully or if the {name} does not exist.",
    EvaluatorVersion
  )
  @Http.delete
  deleteVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

      @doc("The version of the {name} to delete.", EvaluatorVersion)
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    Http.NoContentResponse
  >;

  // POST /evaluators/{evaluatorName}/versions
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create a new {name} with auto incremented version id", EvaluatorVersion)
  @Rest.segment("versions")
  @Http.post
  createVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

      @Http.bodyRoot
      evaluatorVersion: EvaluatorVersion;
    },
    Azure.Core.Foundations.ResourceCreatedResponse<EvaluatorVersion>
  >;

  // PATCH /evaluators/{evaluatorName}/versions/{version}
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Update an existing {name} with the given version id", EvaluatorVersion)
  @Http.patch(#{ implicitOptionality: true })
  updateVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

      @doc("The version of the {name} to update.", EvaluatorVersion)
      @Rest.segment("versions")
      @Http.path
      version: string;

      @doc("Evaluator resource")
      @Http.bodyRoot
      evaluatorVersion: EvaluatorVersion;
    },
    Azure.Core.Foundations.ResourceOkResponse<EvaluatorVersion>
  >;
}

// ============================================================================
// Evaluator Generation Jobs (LRO — follows DataGenerationJobs pattern)
// ============================================================================

const EvaluatorGenerationJobsRequiredPreviews = #{
  conditional_previews: #[
    FoundryFeaturesOptInKeys.evaluations_v1_preview
  ],
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
@tag("EvaluatorGenerationJobs")
interface EvaluatorGenerationJobs {
  /**
   * Creates an evaluator generation job. The service generates rubric-based evaluator
   * definitions from the provided source materials asynchronously.
   */
  @summary("Creates an evaluator generation job.")
  @route("evaluator_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluatorGenerationJobsRequiredPreviews)
  create is postJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluatorGenerationJob
  >;

  /**
   * Gets the details of an evaluator generation job by its ID.
   */
  @summary("Get info about an evaluator generation job.")
  @route("evaluator_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluatorGenerationJobsRequiredPreviews)
  get is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluatorGenerationJob
  >;

  /**
   * Returns a list of evaluator generation jobs.
   */
  @summary("Returns a list of evaluator generation jobs.")
  @route("evaluator_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluatorGenerationJobsRequiredPreviews)
  list is listJobsPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluatorGenerationJob,
    {
      @doc("Filter evaluator generation jobs by category.")
      @query
      category?: EvaluatorCategory;
    }
  >;

  /**
   * Deletes an evaluator generation job by its ID.
   */
  @route("evaluator_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluatorGenerationJobsRequiredPreviews)
  delete is deleteJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview
  >;
}
