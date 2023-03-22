import "@typespec/rest";
import "@typespec/http";
import "./completions.common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

@doc("!! Documentation Pending !!")
model CompletionsOptions {
    @doc("!! Documentation Pending !!")
    @projectedName("csharp", "Prompts")
    prompt?: string[];

    @doc("!! Documentation Pending !!")
    @projectedName("json", "max_tokens")
    maxTokens?: int32;

    @doc("!! Documentation Pending !!")
    temperature?: float32;

    @doc("!! Documentation Pending !!")
    @projectedName("json", "top_p")
    @projectedName("csharp", "NucleusSamplingFactor")
    topP?: float32;

    @doc("!! Documentation Pending !!")
    @projectedName("json", "logit_bias")
    @projectedName("csharp", "TokenSelectionBiases")
    logitBias?: Record<int32>;

    @doc("!! Documentation Pending !!")
    user?: string;

    @doc("!! Documentation Pending !!")
    @projectedName("csharp", "ChoicesPerPrompt")
    n?: int32;

    @doc("!! Documentation Pending !!")
    @projectedName("csharp", "LogProbabilityCount")
    logprobs?: int32;

    @doc("!! Documentation Pending !!")
    echo?: boolean;

    @doc("!! Documentation Pending !!")
    @projectedName("csharp", "StopSequences")
    stop?: string[];

    @doc("!! Documentation Pending !!")
    @projectedName("json", "presence_penalty")
    presencePenalty?: float32;

    @doc("!! Documentation Pending !!")
    @projectedName("json", "frequency_penalty")
    frequencyPenalty?: float32;

    @doc("!! Documentation Pending !!")
    @projectedName("json", "best_of")
    @projectedName("csharp", "GenerationSampleCount")
    bestOf?: int32;
};

@doc("!! Documentation Pending !!")
model CompletionsLogProbabilities {
    @doc("!! Documentation Pending !!")
    tokens?: string[];

    @doc("!! Documentation Pending !!")
    @projectedName("json", "token_logprobs")
    @projectedName("csharp", "TokenLogProbabilities")
    tokenLogprobs?: float32[];

    @doc("!! Documentation Pending !!")
    @projectedName("json", "top_logprobs")
    @projectedName("csharp", "TopLogProbabilities")
    topLogprobs?: Record<float32>[];

    @doc("!! Documentation Pending !!")
    @projectedName("json", "text_offset")
    textOffset?: int32[];
}

@doc("!! Documentation Pending !!")
model Choice {
    @doc("!! Documentation Pending !!")
    text: string;

    @doc("!! Documentation Pending !!")
    index: int32;

    @doc("!! Documentation Pending !!")
    @projectedName("csharp", "LogProbabilities")
    logprobs?: CompletionsLogProbabilities;

    @doc("!! Documentation Pending !!")
    @projectedName("json", "finish_reason")
    finishReason: FinishReason;
}

@doc("!! Documentation Pending !!")
model Completions {
    @doc("!! Documentation Pending !!")
    id: string;

    // Note: this is seconds since UNIX epoch start (00:00 1 Jan 1970) and needs conversion
    @doc("!! Documentation Pending !!")
    created: int32;

    @doc("!! Documentation Pending !!")
    choices?: Choice[];

    @doc("!! Documentation Pending !!")
    usage: CompletionsUsage;
}

@doc("TBD")
model StreamingChoice {
    @doc("TBD")
    text: string;

    @doc("TBD")
    index: int32;

    @doc("TBD")
    @projectedName("json", "finish_reason")
    finishReason: FinishReason;
}

@doc("TBD")
model StreamingCompletions {
    @doc("The unique identifier associated with this completions response.")
    id: string;

    // Note: this is seconds since UNIX epoch start (00:00 1 Jan 1970) and needs conversion
    @doc("!! Documentation Pending !!")
    created: int32;

    @doc("TBD")
    choices?: StreamingChoice[];
}
