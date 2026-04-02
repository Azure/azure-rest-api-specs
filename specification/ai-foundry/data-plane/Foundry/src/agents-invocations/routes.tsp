import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias AgentInvocationPreviewHeader = WithRequiredFoundryPreviewHeader<AgentDefinitionOptInKeys.hosted_agents_v1_preview>;

const AgentInvocationRequiredPreviews = #{
  required_previews: #[AgentDefinitionOptInKeys.hosted_agents_v1_preview],
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Invocations")
@removed(Versions.v1)
interface AgentInvocations {
  /**
   * Retrieves the OpenAPI specification for an agent version's invocation contract.
   * Returns 404 if the agent does not expose an OpenAPI specification.
   */
  @get
  @route("/agents/{agent_name}/versions/{agent_version}/invocations/docs/openapi.json")
  @extension("x-ms-foundry-meta", AgentInvocationRequiredPreviews)
  getAgentInvocationOpenApiSpec is FoundryDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;
    } & AgentInvocationPreviewHeader,
    {
      @header contentType: "application/json";
      @body spec: Record<unknown>;
    }
  >;

  /**
   * Creates an invocation for the specified agent version.
   */
  @post
  @route("/agents/{agent_name}/versions/{agent_version}/invocations")
  @extension("x-ms-foundry-meta", AgentInvocationRequiredPreviews)
  createAgentInvocation is FoundryDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;

      /** Optional session ID to group related invocations. If not provided, a new session ID will be auto-generated. */
      @query agent_session_id?: string;

      /** The content type of the request body. */
      @header contentType: string;

      /** The request body. */
      @body request: unknown;
    } & AgentInvocationPreviewHeader,
    {
      /** Unique identifier for this invocation. */
      @header("x-agent-invocation-id") invocationId: string;

      /** Session ID for this invocation. Returns the provided session ID or an auto-generated one if not provided in the request. */
      @header("x-agent-session-id") sessionId: string;

      /** The content type of the response body. */
      @header contentType: string;

      /** The response body. */
      @body response: unknown;
    }
  >;

  /**
   * Retrieves the invocation with the given ID.
   * Returns 404 if the agent does not support this operation or if the invocation ID is not found.
   */
  @get
  @route("/agents/{agent_name}/versions/{agent_version}/invocations/{invocation_id}")
  @extension("x-ms-foundry-meta", AgentInvocationRequiredPreviews)
  getAgentInvocation is FoundryDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;

      /** The unique identifier of the invocation. */
      @path invocation_id: string;
    } & AgentInvocationPreviewHeader,
    {
      /** The content type of the response body. */
      @header contentType: string;

      /** The response body containing invocation status and result. */
      @body response: unknown;
    }
  >;

  /**
   * Cancels an invocation.
   * Returns 404 if the agent does not support this operation or if the invocation ID is not found.
   */
  @post
  @route("/agents/{agent_name}/versions/{agent_version}/invocations/{invocation_id}/cancel")
  @extension("x-ms-foundry-meta", AgentInvocationRequiredPreviews)
  cancelAgentInvocation is FoundryDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;

      /** The unique identifier of the invocation to cancel. */
      @path invocation_id: string;

      /** Optional content type of the request body. */
      @header contentType?: string;

      /** Optional request body. */
      @body request?: unknown;
    } & AgentInvocationPreviewHeader,
    {
      /** The content type of the response body. */
      @header contentType: string;

      /** The response body. */
      @body response: unknown;
    }
  >;
}
