import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../azure_chat_extensions.tsp";
import "../common.tsp";
import "../functions.tsp";
import "../chat_completions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.OpenAI;

@doc("""
Representation of the response data from a completions request.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
model CompletionsStreamDelta {
  @doc("A unique identifier associated with this completions response.")
  @projectedName("json", "id")
  id: string;

  @doc("""
    The first timestamp associated with generation activity for this completions response,
    represented as seconds since the beginning of the Unix epoch of 00:00 on 1 Jan 1970.
    """)
  @projectedName("json", "created")
  @projectedName("java", "createdAt")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  created: utcDateTime;

  @doc("""
  Content filtering results for zero or more prompts in the request. In a streaming request,
  results for different prompts may arrive at different times or in different orders.
  """)
  @added(ServiceApiVersions.v2023_06_01_Preview)
  @projectedName("json", "prompt_filter_results")
  promptFilterResults?: PromptFilterResult[];

  @doc("""
    The collection of completions choices associated with this completions response.
    Generally, `n` choices are generated per provided prompt with a default value of 1.
    Token limits and other settings may limit the number of choices generated.
    """)
  @projectedName("json", "choices")
  choices: ChoiceStreamDelta[];

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The operation already returns nulls"
  @doc("""
    Usage information for tokens processed and generated as part of this completions operation.
    """)
  @projectedName("json", "usage")
  usage: CompletionsUsage | null;
}

@doc("""
The representation of a single prompt completion as part of an overall completions request.
Generally, `n` choices are generated per provided prompt with a default value of 1.
Token limits and other settings may limit the number of choices generated.
""")
model ChoiceStreamDelta {
  @doc("The generated text for a given completions prompt.")
  @projectedName("json", "text")
  text: string;

  @doc("The ordered index associated with this completions choice.")
  @projectedName("json", "index")
  index: int32;

  @doc("""
  Information about the content filtering category (hate, sexual, violence, self_harm), if it
  has been detected, as well as the severity level (very_low, low, medium, high-scale that
  determines the intensity and risk level of harmful content) and if it has been filtered or not.
  """)
  @added(ServiceApiVersions.v2023_06_01_Preview)
  @projectedName("json", "content_filter_results")
  contentFilterResults?: ContentFilterResults;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The operation already returns nulls"
  @doc("The log probabilities model for tokens associated with this completions choice.")
  @projectedName("json", "logprobs")
  @projectedName("csharp", "LogProbabilityModel")
  logprobs: CompletionsLogProbabilityModelStreamDelta | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The operation already returns nulls"
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  @doc("Reason for finishing")
  @projectedName("json", "finish_reason")
  finishReason: CompletionsFinishReason | null;
}

@doc("""
Representation of a log probabilities model for a completions generation.
""")
model CompletionsLogProbabilityModelStreamDelta {
  @doc("The textual forms of tokens evaluated in this probability model.")
  @projectedName("json", "tokens")
  tokens: string[];

  @doc("A collection of log probability values for the tokens in this completions data.")
  @projectedName("json", "token_logprobs")
  @projectedName("csharp", "TokenLogProbabilities")
  @projectedName("java", "tokenLogProbabilities")
  tokenLogprobs: NullableFloat[];

  @doc("A mapping of tokens to maximum log probability values in this completions data.")
  @projectedName("json", "top_logprobs")
  @projectedName("csharp", "TopLogProbabilities")
  @projectedName("java", "topLogProbabilities")
  topLogprobs: Record<NullableFloat>[];

  @doc("The text offsets associated with tokens in this completions data.")
  @projectedName("json", "text_offset")
  @projectedName("csharp", "TextOffsets")
  @projectedName("java", "textOffsets")
  textOffset: int32[];
}
