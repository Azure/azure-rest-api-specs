import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.OpenAI.Embeddings;

@doc("Schema to create a prompt completion from a deployment")
model EmbeddingsOptions {
    @doc("The ID of the end-user, for use in tracking and rate-limiting.")
    user?: string;

    @doc("input type of embedding search to use")
    input_type?: string;

    @doc("ID of the model to use")
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
    @doc("Type of the data field")
    object: "list",

    @doc("Embedding values for the prompts submitted in the request")
    data: EmbeddingItem[],

    @doc("ID of the model to use")
    "model"?: string;

    @doc("Usage counts for tokens input using the embeddings API")
    usage: EmbeddingsUsage;
}

@doc("Expected response schema to embeddings object list item request")
model EmbeddingItem {
    @doc("Name of the field in which the embedding is contained")
    object: "embedding",

    @doc("List of embeddings value for the input prompt. These represents a measurement of releated of text strings")
    embedding: float32[];

    @doc("Index of the prompt to which the EmbeddingItem corresponds")
    index: int32;
}

@doc("Measurment of the amount of tokens used in this request and response")
model EmbeddingsUsage {
    @doc("Number of tokens sent in the original request")
    prompt_tokens: int32,
    @doc("Total number of tokens transacted in this request/response")
    total_tokens: int32
}
