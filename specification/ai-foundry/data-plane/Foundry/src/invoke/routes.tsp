import "./models.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

// Helper alias for SSE response
alias SseResponse = {
  @statusCode statusCode: 200;
  @header contentType: "text/event-stream";
  @body body: string;
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Invoke operations follow OpenAI-style patterns"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Invoke operations are non-standard by design"
@route("invoke")
@tag("Invoke")
interface InvokeOperations {
  /**
   * Invoke an agent. Response is always server-sent events (SSE).
   *
   * @param body The invocation request containing agent definition and input.
   * @param requestId Optional request ID for tracing.
   * @param traceparent Optional W3C trace context for distributed tracing.
   */
  @operationId("invoke")
  @post
  invoke(
    @body body: InvokeRequest,
    @header("X-Request-Id") requestId?: string,
    @header("traceparent") traceparent?: string,
  ): SseResponse | ApiErrorResponse;
}

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Health operations do not require versioning"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Health operations are non-standard by design"
@route("readiness")
@tag("Health")
interface HealthOperations {
  /**
   * Readiness probe for health monitoring.
   */
  @operationId("readiness")
  @get
  readiness(): {
    @statusCode statusCode: 200;
    @body body: ReadinessResponse;
  } | ApiErrorResponse;
}
