import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias AgentWebsocketPreviewHeader = WithConditionalFoundryPreviewHeader<AgentDefinitionOptInKeys.hosted_agents_v1_preview>;

const AgentWebsocketRequiredPreviews = #{
  required_previews: #[AgentDefinitionOptInKeys.hosted_agents_v1_preview],
};

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
  @get
  @route("/agents/endpoint/protocols/invocations_ws")
  @extension("x-ms-foundry-meta", AgentWebsocketRequiredPreviews)
  connectEndpointWebsocket is FoundryDataPlaneOperation<
    {
      /** The name of the project. */
      @query("project-name") projectName: string;

      /** The name of the hosted agent. */
      @query("agent-name") agentName: string;

      /** Optional session/conversation ID. Pass the same value on a subsequent connection to reattach to an existing session. If not provided, the service auto-generates one. */
      @query agent_session_id?: string;

      /** AAD bearer token for browser clients only. The W3C WebSocket API cannot set custom headers, so browser callers may pass the AAD token via this query parameter. Non-browser clients should use the `Authorization` header instead. */
      @query authorization?: string;

      /** Preview feature flag, accepted as an alternative to the `Foundry-Features` header for browser clients that cannot set custom headers. Either this query parameter or the header must be supplied with the value `HostedAgents=V1Preview`. */
      @query("foundry-features")
      foundryFeaturesQuery?: AgentDefinitionOptInKeys.hosted_agents_v1_preview;
    } & AgentWebsocketPreviewHeader,
    {
      /** Session ID for this WebSocket connection. Returns the provided session ID or an auto-generated one if not provided in the request. */
      @header("x-agent-session-id") sessionId: string;

      /** The response body (101 Switching Protocols). */
      @body response: unknown;
    }
  >;
}
