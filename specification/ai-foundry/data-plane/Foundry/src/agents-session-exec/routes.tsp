import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/**
 * Session-scoped command execution in an existing hosted agent sandbox.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "A WebSocket protocol upgrade does not match a standard resource operation template."
@tag("Agent Session Exec")
@added(Versions.PuPr)
@removed(Versions.v1)
interface AgentSessionExec {
  /**
   * Opens a WebSocket connection to run one command in an existing hosted agent session.
   * The client sends an HTTP GET with WebSocket upgrade headers and requests the `exec.v1`
   * subprotocol. Authentication, authorization, session access, session state, and capacity
   * checks complete before the service returns `101 Switching Protocols`.
   *
   * The caller must have endpoint action access and the
   * `Microsoft.CognitiveServices/accounts/AIServices/agents/session/exec/action` data action.
   * Non-browser clients authenticate with a Microsoft Entra bearer token. Browser clients
   * supply the bearer token as an additional `authorization.bearer.<token>` WebSocket
   * subprotocol; the service negotiates only `exec.v1`. Query-string bearer credentials
   * and API-key authentication are not supported.
   *
   * After the upgrade, the client sends one `start` JSON text message, followed by optional
   * `stdin`, `resize`, or `close_stdin` messages. The service streams `stdout` and `stderr`
   * messages and sends an `exit_code` message before normal closure. Binary stream data
   * is base64-encoded in JSON messages. The connection owns the command and does not
   * support detach, reconnect, output replay, or automatic retry after execution may
   * have started. This operation does not create a session or restart a user-stopped session.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "A successful WebSocket 101 protocol switch has no HTTP entity body; messages are exchanged as WebSocket frames after the upgrade."
  @summary("Open a hosted agent session exec stream")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{agent_session_id}/exec/stream")
  openSessionExec is FoundryDataPlaneOperation<
    {
      /** The name of the hosted agent. */
      @path agent_name: string;

      /** The ID of an existing hosted agent session accessible to the caller. */
      @path agent_session_id: string;

      /**
       * The requested WebSocket subprotocols. Include `exec.v1`. Browser clients also
       * include `authorization.bearer.<token>` to authenticate; this credential is
       * never returned in the negotiated subprotocol.
       */
      @header("Sec-WebSocket-Protocol")
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
