import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace ContentSafety;

alias Role = "user" | "assistant" | "system" | "tool";
alias ContentKind = "text" | "unspecified";

alias ContentItem = TextContentItem | UnspecifiedContentItem;
alias ContentItems = string | ContentItem[];
alias Message = SystemMessage | UserMessage | AssitantMessage | ToolMessage;
alias Tool = FunctionTool | UnspecifiedTool;

@doc("A text content within a single message in a conversation thread")
model TextContentItem {
    @doc("The kind of content, which is text in this case")
    kind: ContentKind = "text";
    
    @doc("The actual content of type text")
    text: string;
}

@doc("An unspecified content within a single message in a conversation thread")
model UnspecifiedContentItem {
    @doc("The kind of content, which is unspecified in this case")
    kind: ContentKind = "unspecified";
}

@doc("A system message in a conversation thread")
model SystemMessage {
  @doc("The role of the participant in the message")
  role: Role = "system";

  @doc("The content of the message")
  contents: ContentItems;

  @doc("Optional name of the sender of the message")
  name?: string;
}

@doc("A user message in a conversation thread")
model UserMessage {
  @doc("The role of the participant in the message")
  role: Role = "user";

  @doc("The content of the message")
  contents: ContentItems;

  @doc("Optional name of the sender of the message")
  name?: string;
}

@doc("An assistant message in a conversation thread") 
model AssitantMessage {
    @doc("The role of the participant in the message")
    role: Role = "assistant";
    
    @doc("The content of the message")
    contents: ContentItems;
    
    @doc("Optional name of the sender of the message")
    name?: string;
    
    @doc("Optional tool calls made by the assistant")
    toolCalls?: ToolCall[];
}

@doc("A tool message in a conversation thread")
model ToolMessage {
    @doc("The role of the participant in the message")
    role: Role = "tool";
    
    @doc("The content of the message")
    contents: ContentItems;
    
    @doc("Optional name of the sender of the message")
    name?: string;

    @doc("Reference to the tool call made by the assistant")
    toolCallId: string;
}


alias ToolCall = FunctionToolCall | UnspecifiedToolCall;

alias ToolType = "function" | "unspecified";

@doc("A tool call of type function")
model FunctionToolCall {
    @doc("Optional ID of the function call")
    id?: string;

    @doc("The type of the tool call, which is function in this case")
    type: ToolType = "function";

    @doc("Function call details")
    function: FunctionCall;
}

@doc("An unspecified tool call")
model UnspecifiedToolCall {
    @doc("Optional ID of the tool call")
    id?: string;

    @doc("The type of the tool call, which is unspecified in this case")
    type: ToolType = "unspecified";
}

@doc("Tool call function")
model FunctionCall {
    @doc("Name of the function being called")
    name: string;

    @doc("Arguments being passed to the function call as a json formatted string")
    arguments: string;
}

@doc("Actual Definition of a function")
model FunctionObject {
    @doc("The name of the function")
    name: string;

    @doc("The description of the function")
    description?: string;

    @doc("Is the function strict")
    strict?: boolean;
}

@doc("Actual Definition of a function tool")
model FunctionTool {
    @doc("The type of the tool, which is function in this case")
    type: ToolType = "function";

    @doc("The function object that defines the tool")
    function: FunctionObject;
}

@doc("Definition of an unspecified tool")
model UnspecifiedTool {
    @doc("The type of the tool, which is unspecified in this case")
    type: ToolType = "unspecified";
}
