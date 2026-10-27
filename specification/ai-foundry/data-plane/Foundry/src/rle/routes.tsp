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

/** Environment publication, execution, manual runtime capacity and monitoring. */
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

  /** Execute a scored rollout with an exact release. Returns 400 for invalid
   * policy/task/harness, 403 when disabled, 404 for a missing release, and 409
   * for an already-reserved rollout ID. A submitted timeout has an unknown
   * outcome; never automatically replay. Dependency failures return 500 with
   * attribution and retryability, not an instruction to reuse the rollout ID.
   */
  @post
  @route("/{name}/versions/{version}:executeRollout")
  @summary("Execute one rollout")
  @extension(
    "x-ms-examples",
    #{
      `Evaluate one task using a project model deployment`: #{
        $ref: "../../examples/v1/rle/ExecuteRollout.json",
      },
      `Evaluate a published Harbor task`: #{
        $ref: "../../examples/v1/rle/ExecuteHarborRollout.json",
      },
    }
  )
  executeRollout is RleOperation<
    {
      ...RleVersionPath;

      /** Task, model policy and correlation identity. */
      @body body: RleExecuteRolloutContent;
    },
    RleRolloutResult
  >;

  /** Backend-native rollout route with the same execution and one-shot identity
   * semantics as executeRollout. Project gateway publication must be qualified.
   */
  @post
  @route("/{name}/versions/{version}/rollout")
  @summary("Execute one rollout through the native route")
  executeRolloutNative is RleOperation<
    {
      ...RleVersionPath;

      /** Task, model policy and correlation identity. */
      @body body: RleExecuteRolloutContent;
    },
    RleRolloutResult
  >;

  /** Reserve manual execution capacity for an exact release. Returns 400 when
   * its image is not ready, 404 for a missing release, 429 for quota exhaustion,
   * and 503 when capacity admission is unavailable.
   */
  @post
  @route("/{name}/versions/{version}/instance_groups")
  @summary("Create an instance group")
  createInstanceGroup is RleOperation<
    {
      ...RleVersionPath;

      /** Capacity and advisory resource requirements. */
      @body body: RleCreateInstanceGroupContent;
    },
    {
      /** Group registered. */
      @statusCode statusCode: 201;

      /** URI of the group. */
      @header("Location") location: string;

      /** Registered capacity reservation. */
      @body body: RleInstanceGroup;
    }
  >;

  /** List groups for an exact release; invalid paging returns 400. */
  @get
  @list
  @route("/{name}/versions/{version}/instance_groups")
  @summary("List instance groups")
  listInstanceGroups is RleOperation<
    {
      ...RleVersionPath;
      ...RlePageParameters;
      ...RleOrderParameter;
    },
    RlePage<RleInstanceGroup>
  >;

  /** Read a capacity reservation; returns 404 when absent. */
  @get
  @route("/{name}/versions/{version}/instance_groups/{instanceGroupId}")
  @summary("Get an instance group")
  getInstanceGroup is RleOperation<
    {
      ...RleVersionPath;

      /** Group identifier. */
      @path instanceGroupId: string;
    },
    RleInstanceGroup
  >;

  /** Delete a group and release its runtime resources; returns 404 when absent. */
  @delete
  @route("/{name}/versions/{version}/instance_groups/{instanceGroupId}")
  @summary("Delete an instance group")
  deleteInstanceGroup is RleOperation<
    {
      ...RleVersionPath;

      /** Group identifier. */
      @path instanceGroupId: string;
    },
    NoContentResponse
  >;

  /** Acquire an instance. Returns 409 when the image is not ready and 429 with
   * Retry-After and capacity counts when the group is full. A 201 response can
   * describe a still-provisioning runtime; readiness is read through getInstance.
   */
  @post
  @route("/{name}/versions/{version}/instance_groups/{instanceGroupId}/instances")
  @summary("Create an instance")
  createInstance is RleOperation<
    {
      ...RleVersionPath;

      /** Group identifier. */
      @path instanceGroupId: string;
    },
    {
      /** Instance allocated. */
      @statusCode statusCode: 201;

      /** Runtime readiness and routing details. */
      @body body: RleInstance;
    }
  >;

  /** Read instance readiness; returns 404 when absent. */
  @get
  @route("/{name}/versions/{version}/instance_groups/{instanceGroupId}/instances/{instanceId}")
  @summary("Get an instance")
  getInstance is RleOperation<
    {
      ...RleVersionPath;

      /** Group identifier. */
      @path instanceGroupId: string;

      /** Instance identifier. */
      @path instanceId: string;
    },
    RleInstance
  >;

  /** Release a leased instance; returns 404 when absent. */
  @delete
  @route("/{name}/versions/{version}/instance_groups/{instanceGroupId}/instances/{instanceId}")
  @summary("Delete an instance")
  deleteInstance is RleOperation<
    {
      ...RleVersionPath;

      /** Group identifier. */
      @path instanceGroupId: string;

      /** Instance identifier. */
      @path instanceId: string;
    },
    NoContentResponse
  >;

  /** Create a group by resolving the latest version once at registration.
   * The returned group remains pinned to that resolved version.
   */
  @post
  @route("/{name}/instance_groups")
  @summary("Create an instance group for the latest version")
  createInstanceGroupForLatestVersion is RleOperation<
    {
      /** Environment name. */
      @path name: string;

      /** Capacity and advisory resource requirements. */
      @body body: RleCreateInstanceGroupContent;
    },
    {
      /** Group registered. */
      @statusCode statusCode: 201;

      /** URI of the group. */
      @header("Location") location: string;

      /** Group with its resolved immutable version. */
      @body body: RleInstanceGroup;
    }
  >;

  /** List groups addressed by environment name; invalid paging returns 400. */
  @get
  @list
  @route("/{name}/instance_groups")
  @summary("List instance groups by environment")
  listInstanceGroupsByEnvironment is RleOperation<
    {
      /** Environment name. */
      @path name: string;

      ...RlePageParameters;
      ...RleOrderParameter;
    },
    RlePage<RleInstanceGroup>
  >;

  /** Get a group's pinned version and capacity; returns 404 when absent. */
  @get
  @route("/{name}/instance_groups/{instanceGroupId}")
  @summary("Get an instance group by environment")
  getInstanceGroupByEnvironment is RleOperation<
    {
      /** Environment name. */
      @path name: string;

      /** Group identifier. */
      @path instanceGroupId: string;
    },
    RleInstanceGroup
  >;

  /** Delete a group through its environment-name alias; returns 404 when absent. */
  @delete
  @route("/{name}/instance_groups/{instanceGroupId}")
  @summary("Delete an instance group by environment")
  deleteInstanceGroupByEnvironment is RleOperation<
    {
      /** Environment name. */
      @path name: string;

      /** Group identifier. */
      @path instanceGroupId: string;
    },
    NoContentResponse
  >;

  /** Acquire an instance using the group's pinned version. Returns 429 with
   * Retry-After when full and 409 when its environment is not ready.
   */
  @post
  @route("/{name}/instance_groups/{instanceGroupId}/instances")
  @summary("Create an instance by environment")
  createInstanceByEnvironment is RleOperation<
    {
      /** Environment name. */
      @path name: string;

      /** Group identifier. */
      @path instanceGroupId: string;
    },
    {
      /** Instance allocated, possibly still provisioning. */
      @statusCode statusCode: 201;

      /** Runtime status. */
      @body body: RleInstance;
    }
  >;

  /** Read an instance through its environment-name alias; returns 404 when absent. */
  @get
  @route("/{name}/instance_groups/{instanceGroupId}/instances/{instanceId}")
  @summary("Get an instance by environment")
  getInstanceByEnvironment is RleOperation<
    {
      /** Environment name. */
      @path name: string;

      /** Group identifier. */
      @path instanceGroupId: string;

      /** Instance identifier. */
      @path instanceId: string;
    },
    RleInstance
  >;

  /** Release an instance through its environment-name alias; returns 404 when absent. */
  @delete
  @route("/{name}/instance_groups/{instanceGroupId}/instances/{instanceId}")
  @summary("Delete an instance by environment")
  deleteInstanceByEnvironment is RleOperation<
    {
      /** Environment name. */
      @path name: string;

      /** Group identifier. */
      @path instanceGroupId: string;

      /** Instance identifier. */
      @path instanceId: string;
    },
    NoContentResponse
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
