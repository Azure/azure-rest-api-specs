import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/files";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/files")
@tag("Files")
interface Files {
  @list
  @get
  @summary("Returns a list of files.")
  listFiles is OpenAIOperation<
    {
      /** Only return files with the given purpose. */
      @query(#{ explode: true })
      purpose?: string;

      /** A limit on the number of objects to be returned. Limit can range between 1 and 10,000, and the default is 10,000. */
      @query(#{ explode: true })
      limit?: integer = 10000;

      /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.desc;

      /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;
    },
    OpenAI.ListFilesResponse
  >;

  @post
  @summary("""
    Upload a file that can be used across various endpoints. Individual files
    can be up to 512 MB, and each project can store up to 2.5 TB of files in
    total. There is no organization-wide storage limit. Uploads to this
    endpoint are rate-limited to 1,000 requests per minute per authenticated
    user.
    
    - The Assistants API supports files up to 2 million tokens and of specific
      file types. See the [Assistants Tools guide](/docs/assistants/tools) for
      details.
    - The Fine-tuning API only supports `.jsonl` files. The input also has
      certain required formats for fine-tuning
      [chat](/docs/api-reference/fine-tuning/chat-input) or
      [completions](/docs/api-reference/fine-tuning/completions-input) models.
    - The Batch API only supports `.jsonl` files up to 200 MB in size. The input
      also has a specific required
      [format](/docs/api-reference/batch/request-input).
    - For Retrieval or `file_search` ingestion, upload files here first. If
      you need to attach multiple uploaded files to the same vector store, use
      [`/vector_stores/{vector_store_id}/file_batches`](/docs/api-reference/vector-stores-file-batches/createBatch)
      instead of attaching them one by one. Vector store attachment has separate
      limits from file upload, including 2,000 attached files per minute per
      organization.
    
    Please [contact us](https://help.openai.com/) if you need to increase these
    storage limits.
    
    """)
  createFile is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateFileRequest;
    },
    OpenAI.OpenAIFile
  >;

  @route("{file_id}")
  @delete
  @summary("Delete a file and remove it from all vector stores.")
  deleteFile is OpenAIOperation<
    {
      /** The ID of the file to use for this request. */
      @path
      file_id: string;
    },
    OpenAI.DeleteFileResponse
  >;

  @route("{file_id}")
  @get
  @summary("Returns information about a specific file.")
  retrieveFile is OpenAIOperation<
    {
      /** The ID of the file to use for this request. */
      @path
      file_id: string;
    },
    OpenAI.OpenAIFile
  >;

  @route("{file_id}/content")
  @get
  @summary("Returns the contents of the specified file.")
  downloadFile is OpenAIOperation<
    {
      /** The ID of the file to use for this request. */
      @path
      file_id: string;
    },
    TypeSpec.Http.Body<string>
  >;
}
