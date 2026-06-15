import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Invocations WebSocket")
@removed(Versions.v1)
interface AgentWebsocket {
  /**
   * Establishes a WebSocket connection to a hosted agent. The target project and
   * agent are passed as query parameters. The service resolves (or creates) a
   * session, resolves the agent version, then relays text and binary frames
   * bidirectionally between the client and the agent (1 MB maximum frame size).
   *
   * The client must send an HTTP GET with `Upgrade: websocket` headers.
   */
  @summary("Establish a WebSocket connection to a hosted agent")
  @get
  @route("/agents/endpoint/protocols/invocations_ws")
  connectEndpointWebsocket is FoundryDataPlaneOperation<
    {
      /** The name of the project. */
      @query project_name: string;

      /** The name of the hosted agent. */
      @query agent_name: string;

      /** Optional session/conversation ID. Pass the same value on a subsequent connection to reattach to an existing session. If not provided, the service auto-generates one. */
      @query agent_session_id?: string;

      ...UserIsolationKeyHeader;
    },
    {
      /** Session ID for this WebSocket connection. Returns the provided session ID or an auto-generated one if not provided in the request. */
      @header("x-agent-session-id") sessionId: string;

      /** The response body (101 Switching Protocols). */
      @body response: unknown;
    }
  >;
}
