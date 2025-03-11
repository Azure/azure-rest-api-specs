import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./chat_completions.tsp";
import "./embeddings.tsp";
import "./image_embeddings.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Unified;

interface Models {
  @doc("""
    Gets chat completions for the provided chat messages.
    Completions support a wide variety of tasks and generate text that continues from or "completes"
    provided prompt data. The method makes a REST API call to the `/chat/completions` route
    on the given endpoint.
    """)
  @actionSeparator("/")
  @route("models/chat/completions")
  getChatCompletions is Azure.Core.RpcOperation<
    {
      @doc("The parameters of the chat completions request.")
      @body
      body: ChatCompletionsOptions;

      ...AdditionalInferenceRequestHeaders;
    },
    ChatCompletions
  >;

  @doc("""
    Return the embedding vectors for given text prompts.
    The method makes a REST API call to the `/embeddings` route on the given endpoint.
    """)
  @actionSeparator("/")
  @route("models/embeddings")
  getEmbeddings is Azure.Core.RpcOperation<
    {
      @doc("The parameters of the embeddings request.")
      @body
      body: EmbeddingsOptions;

      ...AdditionalInferenceRequestHeaders;
    },
    EmbeddingsResult
  >;

  @doc("""
    Return the embedding vectors for given images.
    The method makes a REST API call to the `/images/embeddings` route on the given endpoint.
    """)
  @actionSeparator("/")
  @route("models/images/embeddings")
  getImageEmbeddings is Azure.Core.RpcOperation<
    {
      @doc("The parameters of the image embeddings request.")
      @body
      body: ImageEmbeddingsOptions;

      ...AdditionalInferenceRequestHeaders;
    },
    EmbeddingsResult
  >;
}
