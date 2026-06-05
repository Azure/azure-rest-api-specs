import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/uploads";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/uploads")
@tag("Uploads")
interface Uploads {
  @post
  @summary("""
    Creates an intermediate [Upload](/docs/api-reference/uploads/object) object
    that you can add [Parts](/docs/api-reference/uploads/part-object) to.
    Currently, an Upload can accept at most 8 GB in total and expires after an
    hour after you create it.
    
    Once you complete the Upload, we will create a
    [File](/docs/api-reference/files/object) object that contains all the parts
    you uploaded. This File is usable in the rest of our platform as a regular
    File object.
    
    For certain `purpose` values, the correct `mime_type` must be specified.
    Please refer to documentation for the
    [supported MIME types for your use case](/docs/assistants/tools/file-search#supported-files).
    
    For guidance on the proper filename extensions for each purpose, please
    follow the documentation on [creating a
    File](/docs/api-reference/files/create).
    
    Returns the Upload object with status `pending`.
    
    """)
  createUpload is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateUploadRequest;
    },
    OpenAI.Upload
  >;

  @route("{upload_id}/cancel")
  @post
  @summary("""
    Cancels the Upload. No Parts may be added after an Upload is cancelled.
    
    Returns the Upload object with status `cancelled`.
    
    """)
  cancelUpload is OpenAIOperation<
    {
      /** The ID of the Upload. */
      @path
      upload_id: string;
    },
    OpenAI.Upload
  >;

  @route("{upload_id}/complete")
  @post
  @summary("""
    Completes the [Upload](/docs/api-reference/uploads/object).
    
    Within the returned Upload object, there is a nested [File](/docs/api-reference/files/object) object that is ready to use in the rest of the platform.
    
    You can specify the order of the Parts by passing in an ordered list of the Part IDs.
    
    The number of bytes uploaded upon completion must match the number of bytes initially specified when creating the Upload object. No Parts may be added after an Upload is completed.
    Returns the Upload object with status `completed`, including an additional `file` property containing the created usable File object.
    
    """)
  completeUpload is OpenAIOperation<
    {
      /** The ID of the Upload. */
      @path
      upload_id: string;

      @body
      body: OpenAI.CompleteUploadRequest;
    },
    OpenAI.Upload
  >;

  @route("{upload_id}/parts")
  @post
  @summary("""
    Adds a [Part](/docs/api-reference/uploads/part-object) to an [Upload](/docs/api-reference/uploads/object) object. A Part represents a chunk of bytes from the file you are trying to upload.
    
    Each Part can be at most 64 MB, and you can add Parts until you hit the Upload maximum of 8 GB.
    
    It is possible to add multiple Parts in parallel. You can decide the intended order of the Parts when you [complete the Upload](/docs/api-reference/uploads/complete).
    
    """)
  addUploadPart is OpenAIOperation<
    {
      /** The ID of the Upload. */
      @path
      upload_id: string;

      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.AddUploadPartRequest;
    },
    OpenAI.UploadPart
  >;
}
