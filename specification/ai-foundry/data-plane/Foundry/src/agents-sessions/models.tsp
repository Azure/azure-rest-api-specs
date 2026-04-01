import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/**
 * Known SSE event types emitted by the hosted agent session log stream.
 * Additional event types may be introduced in future versions.
 */
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.hosted_agents_v1_preview] }
)
union SessionLogEventType {
  string,

  @doc("A log line from the agent session container.")
  log: "log",
}

/**
 * A single Server-Sent Event frame emitted by the hosted agent session log stream.
 *
 * Each frame contains an `event` field identifying the event type and a `data`
 * field carrying the payload as plain text. Although the current `data` payload
 * is JSON-formatted, its schema is not contractual — additional keys may appear
 * and the format may change over time. Clients should treat `data` as an
 * opaque string and optionally attempt JSON parsing.
 *
 * New event types may be added in the future. Clients should gracefully
 * ignore unrecognized event types.
 *
 * Wire format:
 * ```
 * event: log
 * data: {"timestamp":"2026-03-10T09:33:17.121Z","stream":"stdout","message":"Starting server on port 18080"}
 *
 * event: log
 * data: {"timestamp":"2026-03-10T09:34:52.714Z","stream":"status","message":"Successfully connected to container"}
 * ```
 */
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[AgentDefinitionOptInKeys.hosted_agents_v1_preview] }
)
model SessionLogEvent {
  @doc("The SSE event type. Currently `log`, but additional event types may be added in the future. Clients should ignore unrecognized event types.")
  @example("log")
  event: SessionLogEventType;

  @doc("The event payload as plain text. Currently JSON-formatted but the schema is not contractual and may change.")
  @example("{\"timestamp\":\"2026-03-10T09:33:17.121467567+00:00\",\"stream\":\"stdout\",\"message\":\"Starting server on port 18080\"}")
  data: string;
}
