import "@typespec/rest";
import "@typespec/http";
import "./completions.create.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.OpenAI.ChatCompletions;

@doc("""
""")
enum ChatRole {
    @doc("""
""")
    System,
    @doc("""
""")
    Assistant,
    @doc("""
""")
    User
}

@doc("""
The configuration information used for a chat completions request.
""")
model ChatCompletionsOptions {
    @doc("""
""")
    messages?: ChatMessage[];

    @doc("""
""")
    max_tokens?: int32;

    @doc("""
""")
    temperature?: float32;

// Note: this is reprojected as "NucleusSamplingFactor"
    @doc("""
""")
    top_p?: float32;

    @doc("""
""")
    user?: string;

// Note: this is reprojected as "ChoicesPerPrompt"
    @doc("""
""")
    n?: int32;

// Suppression: Streaming is managed via API surface (method-level)
//     @doc("""
// """)
//     stream?: boolean;

// Suppression: handled at the method level
//    @doc("The name of the model to use")
//    "model"?: string;

// Note: this is reprojected as "StopSequences"
    @doc
    ("""
""")
    stop?: string[];

    @doc("""
""")
    presence_penalty?: float32;

    @doc("""
""")
    frequency_penalty?: float32;
};

model ChatMessage {
    @doc("""
""")
    role: ChatRole;
    @doc("""
""")
    content: string;
}

model ChatChoice {
    @doc("""
""")
    message: ChatMessage;

    @doc("""
""")
    index: int32;

    @doc("""
""")
    finish_reason: string;
}

@doc("""
""")
model ChatCompletions {
    @doc("""
    """)
    @header "apim-request-id": string;
    @doc("Id for completion response")
    id?: string;

// Suppression: not needed in strongly typed object models
//    object: "text_completion";

// Suppression: currently handled at projection level for idiomatic representation
//    created?: int32;

// Suppression: handled at the method level rather than request payload
//    "model"?: string;

    @doc("""
""")
    choices?: ChatChoice[];

    @doc("""
""")
    usage: CompletionsUsage;
}

@doc("""
""")
model StreamingChatChoice {
    @doc("""
""")
    message: ChatMessage;

    @doc("""
""")
    index: int32;

    @doc("""
""")
    finish_reason: string;
}

    @doc("""
""")
model StreamingChatCompletions {
    @doc("""
    """)
    @header "apim-request-id": string;
    @doc("Id for completion response")
    id?: string;

// Suppression: not needed in strongly typed object models
//    object: "text_completion";
//    "model"?: string;

// Suppression: currently handled at projection level for idiomatic representation
//    created?: int32;

    @doc("""
""")
    choices?: StreamingChatChoice[];
}
