import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/**
 * Compute primitives for hosted agent sessions: inspect, run commands in, stream logs from,
 * expose ports of, and read the egress policy of the compute behind a session.
 *
 * Every operation requires the `Foundry-Features: SessionCompute=V1Preview` header. Only the
 * `default` compute exists today. Exec and port operations also require the agent version to opt in
 * through `definition.compute_primitives`; check `capabilities` on the compute before calling them.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Session compute operations are custom actions (exec, logstream, port exposure) on a compute owned by the session, not standard resource lifecycle operations."
@tag("Agent Session Computes")
@removed(Versions.v1)
interface AgentSessionComputes {
  /**
   * Lists the computes attached to a hosted agent session.
   */
  @summary("List computes attached to a session")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes")
  @list
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  listSessionComputes is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    {
      /** The name of the hosted agent. */
      @path agent_name: string;

      /** The session ID, as returned by the session create operation. */
      @path session_id: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<SessionCompute>
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
  @list
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  listSessionComputePorts is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    {
      ...SessionComputePathParams;
      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<SessionComputePort>
  >;

  /**
   * Exposes a port of a session compute through the Foundry proxy. Requires `capabilities.ports = true`.
   * Idempotent: returns `201` when the port is newly exposed, `200` when it is already exposed with the
   * same configuration, and `409 compute_port_conflict` when it is already exposed with a different
   * configuration (delete it first to change it). Exposure is instance-scoped and must be repeated after
   * the session is stopped and resumed, or the instance is replaced.
   */
  @summary("Expose a port of a session compute")
  @put
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/computes/{compute_id}/ports/{port}")
  @extension("x-ms-foundry-meta", SessionComputeRequiredPreviews)
  exposeSessionComputePort is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    {
      ...SessionComputePortPathParams;

      /** The port configuration. */
      @body body: SessionComputePortRequest;
    },
    SessionComputePort | ResourceCreatedResponse<SessionComputePort>
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
  deleteSessionComputePort is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.session_compute_v1_preview,
    SessionComputePortPathParams,
    NoContentResponse
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
