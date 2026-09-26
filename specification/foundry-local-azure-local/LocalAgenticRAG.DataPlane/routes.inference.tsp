import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FoundryLocal.AgenticRAG;

/** Operations for chat completions with and without retrieval-augmented generation. */
interface ChatCompletionsOperationGroup {
  /**
   * Queries a collection using RAG. Searches vector data, retrieves relevant
   * chunks, and generates a grounded LLM response.
   */
  @summary("Chat Completions (RAG)")
  @route("/edgeai/chat/completions")
  @post
  ragChatCompletion is Azure.Core.RpcOperation<
    {
      /**
       * dev = uses request body parameters directly. user = loads developer-configured
       * settings.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "HTTP header name"
      @header
      `x-user-role`: UserRole;

      /** The RAG chat request body. */
      @bodyRoot
      body: RagChatRequest;
    },
    ChatCompletionResponse
  >;

  /**
   * Queries the LLM directly without retrieval. No collection needed, no RBAC, no
   * api-version required.
   */
  @summary("Chat Completions (Model-Only)")
  @route("/edgeai/slm/chat/completions")
  @post
  modelOnlyChatCompletion is Azure.Core.RpcOperation<
    {
      /** The role of the user making the request. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "HTTP header name"
      @header
      `x-user-role`?: UserRole;

      /** The model-only chat request body. */
      @bodyRoot
      body: ModelOnlyChatRequest;
    },
    ChatCompletionResponse
  >;
}
