import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/vector-stores";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/vector_stores")
@tag("Vector stores")
interface VectorStores {
  @list
  @get
  @summary("Returns a list of vector stores.")
  listVectorStores is OpenAIOperation<
    {
      /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.desc;

      /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
      @query(#{ explode: true })
      before?: string;
    },
    OpenAI.ListVectorStoresResponse
  >;

  @post
  @summary("Create a vector store.")
  createVectorStore is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateVectorStoreRequest;
    },
    OpenAI.VectorStoreObject
  >;

  @route("{vector_store_id}")
  @delete
  @summary("Delete a vector store.")
  deleteVectorStore is OpenAIOperation<
    {
      /** The ID of the vector store to delete. */
      @path
      vector_store_id: string;
    },
    OpenAI.DeleteVectorStoreResponse
  >;

  @route("{vector_store_id}")
  @get
  @summary("Retrieves a vector store.")
  getVectorStore is OpenAIOperation<
    {
      /** The ID of the vector store to retrieve. */
      @path
      vector_store_id: string;
    },
    OpenAI.VectorStoreObject
  >;

  @route("{vector_store_id}")
  @post
  @summary("Modifies a vector store.")
  modifyVectorStore is OpenAIOperation<
    {
      /** The ID of the vector store to modify. */
      @path
      vector_store_id: string;

      @body
      body: OpenAI.UpdateVectorStoreRequest;
    },
    OpenAI.VectorStoreObject
  >;

  @route("{vector_store_id}/file_batches")
  @post
  @summary("Create a vector store file batch.")
  createVectorStoreFileBatch is OpenAIOperation<
    {
      /** The ID of the vector store for which to create a File Batch. */
      @path
      vector_store_id: string;

      @body
      body: OpenAI.CreateVectorStoreFileBatchRequest;
    },
    OpenAI.VectorStoreFileBatchObject
  >;

  @route("{vector_store_id}/file_batches/{batch_id}")
  @get
  @summary("Retrieves a vector store file batch.")
  getVectorStoreFileBatch is OpenAIOperation<
    {
      /** The ID of the vector store that the file batch belongs to. */
      @path
      vector_store_id: string;

      /** The ID of the file batch being retrieved. */
      @path
      batch_id: string;
    },
    OpenAI.VectorStoreFileBatchObject
  >;

  @route("{vector_store_id}/file_batches/{batch_id}/cancel")
  @post
  @summary("Cancel a vector store file batch. This attempts to cancel the processing of files in this batch as soon as possible.")
  cancelVectorStoreFileBatch is OpenAIOperation<
    {
      /** The ID of the vector store that the file batch belongs to. */
      @path
      vector_store_id: string;

      /** The ID of the file batch to cancel. */
      @path
      batch_id: string;
    },
    OpenAI.VectorStoreFileBatchObject
  >;

  @list
  @route("{vector_store_id}/file_batches/{batch_id}/files")
  @get
  @summary("Returns a list of vector store files in a batch.")
  listFilesInVectorStoreBatch is OpenAIOperation<
    {
      /** The ID of the vector store that the files belong to. */
      @path
      vector_store_id: string;

      /** The ID of the file batch that the files belong to. */
      @path
      batch_id: string;

      /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.desc;

      /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
      @query(#{ explode: true })
      before?: string;

      /** Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`. */
      @query(#{ explode: true })
      filter?: OpenAI.ListVectorStoreFilesFilter;
    },
    OpenAI.ListVectorStoreFilesResponse
  >;

  @list
  @route("{vector_store_id}/files")
  @get
  @summary("Returns a list of vector store files.")
  listVectorStoreFiles is OpenAIOperation<
    {
      /** The ID of the vector store that the files belong to. */
      @path
      vector_store_id: string;

      /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.desc;

      /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
      @query(#{ explode: true })
      before?: string;

      /** Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`. */
      @query(#{ explode: true })
      filter?: OpenAI.ListVectorStoreFilesFilter;
    },
    OpenAI.ListVectorStoreFilesResponse
  >;

  @route("{vector_store_id}/files")
  @post
  @summary("Create a vector store file by attaching a [File](/docs/api-reference/files) to a [vector store](/docs/api-reference/vector-stores/object).")
  createVectorStoreFile is OpenAIOperation<
    {
      /** The ID of the vector store for which to create a File. */
      @path
      vector_store_id: string;

      @body
      body: OpenAI.CreateVectorStoreFileRequest;
    },
    OpenAI.VectorStoreFileObject
  >;

  @route("{vector_store_id}/files/{file_id}")
  @delete
  @summary("Delete a vector store file. This will remove the file from the vector store but the file itself will not be deleted. To delete the file, use the [delete file](/docs/api-reference/files/delete) endpoint.")
  deleteVectorStoreFile is OpenAIOperation<
    {
      /** The ID of the vector store that the file belongs to. */
      @path
      vector_store_id: string;

      /** The ID of the file to delete. */
      @path
      file_id: string;
    },
    OpenAI.DeleteVectorStoreFileResponse
  >;

  @route("{vector_store_id}/files/{file_id}")
  @get
  @summary("Retrieves a vector store file.")
  getVectorStoreFile is OpenAIOperation<
    {
      /** The ID of the vector store that the file belongs to. */
      @path
      vector_store_id: string;

      /** The ID of the file being retrieved. */
      @path
      file_id: string;
    },
    OpenAI.VectorStoreFileObject
  >;

  @route("{vector_store_id}/files/{file_id}")
  @post
  @summary("Update attributes on a vector store file.")
  updateVectorStoreFileAttributes is OpenAIOperation<
    {
      /** The ID of the vector store the file belongs to. */
      @path
      vector_store_id: string;

      /** The ID of the file to update attributes. */
      @path
      file_id: string;

      @body
      body: OpenAI.UpdateVectorStoreFileAttributesRequest;
    },
    OpenAI.VectorStoreFileObject
  >;

  @route("{vector_store_id}/files/{file_id}/content")
  @get
  @summary("Retrieve the parsed contents of a vector store file.")
  retrieveVectorStoreFileContent is OpenAIOperation<
    {
      /** The ID of the vector store. */
      @path
      vector_store_id: string;

      /** The ID of the file within the vector store. */
      @path
      file_id: string;
    },
    OpenAI.VectorStoreFileContentResponse
  >;

  @route("{vector_store_id}/search")
  @post
  @summary("Search a vector store for relevant chunks based on a query and file attributes filter.")
  searchVectorStore is OpenAIOperation<
    {
      /** The ID of the vector store to search. */
      @path
      vector_store_id: string;

      @body
      body: OpenAI.VectorStoreSearchRequest;
    },
    OpenAI.VectorStoreSearchResultsPage
  >;
}
