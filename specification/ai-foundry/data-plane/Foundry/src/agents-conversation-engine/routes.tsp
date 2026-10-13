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
   * Voice Live Bridge integration requires agent metadata `voiceLiveCompatible=true`. The declared
   * `conversation_engine` version `1.0.0` identifies the engine protocol; no separate Bridge-version
   * metadata is required. The Bridge message version `1.0` and Hosted Agents API version `v1` are
   * independent of the declared container protocol version.
   *
   * Voice Live owns audio, STT, TTS, turn detection, and interruption. The engine reuses the existing
   * Bridge Protocol 1.0 wire semantics. Voice Live sends `session.start` with `protocol_version: "1.0"`;
   * the engine acknowledges activation with `session.ready` or rejects it with `session.rejected`.
   * Caller input uses `user.message`. The engine opens a response with `response.created`, emits
   * `response.output_text.delta` and `response.output_text.done` for text or `response.output_data.done`
   * for non-audio structured output, and completes generation with `response.done`. `response.none`
   * consumes input without opening a response; failures use `error`.
   *
   * Messages carry envelope `id` and `ts` fields. Inputs and output items use `item_id`; responses use
   * `response_id`, and replies correlate consumed inputs through ordered-prefix `in_reply_to` values.
   * Voice Live reports interruption through `barge_in`, including `heard_text`. An engine-initiated
   * `response.cancel` is acknowledged by Voice Live with `response.cancelled` after playback stops.
   * Existing bounded-message, timeout, and proactive-response admission semantics are retained.
   *
   * Reconnection obtains fresh authentication and reattaches through the same `agent_session_id`, then
   * sends `session.start` with `reconnect: true` and waits for `session.ready`. In-flight response state
   * is abandoned, not replayed; there is no sequence acknowledgement or cursor-based recovery.
   * Audio transport is outside this contract. The service relays frames without changing their message
   * semantics; WebSocket close codes and ping/pong are preserved. Authorization, throttling, metrics,
   * and tracing are applied to the selected CE protocol.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "A successful WebSocket 101 upgrade has no HTTP entity body; messages follow as WebSocket frames."
  @summary("Connect to a hosted conversation engine")
  @opExample(
    #{
      parameters: #{
        apiVersion: "v1",
        agent_name: "support-conversation-engine",
      },
      returnType: #{ status_code: 101, session_id: "session_support_01" },
    },
    #{
      title: "NewSession",
      description: "Connects with the GA v1 API using a WebSocket upgrade request and no session ID. The 101 response returns an automatically generated x-agent-session-id header and no body.",
    }
  )
  @opExample(
    #{
      parameters: #{
        apiVersion: "v1",
        agent_name: "support-conversation-engine",
        agent_session_id: "session_support_01",
      },
      returnType: #{ status_code: 101, session_id: "session_support_01" },
    },
    #{
      title: "Reconnect",
      description: "Reconnects with the GA v1 API using a WebSocket upgrade request and an existing session ID. The 101 response returns the same x-agent-session-id header and no body.",
    }
  )
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
