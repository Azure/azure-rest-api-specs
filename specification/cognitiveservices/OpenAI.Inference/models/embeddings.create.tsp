import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

@doc("Schema to create a prompt completion from a deployment")
@summary("This is EmbeddingsOptions's summary")
model EmbeddingsOptions {
    @doc("The ID of the end-user, for use in tracking and rate-limiting.")
    user?: string;

    @doc("input type of embedding search to use")
    @projectedName("json", "input_type")
    inputType?: string;

    @doc("""
    The model name to provide as part of this completions request.
    Not applicable to Azure OpenAI, where deployment information should be included in the Azure
    resource URI that's connected to.
    """)
    @projectedName("json", "model")
    @projectedName("csharp", "InternalNonAzureModelName")
    "model"?: string;

    @doc("""
    Input text to get embeddings for, encoded as a string.
    To get embeddings for multiple inputs in a single request, pass an array of strings.
    Each input must not exceed 2048 tokens in length.

    Unless you are embedding code, we suggest replacing newlines (\\n) in your input with a single space,
    as we have observed inferior results when newlines are present.
    """)
    input: string | string[];
};

@doc("Expected response schema to embeddings request")
model Embeddings {
    @doc("Embedding values for the prompts submitted in the request")
    data: EmbeddingItem[],

    @doc("Usage counts for tokens input using the embeddings API")
    usage: EmbeddingsUsage;
}

@doc("Expected response schema to embeddings object list item request")
model EmbeddingItem {
    @doc("List of embeddings value for the input prompt. These represents a measurement of releated of text strings")
    embedding: float32[];

    @doc("Index of the prompt to which the EmbeddingItem corresponds")
    index: int32;
}

@doc("Measurment of the amount of tokens used in this request and response")
model EmbeddingsUsage {
    @doc("Number of tokens sent in the original request")
    @projectedName("json", "prompt_tokens")
    promptTokens: int32,

    @doc("Total number of tokens transacted in this request/response")
    @projectedName("json", "total_tokens")
    totalTokens: int32
}