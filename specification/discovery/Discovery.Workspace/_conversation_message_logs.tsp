import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./_conversation_message.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Discovery.DataPlane.Shared;

@versioned(Microsoft.Discovery.Workspace.Versions)
namespace Microsoft.Discovery.Workspace;

@added(Versions.`2025-07-01-preview`)
@removed(Versions.`2026-02-01-preview`)
@doc("Enumeration for log type.")
union LogType {
  @doc("Tool invocation log.")
  ToolInvocation: "ToolInvocation",

  @doc("Agent invocation log.")
  AgentInvocation: "AgentInvocation",

  @doc("Log event for generating a summary or output.")
  Generate: "Generate",

  string,
}

@added(Versions.`2025-07-01-preview`)
@removed(Versions.`2026-02-01-preview`)
@doc("Enumeration for tool type.")
union ToolType {
  @doc("Hosted tool.")
  Hosted: "Hosted",

  @doc("OpenAPI tool.")
  OpenAPI: "OpenAPI",

  @doc("Function tool.")
  Function: "Function",

  @doc("Built-in tool.")
  BuiltIn: "BuiltIn",

  @doc("Remote tool.")
  Remote: "Remote",

  string,
}

@added(Versions.`2025-07-01-preview`)
@removed(Versions.`2026-02-01-preview`)
@doc("Log level for a message log.")
union LogLevel {
  @doc("Information log level.")
  Information: "Information",

  string,
}

@added(Versions.`2025-07-01-preview`)
@removed(Versions.`2026-02-01-preview`)
@doc("Status of a log entry activity.")
union LogStatus {
  @doc("Activity is currently in progress.")
  InProgress: "in_progress",

  @doc("Activity was cancelled.")
  Cancelled: "cancelled",

  @doc("Activity failed to complete.")
  Failed: "failed",

  @doc("Activity completed successfully.")
  Completed: "completed",

  @doc("Activity expired before completion.")
  Expired: "expired",

  string,
}

@added(Versions.`2025-07-01-preview`)
@removed(Versions.`2026-02-01-preview`)
@doc("Indicates if a log entry represents an action.")
union IsAction {
  @doc("Log entry represents an action.")
  True: "true",

  @doc("Log entry does not represent an action.")
  False: "false",

  string,
}

@added(Versions.`2025-07-01-preview`)
@removed(Versions.`2026-02-01-preview`)
@doc("A copilot log related to a message.")
@resource("logs")
@parentResource(ConversationMessage)
model MessageLog {
  @doc("The Log name/key.")
  @visibility(Lifecycle.Read)
  @key("logName")
  name: string;

  @doc("The identifier of the conversation this log belongs to.")
  @visibility(Lifecycle.Read)
  conversationName: string;

  @doc("The identifier of the message this log is associated with.")
  @visibility(Lifecycle.Read)
  messageName: string;

  @doc("The timestamp of the log entry in ISO 8601 format.")
  @visibility(Lifecycle.Read)
  timestamp: string;

  @doc("The log level for this entry.")
  @visibility(Lifecycle.Read)
  logLevel: LogLevel;

  @doc("The type of activity for this log entry.")
  @visibility(Lifecycle.Read)
  type: LogType;

  @doc("The type of tool, if applicable.")
  @visibility(Lifecycle.Read)
  toolType?: ToolType;

  @doc("The name of the tool, if applicable.")
  @visibility(Lifecycle.Read)
  toolName?: string;

  @doc("The arguments passed to the tool, if applicable.")
  @visibility(Lifecycle.Read)
  toolArguments?: string;

  @doc("Indicates if this log entry represents an action.")
  @visibility(Lifecycle.Read)
  isAction?: IsAction;

  @doc("Indicates the code environment")
  @visibility(Lifecycle.Read)
  codeEnvironment?: boolean;

  @doc("The destination agent, if applicable.")
  @visibility(Lifecycle.Read)
  destinationAgent?: string;

  @doc("The sender of the log entry.")
  @visibility(Lifecycle.Read)
  sender: string;

  @doc("The text content of the log entry.")
  @visibility(Lifecycle.Read)
  text: string;

  @doc("The status of the activity represented by this log entry.")
  @visibility(Lifecycle.Read)
  status: LogStatus;

  @doc("The creation time of the log entry (Unix timestamp).")
  @visibility(Lifecycle.Read)
  createdAt: int64;

  @doc("The completion time of the log entry (Unix timestamp).")
  @visibility(Lifecycle.Read)
  completedAt: int64;
}

@added(Versions.`2025-07-01-preview`)
@removed(Versions.`2026-02-01-preview`)
@doc("Operations for message logs in a conversation.")
interface MessageLogs {
  //   @doc("Fetch a Message by name.")
  //   getLog is ResourceRead<MessageLog>;

  @doc("List message logs in the specified conversation.")
  listLogs is ResourceList<
    MessageLog,
    QueryParametersTrait<WithQueryCreatedSince>
  >;
}
