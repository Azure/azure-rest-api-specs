import "../common/servicepatterns.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

/** Project-scoped environment registration with an immutable version. */
model RleCreateEnvironmentContent {
  /** Environment name; omitted to let the service allocate a name. */
  name?: string;

  /** ACR image reference; required unless tasks provide their own images. */
  acrImagePath?: string;

  /** Exact semantic version. Mutually exclusive with versionBump. */
  version?: string;

  /** Semantic version component to increment when version is omitted. */
  versionBump?: RleVersionBump;

  /** Callable harness; defaults to Gym when omitted. */
  harness?: RleHarnessConfiguration;

  /** Task encoding; defaults to JSON when omitted. */
  task?: RleTaskConfiguration;

  /** Tasks packaged with a Harbor environment version. */
  tasks?: RleHarborTaskInput[];

  /** Manifest configuration schema version. */
  schema_version?: string;

  /** Reusable model selection and renderer settings. */
  `model`?: RleModelDefaults;

  /** Reusable training-loop settings. */
  train?: RleTrainDefaults;

  /** Reusable rollout-loop settings. */
  rollout?: RleRolloutDefaults;
}

/** Semantic version allocation choices accepted by registration. */
union RleVersionBump {
  string,

  /** Increment the major component. */
  Major: "Major",

  /** Increment the minor component. */
  Minor: "Minor",

  /** Increment the patch component. */
  Patch: "Patch",
}

/** An immutable registered environment version. */
model RleEnvironment {
  /** Service-assigned environment version identifier. */
  id: string;

  /** Owning project identifier. */
  projectId: string;

  /** Environment name. */
  name: string;

  /** Environment image reference; task environments use per-task images. */
  acrImagePath: string;

  /** Immutable semantic version. */
  version: string;

  /** Callable harness configuration. */
  harness: RleHarnessConfiguration;

  /** Task encoding. */
  task: RleTaskConfiguration;

  /** Manifest configuration schema version, if supplied. */
  schema_version?: string | null;

  /** Model defaults, if supplied. */
  `model`?: RleModelDefaults | null;

  /** Training-loop defaults, if supplied. */
  train?: RleTrainDefaults | null;

  /** Rollout-loop defaults, if supplied. */
  rollout?: RleRolloutDefaults | null;

  /** Image readiness; absent for environments with per-task images. */
  diskImageConversionStatus?: RleImageConversionStatus;

  /** Image conversion failure detail, otherwise null. */
  diskImageConversionError?: string | null;

  /** UTC creation timestamp. */
  createdAtUtc: utcDateTime;

  /** UTC last-update timestamp. */
  updatedAtUtc: utcDateTime;
}

/** Image conversion states; registration does not wait for readiness. */
union RleImageConversionStatus {
  string,

  /** Image conversion has not completed. */
  Pending: "Pending",

  /** The converted image is available for execution. */
  Ready: "Ready",

  /** Image conversion failed. */
  Failed: "Failed",
}

/** Selection of the component that drives the model-and-tool loop.
 * Endpoint and protocol apply only to byoh; name applies only to package.
 * For responses, endpoint is a same-project /agents/{agentName} base URL.
 * The service appends the Responses protocol route.
 */
model RleHarnessConfiguration {
  /** Harness type; defaults to gym. */
  type?: RleHarnessType;

  /** Package name for a package harness. */
  name?: string;

  /** HTTPS invocation endpoint or same-project Hosted Agent base URL. */
  endpoint?: url;

  /** BYOH protocol; responses or rle-invocation. */
  protocol?: RleHarnessProtocol;
}

/** Supported harness selections. */
union RleHarnessType {
  string,

  /** RLE drives the OpenEnv model-and-tool loop. */
  Gym: "gym",

  /** A customer agent drives the loop. */
  Byoh: "byoh",

  /** A named harness package drives the loop. */
  Package: "package",
}

/** Protocols used to invoke an existing agent. */
union RleHarnessProtocol {
  string,

  /** Responses protocol for a same-project Foundry Hosted Agent. */
  Responses: "responses",

  /** RLE's HTTPS invocation and polling protocol. */
  RleInvocation: "rle-invocation",
}

/** Encoding of tasks supplied to the environment. */
model RleTaskConfiguration {
  /** Opaque JSON or a published Harbor task name; defaults to json. */
  format?: RleTaskFormat;
}

/** Supported task encodings. */
union RleTaskFormat {
  string,

  /** Environment-defined JSON reset payload. */
  Json: "json",

  /** A task directory packaged with the environment. */
  Harbor: "harbor",
}

/** Content-addressed Harbor task archive. */
model RleTaskBundle {
  /** Project storage path of the task archive. */
  path: string;

  /** Archive SHA-256 digest. */
  sha256: string;
}

/** Request a project-scoped upload target for a task archive. */
model RleHarborUploadUrlContent {
  /** Lowercase SHA-256 digest of the complete compressed archive. */
  @pattern("^[0-9a-f]{64}$")
  sha256: string;
}

