import "@typespec/rest";
import "@typespec/http";
import "./completions.common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

@doc("A description of the intended purpose of a message within a chat completions interaction.")
enum ChatRole {
    @doc("The role that instructs or sets the behavior of the assistant.")
    @projectedName("json", "system")
    system,

    @doc("The role that provides responses to system-instructed, user-prompted input.")
    @projectedName("json", "assistant")
    assistant,

    @doc("The role that provides input for chat completions.")
    @projectedName("json", "user")
    user,
}

@doc("A single, role-attributed message within a chat completion interaction.")
model ChatMessage {
    @doc("The role associated with this message payload.")
    @projectedName("json", "role")
    role: ChatRole;

    @doc("The text associated with this message payload.")
    @projectedName("json", "content")
    content?: string;
}

@doc("""
The configuration information for a chat completions request.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
model ChatCompletionsOptions {
    @doc("""
    The collection of context messages associated with this chat completions request.
    Typical usage begins with a chat message for the System role that provides instructions for
    the behavior of the assistant, followed by alternating messages between the User and
    Assistant roles.
    """)
    @projectedName("json", "messages")
    messages: ChatMessage[];

    @doc("The maximum number of tokens to generate.")
    @projectedName("json", "max_tokens")
    maxTokens?: int32;

    @doc("""
    The sampling temperature to use that controls the apparent creativity of generated completions.
    Higher values will make output more random while lower values will make results more focused
    and deterministic.
    It is not recommended to modify temperature and top_p for the same completions request as the
    interaction of these two settings is difficult to predict.
    """)
    @projectedName("json", "temperature")
    temperature?: float32;

    @doc("""
    An alternative to sampling with temperature called nucleus sampling. This value causes the
    model to consider the results of tokens with the provided probability mass. As an example, a
    value of 0.15 will cause only the tokens comprising the top 15% of probability mass to be
    considered.
    It is not recommended to modify temperature and top_p for the same completions request as the
    interaction of these two settings is difficult to predict.
    """)
    @projectedName("json", "top_p")
    @projectedName("csharp", "NucleusSamplingFactor")
    topP?: float32;

    @doc("""
    A map between GPT token IDs and bias scores that influences the probability of specific tokens
    appearing in a completions response. Token IDs are computed via external tokenizer tools, while
    bias scores reside in the range of -100 to 100 with minimum and maximum values corresponding to
    a full ban or exclusive selection of a token, respectively. The exact behavior of a given bias
    score varies by model.
    """)
    @projectedName("json", "logit_bias")
    @projectedName("csharp", "InternalStringKeyedTokenSelectionBiases")
    logitBias?: Record<int32>;

    @doc("""
    An identifier for the caller or end user of the operation. This may be used for tracking
    or rate-limiting purposes.
    """)
    @projectedName("json", "user")
    user?: string;

    @doc("""
    The number of completions choices that should be generated per provided prompt as part of an
    overall completions response.
    Because this setting can generate many completions, it may quickly consume your token quota.
    Use carefully and ensure reasonable settings for max_tokens and stop.
    """)
    @projectedName("json", "n")
    @projectedName("csharp", "ChoicesPerPrompt")
    n?: int32;

    @doc("""
    A collection of textual sequences that will end completions generation.
    """)
    @projectedName("json", "stop")
    @projectedName("csharp", "StopSequences")
    stop?: string[];

    @doc("""
    A value that influences the probability of generated tokens appearing based on their existing
    presence in generated text.
    Positive values will make tokens less likely to appear when they already exist and increase the
    model's likelihood to output new topics.
    """)
    @projectedName("json", "presence_penalty")
    presencePenalty?: float32;

    @doc("""
    A value that influences the probability of generated tokens appearing based on their cumulative
    frequency in generated text.
    Positive values will make tokens less likely to appear as their frequency increases and
    decrease the likelihood of the model repeating the same statements verbatim.
    """)
    @projectedName("json", "frequency_penalty")
    frequencyPenalty?: float32;

    @doc("""
    A value indicating whether chat completions should be streamed for this request.
    """)
    @projectedName("json", "stream")
    @projectedName("csharp", "InternalShouldStreamResponse")
    stream?: boolean;

    @doc("""
    The model name to provide as part of this completions request.
    Not applicable to Azure OpenAI, where deployment information should be included in the Azure
    resource URI that's connected to.
    """)
    @projectedName("json", "model")
    @projectedName("csharp", "InternalNonAzureModelName")
    "model"?: string;
};

@doc("""
The representation of a single prompt completion as part of an overall chat completions request.
Generally, `n` choices are generated per provided prompt with a default value of 1.
Token limits and other settings may limit the number of choices generated.
""")
model ChatChoice {
    @doc("The chat message for a given chat completions prompt.")
    @projectedName("json", "message")
    message?: ChatMessage;

    @doc("The ordered index associated with this chat completions choice.")
    @projectedName("json", "index")
    index: int32;

    @doc("The reason that this chat completions choice completed its generated.")
    @projectedName("json", "finish_reason")
    finishReason: CompletionsFinishReason;

    @doc("The delta message content for a streaming response.")
    @projectedName("json", "delta")
    @projectedName("csharp", "InternalStreamingDeltaMessage")
    delta?: ChatMessage;
}

@doc("""
Representation of the response data from a chat completions request.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
model ChatCompletions {
    @doc("A unique identifier associated with this chat completions response.")
    @projectedName("json", "id")
    id: string;

    @doc("""
    The first timestamp associated with generation activity for this completions response,
    represented as seconds since the beginning of the Unix epoch of 00:00 on 1 Jan 1970.
    """)
    @projectedName("json", "created")
    @projectedName("csharp", "InternalCreatedSecondsAfterUnixEpoch")
    created: int32;

    @doc("""
    The collection of completions choices associated with this completions response.
    Generally, `n` choices are generated per provided prompt with a default value of 1.
    Token limits and other settings may limit the number of choices generated.
    """)
    @projectedName("json", "choices")
    choices?: ChatChoice[];

    @doc("""
    Usage information for tokens processed and generated as part of this completions operation.
    """)
    @projectedName("json", "usage")
    usage: CompletionsUsage;
}