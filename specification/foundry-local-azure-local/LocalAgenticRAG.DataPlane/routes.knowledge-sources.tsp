import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FoundryLocal.AgenticRAG;

/** Operations for managing knowledge sources. */
interface KnowledgeSourcesOperationGroup {
  /**
   * Creates a new knowledge source. The MCP server is validated before the record
   * is persisted.
   */
  @summary("Create Knowledge Source")
  @route("/edgeai/knowledgesources")
  @post
  createKnowledgeSource is Azure.Core.RpcOperation<
    CreateKnowledgeSourceRequest,
    KnowledgeSource
  >;

  /** List Knowledge Sources */
  @summary("List Knowledge Sources")
  @route("/edgeai/knowledgesources")
  @get
  listKnowledgeSources is Azure.Core.RpcOperation<
    {
      /** Filter by exact name. */
      @query("name")
      name?: string;

      /** Filter by kind. */
      @query("kind")
      kind?: KnowledgeSourceKind;

      /** Maximum number of knowledge sources to return. */
      @maxValue(100)
      @minValue(1)
      @query("limit")
      limit?: int32 = 10;

      /** Number of items to skip for pagination. */
      @query("offset")
      offset?: int32;
    },
    KnowledgeSourceList
  >;

  /** Get Knowledge Source */
  @summary("Get Knowledge Source")
  @route("/edgeai/knowledgesources/{ksId}")
  @get
  getKnowledgeSource is Azure.Core.RpcOperation<
    {
      /** Knowledge source identifier. */
      @path
      ksId: string;
    },
    KnowledgeSource
  >;

  /**
   * Partially updates a knowledge source. If connection parameters or auth_type
   * change, MCP validation is re-run.
   */
  @summary("Update Knowledge Source")
  @route("/edgeai/knowledgesources/{ksId}")
  @patch
  updateKnowledgeSource is Azure.Core.RpcOperation<
    {
      /** The knowledge source identifier. */
      @path
      ksId: string;

      /** Content type for merge-patch requests. */
      @header
      contentType: "application/merge-patch+json";

      /** The request body containing fields to update. */
      @bodyRoot
      body: UpdateKnowledgeSourceRequest;
    },
    KnowledgeSource
  >;

  /** Delete Knowledge Source */
  @summary("Delete Knowledge Source")
  @route("/edgeai/knowledgesources/{ksId}")
  @delete
  deleteKnowledgeSource is Azure.Core.RpcOperation<
    {
      /** The knowledge source identifier. */
      @path
      ksId: string;
    },
    {
      @statusCode statusCode: 204;
    }
  >;

  /** Batch Delete Knowledge Sources */
  @summary("Batch Delete Knowledge Sources")
  @route("/edgeai/knowledgesources/batch-delete")
  @post
  batchDeleteKnowledgeSources is Azure.Core.RpcOperation<
    BatchDeleteKnowledgeSourcesRequest,
    BatchDeleteKnowledgeSourcesResponse
  >;
}
