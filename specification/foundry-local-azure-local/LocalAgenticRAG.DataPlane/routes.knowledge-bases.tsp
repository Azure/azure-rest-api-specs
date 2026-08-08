import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FoundryLocal.AgenticRAG;

/** Operations for managing knowledge bases. */
interface KnowledgeBasesOperationGroup {
  /** List Knowledge Bases */
  @summary("List Knowledge Bases")
  @route("/knowledge-bases")
  @get
  listKnowledgeBases is Azure.Core.RpcOperation<
    {
      /** Maximum number of knowledge bases to return. */
      @maxValue(100)
      @minValue(1)
      @query("limit")
      limit?: int32 = 20;

      /** Sort order by created_at. */
      @query("order")
      order?: SortOrder = SortOrder.desc;

      /** Cursor for forward pagination (KB ID). */
      @query("after")
      after?: string;

      /** Cursor for backward pagination (KB ID). */
      @query("before")
      before?: string;
    },
    KnowledgeBaseList
  >;

  /** Get Knowledge Base */
  @summary("Get Knowledge Base")
  @route("/knowledge-bases/{kbId}")
  @get
  getKnowledgeBase is Azure.Core.RpcOperation<
    {
      /** Knowledge base identifier (typically asst_{uuid}). */
      @path
      kbId: string;
    },
    KnowledgeBaseWrapper
  >;

  /**
   * Partial update. Requires EdgeRAGDeveloper role. knowledge_source_ids replaces
   * the entire list when provided.
   */
  @summary("Update Knowledge Base")
  @route("/knowledge-bases/{kbId}")
  @patch
  updateKnowledgeBase is Azure.Core.RpcOperation<
    {
      /** The knowledge base identifier. */
      @path
      kbId: string;

      /** Content type for merge-patch requests. */
      @header
      contentType: "application/merge-patch+json";

      /** The request body containing fields to update. */
      @bodyRoot
      body: UpdateKnowledgeBaseRequest;
    },
    KnowledgeBaseWrapper
  >;

  /**
   * Full replacement. Requires EdgeRAGDeveloper role. Omitted fields reset to
   * defaults.
   */
  @summary("Replace Knowledge Base")
  @route("/knowledge-bases/{kbId}")
  @put
  replaceKnowledgeBase is Azure.Core.RpcOperation<
    {
      /** The knowledge base identifier. */
      @path
      kbId: string;

      /** The request body for the full replacement. */
      @bodyRoot
      body: ReplaceKnowledgeBaseRequest;
    },
    KnowledgeBaseWrapper
  >;
}
