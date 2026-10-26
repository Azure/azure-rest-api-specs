import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/** Adds the resource ETag used by conditional deletes. */
alias WithEvaluationETag<T extends TypeSpec.Reflection.Model> = T & {
  /** The current resource version, for use with `If-Match`. */
  @header("ETag") etag: string;
};

/** Accepted asynchronous Job deletion. */
alias EvaluationJobDeleteAcceptedResponse = AcceptedResponse & {
  /** URL to poll until the Job returns `404`. */
  @header("Location") location: string;

  /** Recommended number of seconds to wait before polling. */
  @header("Retry-After") retry_after?: int32;
};

/** Operations for EvaluationJobs and their immutable versions. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry preview operations use the project-standard feature-header and error-envelope template."
@tag("EvaluationJobs")
@removed(Versions.v1)
interface EvaluationJobs {
  /** Publishes a new immutable version and creates the Job on first publication. */
  @summary("Create an EvaluationJob version")
  @post
  @route("/evaluation_jobs/{name}/versions")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  createVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      ...WithOperationId;

      /** The Job name. */
      @maxLength(64)
      @path
      name: string;

      ...CreateEvaluationJobVersionRequest;
    },
    WithEvaluationETag<EvaluationJobVersion>
  >;

  /** Lists Jobs, each with its latest version. */
  @summary("List EvaluationJobs")
  @get
  @list
  @route("/evaluation_jobs")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  list is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    CommonPageQueryParameters,
    AgentsPagedResult<EvaluationJob>
  >;

  /** Retrieves a Job with its latest version. */
  @summary("Get an EvaluationJob")
  @get
  @route("/evaluation_jobs/{name}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  get is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The Job name. */
      @path name: string;
    },
    WithEvaluationETag<EvaluationJob>
  >;

  /** Deletes the Job and all its versions; its Runs are unaffected. */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Asynchronous deletion returns 202 with Location and no body."
  @summary("Delete an EvaluationJob")
  @delete
  @route("/evaluation_jobs/{name}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  delete is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The Job name. */
      @path name: string;

      /** The Job's current ETag. */
      @header("If-Match") if_match: string;
    },
    NoContentResponse | EvaluationJobDeleteAcceptedResponse
  >;

  /** Lists a Job's versions. */
  @summary("List EvaluationJob versions")
  @get
  @list
  @route("/evaluation_jobs/{name}/versions")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  listVersions is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The Job name. */
      @path name: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<EvaluationJobVersion>
  >;

  /** Retrieves one version; `latest` resolves to the concrete version. */
  @summary("Get an EvaluationJob version")
  @get
  @route("/evaluation_jobs/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  getVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The Job name. */
      @path name: string;

      /** The version, or `latest`. */
      @path version: string;
    },
    WithEvaluationETag<EvaluationJobVersion>
  >;

  /** Deletes one version; `latest` moves to the newest remaining version. */
  @summary("Delete an EvaluationJob version")
  @delete
  @route("/evaluation_jobs/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  deleteVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The Job name. */
      @path name: string;

      /** The version to delete. */
      @path version: string;

      /** The version's current ETag. */
      @header("If-Match") if_match: string;
    },
    NoContentResponse
  >;
}
