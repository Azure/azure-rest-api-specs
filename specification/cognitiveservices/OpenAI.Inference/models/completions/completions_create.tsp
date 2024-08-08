import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

import "./common.tsp";
import "./azure_content_filtering.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Azure.OpenAI;

@doc("""
The configuration information for a completions request.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
model CompletionsOptions {
  @doc("The prompts to generate completions from.")
  @clientName("Prompts", "csharp")
  prompt: string[];

  @doc("The maximum number of tokens to generate.")
  @encodedName("application/json", "max_tokens")
  maxTokens?: int32;

  @doc("""
    The sampling temperature to use that controls the apparent creativity of generated completions.
    Higher values will make output more random while lower values will make results more focused
    and deterministic.
    It is not recommended to modify temperature and top_p for the same completions request as the
    interaction of these two settings is difficult to predict.
    """)
  temperature?: float32;

  @doc("""
    An alternative to sampling with temperature called nucleus sampling. This value causes the
    model to consider the results of tokens with the provided probability mass. As an example, a
    value of 0.15 will cause only the tokens comprising the top 15% of probability mass to be
    considered.
    It is not recommended to modify temperature and top_p for the same completions request as the
    interaction of these two settings is difficult to predict.
    """)
  @encodedName("application/json", "top_p")
  @clientName("NucleusSamplingFactor", "csharp")
  topP?: float32;

  @doc("""
    A map between GPT token IDs and bias scores that influences the probability of specific tokens
    appearing in a completions response. Token IDs are computed via external tokenizer tools, while
    bias scores reside in the range of -100 to 100 with minimum and maximum values corresponding to
    a full ban or exclusive selection of a token, respectively. The exact behavior of a given bias
    score varies by model.
    """)
  @encodedName("application/json", "logit_bias")
  @clientName("TokenSelectionBiases", "csharp")
  logitBias?: Record<int32>;

  @doc("""
    An identifier for the caller or end user of the operation. This may be used for tracking
    or rate-limiting purposes.
    """)
  user?: string;

  @doc("""
    The number of completions choices that should be generated per provided prompt as part of an
    overall completions response.
    Because this setting can generate many completions, it may quickly consume your token quota.
    Use carefully and ensure reasonable settings for max_tokens and stop.
    """)
  @clientName("ChoicesPerPrompt", "csharp")
  n?: int32;

  @doc("""
    A value that controls the emission of log probabilities for the provided number of most likely
    tokens within a completions response.
    """)
  @clientName("LogProbabilityCount", "csharp")
  logprobs?: int32;

  @doc("The suffix that comes after a completion of inserted text")
  suffix?: string;

  @doc("""
    A value specifying whether completions responses should include input prompts as prefixes to
    their generated output.
    """)
  echo?: boolean;

  @doc("""
    A collection of textual sequences that will end completions generation.
    """)
  @clientName("StopSequences", "csharp")
  stop?: string[];

  @doc("""
    A value that influences the probability of generated tokens appearing based on their existing
    presence in generated text.
    Positive values will make tokens less likely to appear when they already exist and increase the
    model's likelihood to output new topics.
    """)
  @encodedName("application/json", "presence_penalty")
  presencePenalty?: float32;

  @doc("""
    A value that influences the probability of generated tokens appearing based on their cumulative
    frequency in generated text.
    Positive values will make tokens less likely to appear as their frequency increases and
    decrease the likelihood of the model repeating the same statements verbatim.
    """)
  @encodedName("application/json", "frequency_penalty")
  frequencyPenalty?: float32;

  @doc("""
    A value that controls how many completions will be internally generated prior to response
    formulation.
    When used together with n, best_of controls the number of candidate completions and must be
    greater than n.
    Because this setting can generate many completions, it may quickly consume your token quota.
    Use carefully and ensure reasonable settings for max_tokens and stop.
    """)
  @encodedName("application/json", "best_of")
  @clientName("GenerationSampleCount", "csharp")
  bestOf?: int32;

  @doc("""
    A value indicating whether chat completions should be streamed for this request.
    """)
  @clientName("InternalShouldStreamResponse", "csharp")
  stream?: boolean;

  @doc("""
    The model name to provide as part of this completions request.
    Not applicable to Azure OpenAI, where deployment information should be included in the Azure
    resource URI that's connected to.
    """)
  @clientName("DeploymentName", "csharp")
  `model`?: string;
}

@doc("""
Representation of the response data from a completions request.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
model Completions {
  @doc("A unique identifier associated with this completions response.")
  id: string;

  @doc("""
    The first timestamp associated with generation activity for this completions response,
    represented as seconds since the beginning of the Unix epoch of 00:00 on 1 Jan 1970.
    """)
  @clientName("createdAt", "java")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  created: utcDateTime;

  @doc("""
  Content filtering results for zero or more prompts in the request. In a streaming request,
  results for different prompts may arrive at different times or in different orders.
  """)
  @added(ServiceApiVersions.v2023_06_01_Preview)
  @encodedName("application/json", "prompt_filter_results")
  promptFilterResults?: ContentFilterResultsForPrompt[];

  @doc("""
    The collection of completions choices associated with this completions response.
    Generally, `n` choices are generated per provided prompt with a default value of 1.
    Token limits and other settings may limit the number of choices generated.
    """)
  choices: Choice[];

  @doc("""
    Usage information for tokens processed and generated as part of this completions operation.
    """)
  usage: CompletionsUsage;
}

@doc("""
The representation of a single prompt completion as part of an overall completions request.
Generally, `n` choices are generated per provided prompt with a default value of 1.
Token limits and other settings may limit the number of choices generated.
""")
model Choice {
  @doc("The generated text for a given completions prompt.")
  text: string;

  @doc("The ordered index associated with this completions choice.")
  index: int32;

  @doc("""
  Information about the content filtering category (hate, sexual, violence, self_harm), if it
  has been detected, as well as the severity level (very_low, low, medium, high-scale that
  determines the intensity and risk level of harmful content) and if it has been filtered or not.
  """)
  @added(ServiceApiVersions.v2023_06_01_Preview)
  @encodedName("application/json", "content_filter_results")
  contentFilterResults?: ContentFilterResultsForChoice;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The operation already returns nulls"
  @doc("The log probabilities model for tokens associated with this completions choice.")
  @clientName("LogProbabilityModel", "csharp")
  logprobs: CompletionsLogProbabilityModel | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The operation already returns nulls"
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  @doc("Reason for finishing")
  @encodedName("application/json", "finish_reason")
  finishReason: CompletionsFinishReason | null;
}

alias NullableFloat = float32 | null;

@doc("""
Representation of a log probabilities model for a completions generation.
""")
model CompletionsLogProbabilityModel {
  @doc("The textual forms of tokens evaluated in this probability model.")
  tokens: string[];

  @doc("A collection of log probability values for the tokens in this completions data.")
  @encodedName("application/json", "token_logprobs")
  @clientName("TokenLogProbabilities", "csharp")
  @clientName("tokenLogProbabilities", "java")
  tokenLogprobs: NullableFloat[];

  @doc("A mapping of tokens to maximum log probability values in this completions data.")
  @encodedName("application/json", "top_logprobs")
  @clientName("TopLogProbabilities", "csharp")
  @clientName("topLogProbabilities", "java")
  topLogprobs: Record<NullableFloat>[];

  @doc("The text offsets associated with tokens in this completions data.")
  @encodedName("application/json", "text_offset")
  @clientName("TextOffsets", "csharp")
  @clientName("textOffsets", "java")
  textOffset: int32[];
}