/** Validate a staged archive and publish its content-addressed bundle. */
model RleHarborFinalizeUploadContent {
  ...RleHarborUploadUrlContent;

  /** Staging path returned for this digest by the upload-target operation. */
  @pattern("^task-data/staging/[0-9a-f]{64}-[0-9a-f]{32}\\.tar\\.gz$")
  stagingPath: string;
}

/** Project storage target; an existing bundle needs no upload or finalization. */
model RleHarborUploadTarget {
  /** Content-addressed path used in environment registration. */
  path: string;

  /** Whether the verified bundle already exists in this project. */
  exists: boolean;

  /** Per-attempt staging path; null when the bundle already exists. */
  stagingPath?: string | null;

  /** Short-lived signed write URL. Treat as a credential; never log it. */
  @Azure.ClientGenerator.Core.clientName("uploadUri", "csharp")
  uploadUrl?: url | null;

  /** Signed URL expiry, normally fifteen minutes after issue. */
  expiresOn?: utcDateTime | null;

  /** Maximum compressed bundle size in bytes; currently 64 MiB. */
  maxBytes: int64;
}

/** Empty response when environment or execution feature access is unavailable. */
@error
model RleHarborFeatureUnavailable {
  /** Harbor is not enabled for this project. */
  @statusCode statusCode: 404;
}

/** A task published with an environment version. */
model RleHarborTaskInput {
  /** Task name, unique within this environment version. */
  name: string;

  /** ACR image built from the task environment. */
  acrImagePath: string;

  /** Content-addressed task archive reference. */
  bundle: RleTaskBundle;
}

/** Published task with its conversion state. */
model RleHarborTask {
  ...RleHarborTaskInput;

  /** Converted disk image identifier, when allocated. */
  diskImageId?: string;

  /** Current conversion state. */
  diskImageConversionStatus: RleImageConversionStatus;

  /** Conversion failure detail, when present. */
  diskImageConversionError?: string;
}

/** Reusable model and renderer selection. */
model RleModelDefaults {
  /** Training model name supported by the project. */
  name?: string;

  /** Capture renderer compatible with the model. */
  renderer_name?: string;
}

/** Training-loop recipe configuration. */
model RleTrainDefaults {
  /** GRPO recipe settings. */
  grpo?: RleGrpoDefaults;
}

/** GRPO optimization-loop defaults. */
model RleGrpoDefaults {
  /** Optimizer learning rate. */
  learning_rate?: float64;

  /** Rollouts sampled per group. */
  group_size?: int32;

  /** Groups consumed per training batch. */
  groups_per_batch?: int32;

  /** LoRA adapter rank. */
  lora_rank?: int32;

  /** Dataset epochs. */
  num_epochs?: int32;

  /** Optional maximum training steps. */
  max_steps?: int32;

  /** Evaluation interval in training steps. */
  eval_every?: int32;

  /** Checkpoint interval in training steps. */
  save_every?: int32;

  /** Whether constant-reward groups are excluded. */
  remove_constant_reward_groups?: boolean;

  /** Random sampling seed. */
  sampling_seed?: int32;

  /** Minimum trainable members required per group. */
  min_trainable_group_members?: int32;
}

/** Rollout-loop configuration. */
model RleRolloutDefaults {
  /** Gym/OpenEnv action mapping. */
  gym_openenv?: RleGymOpenEnvDefaults;
}

/** Mapping between model output and the environment's action model. */
model RleGymOpenEnvDefaults {
  /** Action property that receives the model completion verbatim. */
  model_response_field?: string;
}

/** A page using the service's opaque continuation-token contract. */
model RlePage<Item> {
  /** Items in this page. */
  @pageItems data: Item[];

  /** Opaque token for the next page, or null at the end. */
  @continuationToken nextContinuationToken?: string | null;
}

/** Paging parameters; tokens must not be interpreted by the client. */
model RlePageParameters {
  /** Maximum items in this page; default 100, maximum 100. */
  @query
  @pageSize
  @minValue(1)
  @maxValue(100)
  limit?: int32;

  /** Token from a previous page. */
  @query @continuationToken continuationToken?: string;
}

/** Ordering for collections that support ascending and descending iteration. */
model RleOrderParameter {
  /** Sort direction; defaults to descending. */
  @query order?: RlePaginationOrder;
}

/** Collection sort directions. */
union RlePaginationOrder {
  string,

  /** Ascending order. */
  Ascending: "asc",

  /** Descending order. */
  Descending: "desc",
}

/** An immutable environment version path. */
model RleVersionPath {
  /** Environment name. */
  @path name: string;

  /** Immutable semantic version, in major.minor.patch form. */
  @path version: string;
}

/** Advisory resource requirements for leased runtime instances. */
model RleResourceProfile {
  /** CPU resource hint. */
  cpu?: string | null;

  /** Memory resource hint. */
  memory?: string | null;

  /** Disk resource hint. */
  disk?: string | null;
}

