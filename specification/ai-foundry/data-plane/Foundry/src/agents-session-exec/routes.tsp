import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/**
 * Interactive command execution in an existing hosted agent session compute.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "A WebSocket protocol upgrade does not match a standard resource operation template."
@tag("Agent Session Exec")
@added(Versions.PuPr)
@removed(Versions.v1)
interface AgentSessionExec {
  /**
   * Opens a WebSocket connection to run one command in an existing hosted agent session compute.
   * The client sends an HTTP GET with WebSocket upgrade headers and requests the `exec.v1`
   * subprotocol. Authentication, authorization, session access, session state, and capacity
   * checks complete before the service returns `101 Switching Protocols`.
   *
   * The caller must have the
   * `Microsoft.CognitiveServices/accounts/AIServices/agents/endpoints/sessions/computes/exec/action`
   * data action and access to the target agent and session. The request must include
   * `Foundry-Features: SessionCompute=V1Preview` and use the enabled preview API version.
   * The current service contract uses `2025-11-15-preview`.
   * Non-browser clients authenticate with a Microsoft Entra bearer token. Browser clients
   * supply the bearer token as an additional `authorization.bearer.<token>` WebSocket
   * subprotocol; the service negotiates only `exec.v1`. Query-string bearer credentials
   * and API-key authentication are not supported. A native browser WebSocket cannot set
   * the required feature header; it needs an approved gateway or application adapter
   * that supplies that header while preserving caller authentication. The bearer
   * subprotocol alone does not provide the feature opt-in.
   *
   * After the upgrade, the client sends one `start` JSON text message, followed by optional
   * `stdin`, `resize`, or `close_stdin` messages. The service streams `stdout` and `stderr`
   * messages and sends an `exit_code` message before normal closure. Binary stream data
   * is base64-encoded in JSON messages. The connection owns the command and does not
   * support detach, reconnect, output replay, or automatic retry after execution may
   * have started. The existing compute must be running and ready, and its agent version
   * must opt in with `definition.compute_primitives.exec = true`. The current compute ID
   * is `default`; discover its `capabilities.exec` before connecting. This operation
   * does not create, resume, or restart a session or compute. A non-running compute
   * fails with `409 compute_not_ready`; an unsupported exec capability fails with
   * `400 compute_operation_not_supported`. Non-TTY stdin/EOF remains subject to runtime
   * qualification; the baseline non-TTY workflow uses `stdin: false`.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "A successful WebSocket 101 protocol switch has no HTTP entity body; messages are exchanged as WebSocket frames after the upgrade."
  @summary("Open a hosted agent session compute exec stream")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{agent_session_id}/computes/{compute_id}/exec/stream")
  openSessionExec is FoundryDataPlaneOperation<
    {
      /** The name of the hosted agent. */
      @path agent_name: string;

      /** The ID of an existing hosted agent session accessible to the caller. */
      @path agent_session_id: string;

      /** The ID of the existing running compute. The current service supports `default`. */
      @path compute_id: string;

      /**
       * Feature opt-ins for this request. Must include `SessionCompute=V1Preview`.
       * Other supported feature opt-ins may be included in the same header.
       */
      @header("Foundry-Features")
      foundry_features: string;

      /**
       * The requested WebSocket subprotocols. Include `exec.v1`. Browser clients also
       * include `authorization.bearer.<token>` to authenticate; this credential is
       * never returned in the negotiated subprotocol.
       */
      @header("Sec-WebSocket-Protocol")
      @secret
      websocket_subprotocol: string;
    },
    {
      /** The successful WebSocket protocol switch. */
      @statusCode status_code: 101;

      /** The negotiated application subprotocol, excluding any bearer credential. */
      @header("Sec-WebSocket-Protocol")
      websocket_subprotocol: "exec.v1";
    }
  >;
}
