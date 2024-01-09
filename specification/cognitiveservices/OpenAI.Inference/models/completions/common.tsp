import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;

namespace Azure.OpenAI;

@doc("""
Representation of the token counts processed for a completions request.
Counts consider all tokens across prompts, choices, choice alternates, best_of generations, and
other consumers.
""")
model CompletionsUsage {
  @doc("The number of tokens generated across all completions emissions.")
  @projectedName("json", "completion_tokens")
  completionTokens: int32;

  @doc("The number of tokens in the provided prompts for the completions request.")
  @projectedName("json", "prompt_tokens")
  promptTokens: int32;

  @doc("The total number of tokens processed for the completions request and response.")
  @projectedName("json", "total_tokens")
  totalTokens: int32;
}

@doc("""
Representation of the manner in which a completions response concluded.
""")
enum CompletionsFinishReason {
  @doc("Completions ended normally and reached its end of token generation.")
  stopped: "stop",

  @doc("Completions exhausted available token limits before generation could complete.")
  tokenLimitReached: "length",

  @doc("""
    Completions generated a response that was identified as potentially sensitive per content
    moderation policies.
    """)
  contentFiltered: "content_filter",

  @doc("Completion ended normally, with the model requesting a function to be called.")
  @added(ServiceApiVersions.v2023_07_01_Preview)
  functionCall: "function_call",

  @doc("Completion ended with the model calling a provided tool for output.")
  @added(ServiceApiVersions.v2023_12_01_Preview)
  toolCalls: "tool_calls",
}

@doc("A description of the intended purpose of a message within a chat completions interaction.")
enum ChatRole {
  @doc("The role that instructs or sets the behavior of the assistant.")
  system: "system",

  @doc("The role that provides responses to system-instructed, user-prompted input.")
  assistant: "assistant",

  @doc("The role that provides input for chat completions.")
  user: "user",

  @doc("The role that provides function results for chat completions.")
  @added(ServiceApiVersions.v2023_07_01_Preview)
  function: "function",

  @doc("The role that represents extension tool activity within a chat completions operation.")
  @added(ServiceApiVersions.v2023_08_01_Preview)
  tool: "tool",
}
