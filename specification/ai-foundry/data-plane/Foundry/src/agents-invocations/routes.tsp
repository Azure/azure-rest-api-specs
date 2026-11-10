import "../common/models.tsp";
import "../common/debug-latency-headers.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Invocations")
interface AgentInvocations {
  /**
   * Retrieves the OpenAPI specification for an agent version's invocation contract.
   * Returns 404 if the agent does not expose an OpenAPI specification.
   */
  @summary("Get an agent invocation OpenAPI spec")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/invocations/docs/openapi.json")
  getAgentInvocationOpenApiSpec is AgentDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;
    },
    {
      /** The content type of the request body. */
      @header contentType: "application/json";

      /** The invocation specification request body. */
      @body spec: Record<unknown>;
    }
  >;

  /**
   * Creates an invocation for the specified agent version.
   */
  @summary("Create an agent invocation")
  @post
  @route("/agents/{agent_name}/endpoint/protocols/invocations")
  createAgentInvocation is AgentDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** Optional session ID returned by the session CRUD APIs to reuse an existing sandbox. If not provided, a new session ID will be auto-generated. */
      @query agent_session_id?: string;

      /** The content type of the request body. */
      @header contentType: string;

      /** The request body. */
      @body request: unknown;

      ...UserDelegationHeader;
      ...DebugLatencyRequestHeader;
    },
    {
      ...DebugLatencyResponseHeaders;

      /** Unique identifier for this invocation. */
      @header("x-agent-invocation-id") invocationId: string;

      /** Session ID for this invocation. Returns the provided session ID or an auto-generated one if not provided in the request. */
      @header("x-agent-session-id") agentSessionId: string;

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
  @summary("Get an agent invocation")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/invocations/{invocation_id}")
  getAgentInvocation is AgentDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The unique identifier of the invocation. */
      @path invocation_id: string;

      ...UserDelegationHeader;
      ...DebugLatencyRequestHeader;
    },
    {
      ...PersistedDebugLatencyResponseHeaders;

      /** Session ID for this invocation. Returns the session ID associated with the invocation. */
      @header("x-agent-session-id") agentSessionId: string;

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
  @summary("Cancel an agent invocation")
  @post
  @route("/agents/{agent_name}/endpoint/protocols/invocations/{invocation_id}/cancel")
  cancelAgentInvocation is AgentDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The unique identifier of the invocation to cancel. */
      @path invocation_id: string;

      /** Optional content type of the request body. */
      @header contentType?: string;

      /** Optional request body. */
      @body request?: unknown;

      ...UserDelegationHeader;
    },
    {
      /** Session ID for this invocation. Returns the session ID associated with the invocation. */
      @header("x-agent-session-id") agentSessionId: string;

      /** The content type of the response body. */
      @header contentType: string;

      /** The response body. */
      @body response: unknown;
    }
  >;
}
