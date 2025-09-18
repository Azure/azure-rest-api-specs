import "@typespec/http";
import "../files/models.tsp";
import "@typespec/openapi";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
model AddUploadPartRequest {
  /** The chunk of bytes for this Part. */
  data: HttpPart<bytes>;
}

model CompleteUploadRequest {
  /** The ordered list of Part IDs. */
  part_ids: string[];

  /** The optional md5 checksum for the file contents to verify if the bytes uploaded matches what you expect. */
  md5?: string;
}

model CreateUploadRequest {
  /** The name of the file to upload. */
  filename: string;

  /**The intended purpose of the uploaded file.

  See the [documentation on File purposes](https://platform.openai.com/docs/api-reference/files/create#files-create-purpose).*/
  purpose: "assistants" | "batch" | "fine-tune" | "vision";

  /** The number of bytes in the file you are uploading. */
  bytes: integer;

  /**The MIME type of the file.

  This must fall within the supported MIME types for your file purpose. See the supported MIME types for assistants and vision.*/
  mime_type: string;

  expires_after?: FileExpirationAfter;
}

/** The Upload object can accept byte chunks in the form of Parts. */
@summary("Upload")
@extension(
  "x-oaiMeta",
  #{
    name: "The upload object",
    example: "{\n  \"id\": \"upload_abc123\",\n  \"object\": \"upload\",\n  \"bytes\": 2147483648,\n  \"created_at\": 1719184911,\n  \"filename\": \"training_examples.jsonl\",\n  \"purpose\": \"fine-tune\",\n  \"status\": \"completed\",\n  \"expires_at\": 1719127296,\n  \"file\": {\n    \"id\": \"file-xyz321\",\n    \"object\": \"file\",\n    \"bytes\": 2147483648,\n    \"created_at\": 1719186911,\n    \"filename\": \"training_examples.jsonl\",\n    \"purpose\": \"fine-tune\",\n  }\n}\n",
  }
)
model Upload {
  /** The Upload unique identifier, which can be referenced in API endpoints. */
  id: string;

  /** The Unix timestamp (in seconds) for when the Upload was created. */
  created_at: integer;

  /** The name of the file to be uploaded. */
  filename: string;

  /** The intended number of bytes to be uploaded. */
  bytes: integer;

  /** The intended purpose of the file. [Please refer here](https://platform.openai.com/docs/api-reference/files/object#files/object-purpose) for acceptable values. */
  purpose: string;

  /** The status of the Upload. */
  status: "pending" | "completed" | "cancelled" | "expired";

  /** The Unix timestamp (in seconds) for when the Upload will expire. */
  expires_at: integer;

  /** The object type, which is always "upload". */
  @extension("x-stainless-const", true)
  object: "upload";

  file?: OpenAIFile;
}

/** The upload Part represents a chunk of bytes we can add to an Upload object. */
@summary("UploadPart")
@extension(
  "x-oaiMeta",
  #{
    name: "The upload part object",
    example: "{\n    \"id\": \"part_def456\",\n    \"object\": \"upload.part\",\n    \"created_at\": 1719186911,\n    \"upload_id\": \"upload_abc123\"\n}\n",
  }
)
model UploadPart {
  /** The upload Part unique identifier, which can be referenced in API endpoints. */
  id: string;

  /** The Unix timestamp (in seconds) for when the Part was created. */
  created_at: integer;

  /** The ID of the Upload object that this Part was added to. */
  upload_id: string;

  /** The object type, which is always `upload.part`. */
  @extension("x-stainless-const", true)
  object: "upload.part";
}
