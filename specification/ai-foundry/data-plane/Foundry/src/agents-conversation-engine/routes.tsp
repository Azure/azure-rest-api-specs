import "../common/models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "A WebSocket upgrade is not a standard resource operation."
@tag("Agent Conversation Engine")
interface AgentConversationEngine {
  /**
   * Establishes a WebSocket connection to a hosted conversational engine. The client must send an HTTP GET
   * with `Upgrade: websocket` headers. The target hosted agent must declare `conversation_engine` version
   * `1.0.0`. An `invocations_ws` declaration is neither required nor a fallback. Both protocols may be
   * declared independently during migration; this operation always selects `conversation_engine`.
   *
   * The service resolves or creates a hosted session and forwards the connection to
   * `ws://container:8088/conversation_engine` without rewriting the protocol path. The AgentServer SDK
   * exposes that container endpoint only when a Conversation Engine handler is registered.
   *
   * Voice Live owns audio, STT, TTS, turn detection, and interruption. The engine processes conversational
   * turns and streams text responses using the existing `invocations_ws` message semantics:
   * `session.start`, `session.ready`, `user.message`, `response.started`, `response.text.delta`,
   * `response.done`, `response.cancel`, `response.cancelled`, and `error`. Each turn carries a `turn_id`,
   * and ordered events carry sequence numbers. Version 1.0 supports one active response per session,
   * cancellation for interruption, bounded messages, and reconnection through `agent_session_id`.
   * Audio transport is not part of this contract. WebSocket close codes and ping/pong are preserved;
   * authorization, throttling, metrics, and tracing are applied to the selected CE protocol.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "A successful WebSocket 101 upgrade has no HTTP entity body; messages follow as WebSocket frames."
  @summary("Connect to a hosted conversation engine")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/conversation_engine")
  connectEndpointConversationEngine is FoundryDataPlaneOperation<
    {
      /** The name of the target hosted conversational engine in the current project. */
      @path agent_name: string;

      /** Optional hosted session ID. Supply the same ID to reconnect to an existing session; omit it to create a session with an automatically generated ID. */
      @query agent_session_id?: string;
    },
    {
      /** Switches the HTTP connection to the WebSocket protocol. */
      @statusCode status_code: 101;

      /** The resolved hosted session ID, either the supplied ID or an automatically generated one. */
      @header("x-agent-session-id") session_id: string;
    }
  >;
}
