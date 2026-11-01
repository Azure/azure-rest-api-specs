import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias SessionComputePreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.session_compute_v1_preview>;

// Request parameters shared by the port proxy operations. The proxy forwards the request to the
// application unchanged, so it takes no `api-version` query parameter.
alias SessionComputePortProxyParams = {
  ...SessionComputePortPathParams;
  ...SessionComputePreviewHeader;

  /** The application path appended to the port base URL. Forwarded exactly as encoded; dot segments and backslashes are rejected. */
  #suppress "@typespec/openapi3/path-reserved-expansion" "The proxied path is forwarded as-is and may contain '/'; OpenAPI 3 cannot express reserved expansion."
  @path path: string;
};

alias SessionComputePortProxyRequestBody = {
  /** The content type of the request body, forwarded to the application. */
  @header("Content-Type") contentType?: string;

  /** The request body, forwarded to the application. */
  @body body?: bytes;
};

// The proxied application response. Status, headers and body pass through unmodified.
alias SessionComputePortProxyResponse =
  | {
      /** The content type of the application response. */
      @header("Content-Type") contentType?: string;

      /** The application response body. */
      @body body: bytes;
    }
  | ApiErrorResponse;

/**
 * Compute primitives for hosted agent sessions: inspect, restart, run commands in, stream logs from,
 * expose ports of, and read policies of the compute behind a session.
 *
 * Every operation requires the `Foundry-Features: SessionCompute=V1Preview` header. Only the
 * `default` compute exists today. Exec and port operations also require the agent version to opt in
 * through `definition.compute_primitives`; check `capabilities` on the compute before calling them.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Session Computes")
@removed(Versions.v1)
interface AgentSessionComputes {
  /**
   * Lists the computes attached to a hosted agent session.
   */
  @summary("List computes attached to a session")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  listSessionComputes is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    {
      /** The name of the hosted agent. */
      @path agent_name: string;

      /** The session ID, as returned by the session create operation. */
      @path session_id: string;

      ...SessionComputePageQueryParameters;
    },
    SessionComputeList
  >;

  /**
   * Retrieves a compute attached to a hosted agent session.
   */
  @summary("Get a session compute")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  getSessionCompute is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    SessionComputePathParams,
    SessionCompute
  >;

  /**
   * Restarts a session compute: a session stop followed by a resume, addressed at the compute.
   * Session identity and files survive; in-memory process state does not. Exposed ports and the
   * lifecycle-policy override are instance-scoped and are dropped.
   */
  @summary("Restart a session compute")
  @post
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}:restart")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  restartSessionCompute is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    SessionComputePathParams,
    SessionCompute
  >;

  /**
   * Runs a one-shot shell command inside a session compute and returns its output.
   * Requires `capabilities.exec = true`.
   */
  @summary("Run a command in a session compute")
  @post
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}:exec")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  execSessionCompute is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    {
      ...SessionComputePathParams;

      /** The command to run. */
      @body body: SessionComputeExecRequest;
    },
    SessionComputeExecResult
  >;

  /**
   * Opens an interactive terminal inside a session compute over a WebSocket.
   * Requires `capabilities.exec = true`.
   *
   * The client must send an HTTP GET with `Upgrade: websocket` headers and
   * `Sec-WebSocket-Protocol: exec.v1`. A compute that is not `running` and ready is rejected
   * before upgrade with `409 compute_not_ready`. The stream is bound to the current instance;
   * stop, delete or replacement ends it, with no reconnect or replay.
   *
   * Client messages are JSON text frames with a `type` discriminator:
   * - `start` (first message, at most 64 KiB): `{ "type": "start", "start": { "command", "args", "tty", "stdin", "terminal_size"?, "environment"?, "working_directory"? } }`.
   * - `stdin`: `{ "type": "stdin", "data": "<base64>" }` (at most 1 MiB per message).
   * - `resize`: `{ "type": "resize", "height", "width" }` (TTY only).
   * - `close_stdin`: `{ "type": "close_stdin" }`.
   *
   * Server messages:
   * - `session_id`: `{ "type": "session_id", "session_id" }`.
   * - `stdout` / `stderr`: `{ "type": "stdout", "data": "<base64>" }`.
   * - `exit_code`: `{ "type": "exit_code", "exit_code" }`, followed by a normal close.
   * - `error`: `{ "type": "error", "error": { "code", "message" } }`.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "WebSocket upgrade; the exec.v1 messages flow over the upgraded connection."
  @summary("Open an interactive exec stream to a session compute")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/exec/stream")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  connectSessionComputeExecStream is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    {
      ...SessionComputePathParams;

      /** The WebSocket subprotocol. Must be `exec.v1`. */
      @header("Sec-WebSocket-Protocol") protocol: "exec.v1";
    },
    SessionComputeExecStreamUpgradeResponse
  >;

  /**
   * Streams the logs of a session compute as Server-Sent Events. Each line is emitted as
   * `event: log` / `data: <line>`. Errors are returned as a JSON error before the first byte of the
   * stream is written.
   */
  @summary("Stream logs from a session compute")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}:logstream")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  getSessionComputeLogStream is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    SessionComputePathParams,
    SseResponseOf<SessionComputeLogEvent>
  >;

  /**
   * Lists the ports exposed on a session compute. The platform control port is never included.
   */
  @summary("List exposed ports of a session compute")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/ports")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  listSessionComputePorts is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    {
      ...SessionComputePathParams;
      ...SessionComputePageQueryParameters;
    },
    SessionComputePortList
  >;

  /**
   * Exposes a port of a session compute through the Foundry proxy. Requires `capabilities.ports = true`.
   * Exposure is instance-scoped and must be repeated after a restart or replacement.
   */
  @summary("Expose a port of a session compute")
  @post
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/ports")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  exposeSessionComputePort is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    {
      ...SessionComputePathParams;

      /** The port to expose. */
      @body body: SessionComputePortRequest;
    },
    ResourceCreatedResponse<SessionComputePort>
  >;

  /**
   * Retrieves an exposed port of a session compute.
   */
  @summary("Get an exposed port of a session compute")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/ports/{port}")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  getSessionComputePort is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    SessionComputePortPathParams,
    SessionComputePort
  >;

  /**
   * Stops exposing a port of a session compute.
   */
  @summary("Stop exposing a port of a session compute")
  @delete
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/ports/{port}")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  unexposeSessionComputePort is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    SessionComputePortPathParams,
    NoContentResponse
  >;

  /**
   * Proxies a request to an application listening on an exposed port of a session compute.
   *
   * The proxy accepts every HTTP method (including HEAD, OPTIONS and TRACE), WebSocket upgrades and
   * SSE; the root of the application is also reachable at `.../ports/{port}/proxy`. Query strings,
   * application cookies, conditional headers, status codes and bodies pass through unmodified.
   * The caller's `Authorization` header and internal headers are removed before forwarding.
   * Applications must honor `X-Forwarded-Prefix`, `X-Forwarded-Host` and `X-Forwarded-Proto`.
   * Requires a running compute and the agent version ports opt-in; port 8088 is reserved.
   * The request body is limited to 256 MiB. The HTTP inactivity timeout is 100 seconds; WebSocket
   * and SSE requests use 300 seconds. Each connection has a maximum lifetime of 55 minutes.
   */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "The proxy forwards requests to the application unchanged and takes no api-version."
  @summary("Send a GET request to an exposed port of a session compute")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/ports/{port}/proxy/{+path}")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  getSessionComputePortProxy(
    ...SessionComputePortProxyParams,
  ): SessionComputePortProxyResponse;

  /**
   * Proxies a POST request to an application listening on an exposed port of a session compute.
   * See the GET proxy operation for behavior and limits.
   */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "The proxy forwards requests to the application unchanged and takes no api-version."
  @summary("Send a POST request to an exposed port of a session compute")
  @post
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/ports/{port}/proxy/{+path}")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  postSessionComputePortProxy(
    ...SessionComputePortProxyParams,
    ...SessionComputePortProxyRequestBody,
  ): SessionComputePortProxyResponse;

  /**
   * Proxies a PUT request to an application listening on an exposed port of a session compute.
   * See the GET proxy operation for behavior and limits.
   */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "The proxy forwards requests to the application unchanged and takes no api-version."
  @summary("Send a PUT request to an exposed port of a session compute")
  @put
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/ports/{port}/proxy/{+path}")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  putSessionComputePortProxy(
    ...SessionComputePortProxyParams,
    ...SessionComputePortProxyRequestBody,
  ): SessionComputePortProxyResponse;

  /**
   * Proxies a PATCH request to an application listening on an exposed port of a session compute.
   * See the GET proxy operation for behavior and limits.
   */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "The proxy forwards requests to the application unchanged and takes no api-version."
  @summary("Send a PATCH request to an exposed port of a session compute")
  @patch(#{ implicitOptionality: false })
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/ports/{port}/proxy/{+path}")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  patchSessionComputePortProxy(
    ...SessionComputePortProxyParams,
    ...SessionComputePortProxyRequestBody,
  ): SessionComputePortProxyResponse;

  /**
   * Proxies a DELETE request to an application listening on an exposed port of a session compute.
   * See the GET proxy operation for behavior and limits.
   */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "The proxy forwards requests to the application unchanged and takes no api-version."
  @summary("Send a DELETE request to an exposed port of a session compute")
  @delete
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/ports/{port}/proxy/{+path}")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  deleteSessionComputePortProxy(
    ...SessionComputePortProxyParams,
  ): SessionComputePortProxyResponse;

  /**
   * Retrieves the effective lifecycle (idle and auto-suspend) policy of a session compute.
   */
  @summary("Get the lifecycle policy of a session compute")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/lifecycle-policy")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  getSessionComputeLifecyclePolicy is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    SessionComputePathParams,
    SessionComputeLifecyclePolicy
  >;

  /**
   * Overrides the idle timeout of a session compute. Requires `capabilities.lifecycle_policy_write = true`.
   * Only `idle_timeout_seconds` is writable, within `limits`. The override applies to this compute only
   * and does not change the agent definition.
   */
  @summary("Override the idle timeout of a session compute")
  @patch(#{ implicitOptionality: false })
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/lifecycle-policy")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  updateSessionComputeLifecyclePolicy is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    {
      ...SessionComputePathParams;

      /** The content type of the request body. */
      @header("Content-Type") contentType: "application/json";

      /** The lifecycle policy override. */
      @body body: SessionComputeLifecyclePolicyUpdate;
    },
    SessionComputeLifecyclePolicy
  >;

  /**
   * Retrieves a summary of the egress policy in force for a session compute. Rule patterns are never returned.
   */
  @summary("Get the egress policy of a session compute")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/egress-policy")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  getSessionComputeEgressPolicy is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    SessionComputePathParams,
    SessionComputeEgressPolicy
  >;
}
