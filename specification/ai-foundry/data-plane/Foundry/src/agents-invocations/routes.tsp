import "../common/models.tsp";

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
  getAgentInvocationOpenApiSpec is FoundryDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;
    },
    {
      @header contentType: "application/json";
      @body spec: Record<unknown>;
    }
  >;

  /**
   * Creates an invocation for the specified agent version.
   */
  @summary("Create an agent invocation")
  @post
  @route("/agents/{agent_name}/endpoint/protocols/invocations")
  createAgentInvocation is FoundryDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** Optional session ID returned by the session CRUD APIs to reuse an existing sandbox. If not provided, a new session ID will be auto-generated. */
      @query agent_session_id?: string;

      /** The content type of the request body. */
      @header contentType: string;

      /** The request body. */
      @body request: unknown;

      ...UserIsolationKeyHeader;
    },
    {
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
  getAgentInvocation is FoundryDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The unique identifier of the invocation. */
      @path invocation_id: string;

      ...UserIsolationKeyHeader;
    },
    {
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
  cancelAgentInvocation is FoundryDataPlaneOperation<
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The unique identifier of the invocation to cancel. */
      @path invocation_id: string;

      /** Optional content type of the request body. */
      @header contentType?: string;

      /** Optional request body. */
      @body request?: unknown;

      ...UserIsolationKeyHeader;
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
