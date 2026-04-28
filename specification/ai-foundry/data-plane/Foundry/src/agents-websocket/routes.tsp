import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias AgentWebsocketPreviewHeader = WithRequiredFoundryPreviewHeader<AgentDefinitionOptInKeys.hosted_agents_v1_preview>;

const AgentWebsocketRequiredPreviews = #{
  required_previews: #[AgentDefinitionOptInKeys.hosted_agents_v1_preview],
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Websocket")
@removed(Versions.v1)
interface AgentWebsocket {
  /**
   * Establishes a WebSocket connection to the specified agent version.
   * The client must send an HTTP GET with `Upgrade: websocket` headers.
   * The service proxies the WebSocket upgrade to the agent container and relays frames bidirectionally.
   */
  @get
  @route("/agents/{agent_name}/versions/{agent_version}/ws")
  @extension("x-ms-foundry-meta", AgentWebsocketRequiredPreviews)
  connectAgentWebsocket is FoundryDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;

      /** Optional session ID to group related WebSocket connections. If not provided, a new session ID will be auto-generated. */
      @query agent_session_id?: string;
    } & AgentWebsocketPreviewHeader,
    {
      /** Session ID for this WebSocket connection. Returns the provided session ID or an auto-generated one if not provided in the request. */
      @header("x-agent-session-id") sessionId: string;

      /** The response body (101 Switching Protocols). */
      @body response: unknown;
    }
  >;
}
