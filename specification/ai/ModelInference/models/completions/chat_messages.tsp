import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ModelInference;

#suppress "@azure-tools/typespec-autorest/union-unsupported" "External API shape is defined in OpenAPI 3.0 as oneOf."
alias ChatMessageContent = string | ChatMessageContentItem[];

@doc("An abstract representation of a structured content item within a chat message.")
@discriminator("type")
model ChatMessageContentItem {
  @doc("The discriminated object type.")
  type: string;
}

@doc("A structured chat content item containing plain text.")
model ChatMessageTextContentItem extends ChatMessageContentItem {
  @doc("The discriminated object type: always 'text' for this type.")
  type: "text";

  @doc("The content of the message.")
  text: string;
}

@discriminator("role")
@doc("An abstract representation of a chat message as provided in a request.")
model ChatRequestMessage {
  @doc("The chat role associated with this message.")
  role: ChatRole;
}

@doc("""
A request chat message containing system instructions that influence how the model will generate a chat completions
response.
""")
model ChatRequestSystemMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'system' for system messages.")
  role: ChatRole.system;

  @doc("The contents of the system message.")
  content: string;

  @doc("An optional name for the participant.")
  name?: string;
}

@doc("A request chat message representing user input to the assistant.")
model ChatRequestUserMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'user' for user messages.")
  role: ChatRole.user;

  @doc("The contents of the user message, with available input types varying by selected model.")
  content: ChatMessageContent;

  @doc("An optional name for the participant.")
  name?: string;
}

@doc("A request chat message representing response or action from the assistant.")
model ChatRequestAssistantMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'assistant' for assistant messages.")
  role: ChatRole.assistant;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  content: string | null;

  @doc("An optional name for the participant.")
  name?: string;
}

@doc("A representation of a chat message as received in a response.")
model ChatResponseMessage {
  @doc("The chat role associated with the message.")
  role: ChatRole;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  content: string | null;
}
