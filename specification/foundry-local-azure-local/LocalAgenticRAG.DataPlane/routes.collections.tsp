import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FoundryLocal.AgenticRAG;

/** Operations for managing document collections. */
interface CollectionsOperationGroup {
  /** Create Collection */
  @summary("Create Collection")
  @route("/edgeai/collections")
  @post
  createCollection is Azure.Core.RpcOperation<CreateCollectionRequest, Collection>;

  /** List Collections */
  @summary("List Collections")
  @route("/edgeai/collections")
  @get
  listCollections is Azure.Core.RpcOperation<{}, CollectionList>;

  /** Get Collection */
  @summary("Get Collection")
  @route("/edgeai/collections/{name}")
  @get
  getCollection is Azure.Core.RpcOperation<
    {
      /** Collection name. */
      @path
      name: string;
    },
    Collection
  >;

  /** Only the description can be updated. Name is immutable. */
  @summary("Update Collection")
  @route("/edgeai/collections/{name}")
  @patch
  updateCollection is Azure.Core.RpcOperation<
    {
      /** The name of the collection to update. */
      @path
      name: string;

      /** Content type for merge-patch requests. */
      @header
      contentType: "application/merge-patch+json";

      /** The request body containing the updated description. */
      @bodyRoot
      body: UpdateCollectionRequest;
    },
    Collection
  >;

  /**
   * Deletes collection and all associated Milvus collections, Postgres tables, and
   * metadata.
   */
  @summary("Delete Collection")
  @route("/edgeai/collections/{name}")
  @delete
  deleteCollection is Azure.Core.RpcOperation<
    {
      /** The name of the collection to delete. */
      @path
      name: string;
    },
    DeleteCollectionResponse
  >;
}
