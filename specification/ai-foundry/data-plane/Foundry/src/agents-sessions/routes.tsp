import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Sessions")
interface AgentSessions {
  /**
   * Streams console logs (stdout / stderr) for a specific hosted agent session
   * as a Server-Sent Events (SSE) stream.
   *
   * Each SSE frame contains:
   * - `event`: always `"log"`
   * - `data`: a plain-text log line (currently JSON-formatted, but the schema
   *   is not contractual and may include additional keys or change format
   *   over time — clients should treat it as an opaque string)
   *
   * Example SSE frames:
   * ```
   * event: log
   * data: {"timestamp":"2026-03-10T09:33:17.121Z","stream":"stdout","message":"Starting FoundryCBAgent server on port 8088"}
   *
   * event: log
   * data: {"timestamp":"2026-03-10T09:33:17.130Z","stream":"stderr","message":"INFO: Application startup complete."}
   *
   * event: log
   * data: {"timestamp":"2026-03-10T09:34:52.714Z","stream":"status","message":"Successfully connected to container"}
   *
   * event: log
   * data: {"timestamp":"2026-03-10T09:35:52.714Z","stream":"status","message":"No logs since last 60 seconds"}
   * ```
   *
   * The stream remains open until the client disconnects or the server
   * terminates the connection. Clients should handle reconnection as needed.
   */
  @get
  @route("/agents/{agent_name}/versions/{agent_version}/sessions/{session_id}:logstream")
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[AgentDefinitionOptInKeys.hosted_agents_v1_preview] }
  )
  getSessionLogStream is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.hosted_agents_v1_preview,
    {
      /** The name of the hosted agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;

      /** The session ID (maps to an ADC sandbox). */
      @path session_id: string;
    },
    SseResponseOf<SessionLogEvent>
  >;
}
