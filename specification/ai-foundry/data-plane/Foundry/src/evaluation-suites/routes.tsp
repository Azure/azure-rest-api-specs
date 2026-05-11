import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

namespace Azure.AI.Projects;
using Http;
using OpenAPI;
using Rest;
using TypeSpec.Versioning;

alias EvaluationSuiteFilterQueryParams = {
  @query("agent_name")
  @doc("Filter by associated Foundry agent name (from target).")
  agent_name?: string;
};

// ---------------------------------------------------------------------------
// CRUD + Versioning operations (VersionedCrud pattern)
// ---------------------------------------------------------------------------

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Using VersionedCrud pattern from asset-versioning guideline"
@route("evaluation_suites")
interface EvaluationSuites {
  // ── $latest CRUD ──────────────────────────────────────────────────

  @put
  @route("{name}")
  @summary("Create or update an evaluation suite ($latest).")
  @doc("Creates a new evaluation suite or replaces the current $latest state. The name in the path identifies the suite.")
  createOrUpdate is FoundryDataPlaneOperation<
    {
      ...EvaluationSuitePath;
      @body body: EvaluationSuite;
    },
    EvaluationSuite
  >;

  @get
  @route("{name}")
  @summary("Get the current $latest state of an evaluation suite.")
  @doc("Returns the mutable $latest working state of the evaluation suite.")
  get is FoundryDataPlaneOperation<EvaluationSuitePath, EvaluationSuite>;

  @get
  @summary("List all evaluation suites.")
  @doc("Returns a paginated list of evaluation suites. Supports filtering by agent name.")
  list is FoundryDataPlaneOperation<
    {
      ...CommonPageQueryParameters;
      ...EvaluationSuiteFilterQueryParams;
    },
    AgentsPagedResult<EvaluationSuite>
  >;

  @delete
  @route("{name}")
  @summary("Delete an evaluation suite and all its snapped versions.")
  @doc("Permanently deletes the evaluation suite identified by name, including all snapped versions.")
  delete is FoundryDataPlaneOperation<EvaluationSuitePath, void>;

  // ── Versioning operations (VersionedCrud) ─────────────────────────

  @post
  @route("{name}:snapshot_version")
  @summary("Snap the current $latest state as a new immutable version.")
  @doc("Creates a new immutable version by snapshotting the current $latest state. The version number is server-assigned and monotonically increasing.")
  snapshotVersion is FoundryDataPlaneOperation<
    EvaluationSuitePath,
    VersionedEvaluationSuite
  >;

  @post
  @route("{name}/versions")
  @summary("Create a version directly — updates $latest and snaps a new immutable version.")
  @doc("Updates the $latest state with the provided body and immediately snaps it as a new immutable version in one atomic operation.")
  createVersion is FoundryDataPlaneOperation<
    {
      ...EvaluationSuitePath;
      @body body: EvaluationSuite;
    },
    VersionedEvaluationSuite
  >;

  @get
  @route("{name}/versions/{version}")
  @summary("Get a specific snapped version of an evaluation suite.")
  @doc("Returns the immutable snapped version identified by version number.")
  getVersion is FoundryDataPlaneOperation<
    {
      ...EvaluationSuitePath;
      @doc("The version identifier.")
      @path version: string;
    },
    VersionedEvaluationSuite
  >;

  @get
  @route("{name}/versions")
  @summary("List all snapped versions of an evaluation suite.")
  @doc("Returns a paginated list of all immutable snapped versions for the specified evaluation suite.")
  listVersions is FoundryDataPlaneOperation<
    {
      ...EvaluationSuitePath;
      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<VersionedEvaluationSuite>
  >;

  // ── Action ────────────────────────────────────────────────────────

  @post
  @route("{name}:run")
  @summary("Run an evaluation using the suite's testing criteria and dataset.")
  @doc("Triggers an evaluation run using the suite's testing criteria, dataset, and target. Returns the eval and run IDs for tracking.")
  run is FoundryDataPlaneOperation<
    {
      ...EvaluationSuitePath;
      @body body: EvaluationSuiteRunRequest;
    },
    EvaluationSuiteRunResponse
  >;
}

// ---------------------------------------------------------------------------
// Generate API (LRO jobs pattern — follows evaluator_generation_jobs)
// ---------------------------------------------------------------------------

const EvaluationSuiteGenerationJobsRequiredPreviews = #{
  conditional_previews: #[
    FoundryFeaturesOptInKeys.evaluations_v1_preview
  ],
};

@removed(Versions.v1)
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
@tag("EvaluationSuiteGenerationJobs")
interface EvaluationSuiteGenerationJobs {
  @summary("Creates an evaluation suite generation job.")
  @route("evaluation_suite_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  create is postJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  @summary("Get info about an evaluation suite generation job.")
  @route("evaluation_suite_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  get is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  @summary("Returns a list of evaluation suite generation jobs.")
  @route("evaluation_suite_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  list is listJobsPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  @summary("Cancels an evaluation suite generation job.")
  @route("evaluation_suite_generation_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  @summary("Deletes an evaluation suite generation job.")
  @route("evaluation_suite_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  delete is deleteJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview
  >;
}
