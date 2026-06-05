import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/embeddings";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/embeddings")
@tag("Embeddings")
interface Embeddings {
  @post
  @summary("Creates an embedding vector representing the input text.")
  createEmbedding is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateEmbeddingRequest;
    },
    OpenAI.CreateEmbeddingResponse
  >;
}
