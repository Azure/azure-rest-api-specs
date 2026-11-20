import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/** Standard operation foundation with the implemented RLE error contract. */
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "The implemented error body can be structured JSON or a validation string; both are errors, never success responses."
#suppress "@azure-tools/typespec-azure-core/no-error-status-codes" "Harbor upload operations return an empty feature-gate 404, distinct from their default structured/string error payload."
op RleOperation<
  Params extends Reflection.Model,
  Response
> is Azure.Core.Foundations.Operation<
  Params,
  Response,
  FoundryDataPlaneApiVersionParameter,
  RleErrorResult
>;

/** Environment publication and job/rollout inspection. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "RLE's implemented immutable-version POST and continuation-token protocol do not implement the standard resource-operation templates."
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "The implemented error body can be structured JSON or a validation string; both are errors, never success responses."
@tag("Reinforcement Learning Environments")
@route("/rl_environments")
interface RLE {
  /** Register an immutable version. Returns 400 for conflicting version selectors,
   * invalid harness/defaults or non-successor versions; 403 if not enabled.
   * Registration starts image conversion but does not wait for readiness.
   */
  @post
  @summary("Register an environment version")
  @extension(
    "x-ms-examples",
    #{
      `Register an immutable Gym environment`: #{
        $ref: "../../examples/v1/rle/RegisterEnvironment.json",
      },
      `Register a Harbor environment with a prepared task`: #{
        $ref: "../../examples/v1/rle/RegisterHarborEnvironment.json",
      },
    }
  )
  createEnvironment is RleOperation<
    {
      /** Environment image, identity and configuration. */
      @body body: RleCreateEnvironmentContent;
    },
    {
      /** Registration completed. */
      @statusCode statusCode: 201;

      /** URI of the registered version. */
      @header("Location") location: string;

      /** Registered version with image conversion status. */
      @body body: RleEnvironment;
    }
  >;

  /** List one latest registered version per environment; invalid paging returns 400. */
  @get
  @list
  @summary("List environments")
  @extension(
    "x-ms-examples",
    #{
      `List environments using an opaque continuation token`: #{
        $ref: "../../examples/v1/rle/ListEnvironments.json",
      },
    }
  )
  listEnvironments is RleOperation<
    {
      ...RlePageParameters;
      ...RleOrderParameter;
    },
    RlePage<RleEnvironment>
  >;

  /** Get the latest registered version; returns 404 if the environment does not exist. */
  @get
  @route("/{name}")
  @summary("Get an environment")
  getEnvironment is RleOperation<
    {
      /** Environment name. */
      @path name: string;
    },
    RleEnvironment
  >;

  /** List immutable versions; invalid paging returns 400. */
  @get
  @list
  @route("/{name}/versions")
  @summary("List environment versions")
  listEnvironmentVersions is RleOperation<
    {
      /** Environment name. */
      @path name: string;

      ...RlePageParameters;
      ...RleOrderParameter;
    },
    RlePage<RleEnvironment>
  >;

  /** Get an exact release and refresh pending conversion state; returns 400 for
   * an invalid semantic version and 404 when the release does not exist.
   */
  @get
  @route("/{name}/versions/{version}")
  @summary("Get an environment version")
  getEnvironmentVersion is RleOperation<RleVersionPath, RleEnvironment>;

  /** Delete one release and request image cleanup. Returns 404 for a missing
   * release. This operation does not delete the publisher's ACR image.
   */
  @delete
  @route("/{name}/versions/{version}")
  @summary("Delete an environment version")
  deleteEnvironmentVersion is RleOperation<RleVersionPath, NoContentResponse>;

  /** List Harbor tasks and per-task image readiness; returns 404 for a missing
   * release and 400 for invalid version or paging parameters.
   */
  @get
  @list
  @route("/{name}/versions/{version}/tasks")
  @summary("List published environment tasks")
  listEnvironmentTasks is RleOperation<
    {
      ...RleVersionPath;
      ...RlePageParameters;
      ...RleOrderParameter;
    },
    RlePage<RleHarborTask>
  >;

  /** Get a short-lived write URL for one archive digest. If exists is true,
   * reuse path without uploading. Otherwise upload bytes directly to storage
   * and finalize before registration. Invalid hashes return 400; disabled
   * environment or execution access returns an empty 404 response.
   */
  #suppress "@azure-tools/typespec-azure-core/no-error-status-codes" "Feature-gate 404 has no body and must not be assigned the default error payload."
  @post
  @route("/tasks/upload-url")
  @summary("Get a Harbor task bundle upload target")
  @extension(
    "x-ms-examples",
    #{
      `Reuse a task bundle already uploaded to this project`: #{
        $ref: "../../examples/v1/rle/GetHarborUploadUrl.json",
      },
    }
  )
  getHarborUploadUrl is RleOperation<
    {
      /** Digest of the complete task archive. */
      @body body: RleHarborUploadUrlContent;
    },
    RleHarborUploadTarget | RleHarborFeatureUnavailable
  >;

  /** Validate staged bytes against their digest and size bound, then publish
   * the immutable bundle path. Returns 400 for invalid/missing staging data,
   * size or digest mismatch; feature unavailability returns an empty 404.
   * This operation completes synchronously and is not an LRO.
   */
  #suppress "@azure-tools/typespec-azure-core/no-error-status-codes" "Feature-gate 404 has no body and must not be assigned the default error payload."
  @post
  @route("/tasks/finalize")
  @summary("Finalize a Harbor task bundle upload")
  @extension(
    "x-ms-examples",
    #{
      `Finalize a staged task archive`: #{
        $ref: "../../examples/v1/rle/FinalizeHarborBundle.json",
      },
    }
  )
  finalizeHarborBundle is RleOperation<
    {
      /** Archive digest and its per-attempt staging path. */
      @body body: RleHarborFinalizeUploadContent;
    },
    RleHarborUploadTarget | RleHarborFeatureUnavailable
  >;

  /** Get durable job status and metadata; returns 404 when the job is unknown. */
  @get
  @route("/jobs/{jobId}")
  @summary("Get RLE job metadata")
  getJob is RleOperation<
    {
      /** Training job identifier. */
      @path jobId: string;
    },
    RleJob
  >;

  /** Read stored job metrics after a training step; returns 404 for an unknown
   * job and 400 for invalid paging. Records retain their producer-defined schema.
   */
  @get
  @list
  @route("/jobs/{jobId}/metrics")
  @summary("List RLE job metrics")
  listJobMetrics is RleOperation<
    {
      /** Training job identifier. */
      @path jobId: string;

      /** Return records after this training step; defaults to -1. */
      @query lastStep?: int64;

      ...RlePageParameters;
    },
    RlePage<unknown>
  >;

  /** List a job's rollout summaries; lastSequence is used only without a
   * continuation token. Returns 400 for invalid cursors and 404 for an unknown job.
   */
  @get
  @list
  @route("/jobs/{jobId}/rollouts")
  @summary("List rollouts for a job")
  listJobRollouts is RleOperation<
    {
      /** Training job identifier. */
      @path jobId: string;

      /** Return rollouts after this sampler sequence. */
      @query lastSequence?: int64;

      ...RlePageParameters;
    },
    RlePage<RleRolloutSummary>
  >;

  /** Get execution metadata; returns 404 for an unknown rollout. Graph retention
   * is separate from durable metadata; inspect result_available before reading it.
   */
  @get
  @route("/rollouts/{rolloutId}")
  @summary("Get rollout metadata")
  getRollout is RleOperation<
    {
      /** Canonical rollout identifier. */
      @path rolloutId: string;
    },
    RleRolloutDetail
  >;

  /** Read the retained result JSON. Returns 404 when the rollout is unknown,
   * incomplete, not stored or expired; durable metadata can outlive the result.
   */
  @get
  @route("/rollouts/{rolloutId}/result")
  @summary("Get the retained rollout result")
  getRolloutResult is RleOperation<
    {
      /** Canonical rollout identifier. */
      @path rolloutId: string;
    },
    {
      /** Producer-defined persisted result JSON. */
      @body body: unknown;
    }
  >;

  /** List producer-defined events; returns 404 for an unknown rollout and 400
   * for invalid pagination.
   */
  @get
  @list
  @route("/rollouts/{rolloutId}/events")
  @summary("List rollout events")
  listRolloutEvents is RleOperation<
    {
      /** Canonical rollout identifier. */
      @path rolloutId: string;

      ...RlePageParameters;
    },
    RlePage<unknown>
  >;
}
