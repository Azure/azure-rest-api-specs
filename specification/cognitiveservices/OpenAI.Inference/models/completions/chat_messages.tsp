import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./azure_chat_extensions.tsp";
import "./common.tsp";
import "./functions.tsp";
import "./tools.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.OpenAI;

#suppress "@azure-tools/typespec-autorest/union-unsupported" "External API shape is defined in OpenAPI 3.0 as oneOf."
alias ChatMessageContent = string | ChatMessageContentItem[];

model ChatMessageContentItem {
  type: string;
}

model ChatMessageTextContentItem extends ChatMessageContentItem {
  type: "text";
  content: string;
}

enum ChatMessageImageDetailLevel {
  auto: "auto",
  low: "low",
  high: "high",
}

model ChatMessageImageContentItem extends ChatMessageContentItem {
  type: "image_url";
  url: url;
  detail?: ChatMessageImageDetailLevel;
}

@discriminator("role")
model ChatRequestMessage {
  role: ChatRole;
}

model ChatRequestSystemMessage extends ChatRequestMessage {
  role: ChatRole.system;
  content: string;
  name?: string;
}

model ChatRequestUserMessage extends ChatRequestMessage {
  role: ChatRole.user;
  content: ChatMessageContent;
  name?: string;
}

model ChatRequestAssistantMessage extends ChatRequestMessage {
  role: ChatRole.assistant;
  content: string | null;
  name?: string;

  @projectedName("json", "tool_calls")
  @added(ServiceApiVersions.v2023_12_01_Preview)
  toolCalls?: ChatCompletionsToolCall[];

  @added(ServiceApiVersions.v2023_07_01_Preview)
  @removed(ServiceApiVersions.v2023_12_01_Preview)
  @projectedName("json", "function_call")
  functionCall?: FunctionCall;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
model ChatRequestToolMessage extends ChatRequestMessage {
  role: ChatRole.tool;
  content: string | null;

  @projectedName("json", "tool_call_id")
  toolCallId: string;
}

@added(ServiceApiVersions.v2023_07_01_Preview)
@removed(ServiceApiVersions.v2023_12_01_Preview)
model ChatRequestFunctionMessage extends ChatRequestMessage {
  role: ChatRole.function;
  content: string;
  name: string;
}

model ChatResponseMessage {
  role: ChatRole;
  content: string | null;

  @added(ServiceApiVersions.v2023_12_01_Preview)
  @projectedName("json", "tool_calls")
  toolCalls?: ChatCompletionsToolCall[];

  @added(ServiceApiVersions.v2023_07_01_Preview)
  @removed(ServiceApiVersions.v2023_12_01_Preview)
  @projectedName("json", "function_call")
  functionCall?: FunctionCall;
}
