import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./completions.common.tsp";
import "../main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@doc("A description of the intended purpose of a message within a chat completions interaction.")
@added(Azure.OpenAI.ServiceApiVersions.v2023_03_15_Preview)
enum ChatRole {
    @doc("The role that instructs or sets the behavior of the assistant.")
    System,

    @doc("The role that provides responses to system-instructed, user-prompted input.")
    Assistant,

    @doc("The role that provides input for chat completions.")
    User
}

@doc("The configuration information used for a chat completions request.")
@added(Azure.OpenAI.ServiceApiVersions.v2023_03_15_Preview)
model ChatCompletionsOptions {
    @doc("!! Documentation Pending !!")
    messages?: ChatMessage[];

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
    user?: string;

    @doc("The number of choices that should be generated per provided prompt.")
    @projectedName("csharp", "ChoicesPerPrompt")
    n?: int32;

    @doc("!! Documentation Pending !!")
    @projectedName("csharp", "StopSequences")
    stop?: string[];

    @doc("!! Documentation Pending !!")
    @projectedName("json", "presence_penalty")
    presencePenalty?: float32;

    @doc("!! Documentation Pending !!")
    @projectedName("json", "frequency_penalty")
    frequencyPenalty?: float32;
};

@doc("A single, role-attributed message within a chat completion interaction.")
@added(Azure.OpenAI.ServiceApiVersions.v2023_03_15_Preview)
model ChatMessage {
    @doc("!! Documentation Pending !!")
    role: ChatRole;

    @doc("!! Documentation Pending !!")
    content: string;
}

@doc("The representation of a single completions result for a chat completions request.")
@added(Azure.OpenAI.ServiceApiVersions.v2023_03_15_Preview)
model ChatChoice {
    @doc("!! Documentation Pending !!")
    message: ChatMessage;

    @doc("!! Documentation Pending !!")
    index: int32;

    @doc("!! Documentation Pending !!")
    @projectedName("json", "finish_reason")
    finishReason: FinishReason;
}

@doc("!! Documentation Pending !!")
@added(Azure.OpenAI.ServiceApiVersions.v2023_03_15_Preview)
model ChatCompletions {
    @doc("The unique identifier associated with this chat completions response.")
    id: string;

    // Note: this is seconds since UNIX epoch start (00:00 1 Jan 1970) and needs conversion
    @doc("!! Documentation Pending !!")
    created: int32;

    @doc("!! Documentation Pending !!")
    choices: ChatChoice[];

    @doc("!! Documentation Pending !!")
    usage: CompletionsUsage;
}

@doc("!! Documentation Pending !!")
@added(Azure.OpenAI.ServiceApiVersions.v2023_03_15_Preview)
model StreamingChatChoice {
    @doc("!! Documentation Pending !!")
    message: ChatMessage;

    @doc("!! Documentation Pending !!")
    index: int32;

    @doc("!! Documentation Pending !!")
    @projectedName("json", "finish_reason")
    finishReason: FinishReason;
}

@doc("!! Documentation Pending !!")
@added(Azure.OpenAI.ServiceApiVersions.v2023_03_15_Preview)
model StreamingChatCompletions {
    @doc("The unique identifier associated with this chat completions response.")
    id: string;

    // Note: this is seconds since UNIX epoch start (00:00 1 Jan 1970) and needs conversion
    @doc("!! Documentation Pending !!")
    created: int32;

    @doc("!! Documentation Pending !!")
    choices?: StreamingChatChoice[];
}