/** Capacity reservation for manual OpenEnv episode control. */
model RleCreateInstanceGroupContent {
  /** Maximum simultaneously active instances; defaults to one. */
  @minValue(1) maxActiveInstances?: int32;

  /** Caller metadata. */
  metadata?: Record<string>;

  /** Advisory resource hints. */
  resourceProfile?: RleResourceProfile;
}

/** A project-owned group pinned to one environment version. */
model RleInstanceGroup {
  /** Group identifier. */
  id: string;

  /** Owning project identifier. */
  projectId: string;

  /** Registered environment name. */
  environmentName: string;

  /** Resolved immutable version. */
  environmentVersion: string;

  /** Maximum simultaneously active instances. */
  maxActiveInstances: int32;

  /** Caller metadata. */
  metadata?: Record<string> | null;

  /** Advisory resource hints. */
  resourceProfile?: RleResourceProfile | null;

  /** UTC creation timestamp. */
  createdAtUtc: utcDateTime;

  /** UTC last-update timestamp. */
  updatedAtUtc: utcDateTime;
}

/** One runtime leased from an instance group. */
model RleInstance {
  /** Instance identifier. */
  instanceId: string;

  /** Owning group identifier. */
  instanceGroupId: string;

  /** Runtime lifecycle state. */
  status: RleInstanceStatus;

  /** Runtime base URL, if available. */
  @Azure.ClientGenerator.Core.clientName("baseUri", "csharp")
  baseUrl?: string | null;

  /** Runtime failure detail, if present. */
  error?: string | null;

  /** UTC creation timestamp. */
  createdAtUtc: utcDateTime;

  /** UTC last-update timestamp. */
  updatedAtUtc: utcDateTime;
}

/** Runtime states returned by the service. */
union RleInstanceStatus {
  string,

  /** Runtime provisioning is in progress. */
  Creating: "Creating",

  /** Runtime is ready for requests. */
  Running: "Running",

  /** Runtime is stopped. */
  Stopped: "Stopped",

  /** Runtime failed. */
  Failed: "Failed",

  /** Runtime was deleted. */
  Deleted: "Deleted",
}

/** Machine-readable RLE failure; management and execution share code/message. */
@error
model RleError {
  /** Stable error code. */
  code: string;

  /** Human-readable description. */
  message: string;

  /** Failed upstream component, when attributable. */
  dependency?: string;

  /** Failed upstream operation, when attributable. */
  operation?: string;

  /** Upstream HTTP status, when applicable. */
  upstream_status?: int32;

  /** Whether a new attempt may be worthwhile; not permission to replay the same rollout ID. */
  retryable?: boolean;

  /** Opt-in, bounded and redacted upstream wording. */
  diagnostic?: string;

  /** Opt-in, bounded and redacted exception details. */
  exception?: string;

  /** Active instances when a group is at capacity. */
  activeInstanceCount?: int32;

  /** Group capacity when a group is at capacity. */
  maxActiveInstances?: int32;

  /** Suggested delay in seconds for capacity errors. */
  retryAfterSeconds?: int32;
}

/** Failure payloads returned by the existing environment input validators. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "The implemented primitive validation message and structured error do not share a model base."
union RleErrorBody {
  /** Structured management, execution or capacity error. */
  Structured: RleError,

  /** Plain validation message emitted by environment registration/version checks. */
  Validation: string,
}

/** Error response, including validation strings emitted by management endpoints. */
@error
model RleErrorResult {
  /** Retry delay in seconds, when returned for capacity exhaustion. */
  @header("Retry-After") retryAfter?: string;

  /** Client-safe error; some environment input validation returns a string. */
  @body body: RleErrorBody;
}

/** An RLE job's durable status and caller-defined metadata. */
model RleJob {
  /** Job identifier. */
  id: string;

  /** Current status. */
  status: string;

  /** Caller-defined metadata envelope. */
  metadata: unknown;
}

/** Durable rollout metadata returned by monitoring. */
model RleRolloutSummary {
  /** Rollout identifier. */
  rollout_id: string;

  /** Owning job identifier, when associated. */
  job_id?: string;

  /** Registered environment name. */
  environment_name: string;

  /** Immutable environment version. */
  environment_version: string;

  /** UTC admission timestamp. */
  created_at_utc: utcDateTime;

  /** Sampler sequence identifier. */
  sequence_id?: int64;

  /** Loom session identifier. */
  session_id?: string;

  /** Sampler checkpoint identifier. */
  checkpoint_id?: string;

  /** Effective execution status. */
  status: string;

  /** Persisted reward, if available. */
  reward?: float64;

  /** Persisted verdict, if available. */
  success?: boolean;

  /** Execution latency in seconds, if terminal. */
  latency_s?: float64;

  /** Whether a retained graph can be read now. */
  has_graph: boolean;

  /** UTC result-storage timestamp, if stored. */
  saved_at?: utcDateTime;

  /** Whether the retained result is currently available. */
  result_available: boolean;
}

/** Rollout detail includes a terminal timestamp when execution has ended. */
model RleRolloutDetail {
  ...RleRolloutSummary;

  /** UTC terminal timestamp. */
  terminal_at_utc?: utcDateTime;
}
