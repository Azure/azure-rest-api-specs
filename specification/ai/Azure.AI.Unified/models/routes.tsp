import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
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

alias ServiceTraits = SupportsClientRequestId &
  SupportsRepeatableRequests &
  SupportsConditionalRequests;

alias ModelOperations = Azure.Core.ResourceOperations<ServiceTraits>;

interface Models {

  @doc("Get a deployed model.")
  get is ModelOperations.ResourceRead<Model>

  @doc("List all deployed models in the project")
  list is ModelOperations.ResourceList<
    Model,
    ListQueryParametersTrait<{
        @doc("Model publisher to filter models by")
        @query("$modelPublisher")
        modelPublisher?: string,
  
        @doc("Model name (the publisher specific name) to filter models by")
        @query("$modelName")
        modelName?: string,
  
        @doc("Flag to include models from connections in response.")
        @query("$includeConnectedModels")
        includeConnectionModels?: boolean,
  
        ...StandardListQueryParameters;
      }>,
  >;

  @doc("""
  Gets chat completions for the provided chat messages.
  Completions support a wide variety of tasks and generate text that continues from or "completes"
  provided prompt data. The method makes a REST API call to the `/chat/completions` route
  on the given endpoint.
  """)
  @actionSeparator("/")
  @route("models/chat/completions")
  op getChatCompletions is Azure.Core.RpcOperation<
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
  op getEmbeddings is Azure.Core.RpcOperation<
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
  op getImageEmbeddings is Azure.Core.RpcOperation<
    {
      @doc("The parameters of the image embeddings request.")
      @body
      body: ImageEmbeddingsOptions;

      ...AdditionalInferenceRequestHeaders;
    },
    EmbeddingsResult
  >;
}
