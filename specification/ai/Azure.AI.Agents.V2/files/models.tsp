import "@typespec/openapi";
import "@typespec/http";
using TypeSpec.OpenAPI;
using TypeSpec.Http;
namespace OpenAI;
model CreateFileRequest {
  /** The File object (not file name) to be uploaded. */
  @extension("x-oaiMeta", #{ exampleFilePath: "fine-tune.jsonl" })
  file: HttpPart<bytes>;

  purpose: HttpPart<FilePurpose>;
  expires_after?: HttpPart<FileExpirationAfter>;
}

/** The expiration policy for a file. By default, files with `purpose=batch` expire after 30 days and all other files are persisted until they are manually deleted. */
@summary("File expiration policy")
model FileExpirationAfter {
  /** Anchor timestamp after which the expiration policy applies. Supported anchors: `created_at`. */
  @extension("x-stainless-const", true)
  anchor: "created_at";

  /** The number of seconds after the anchor time that the file will expire. Must be between 3600 (1 hour) and 2592000 (30 days). */
  @maxValue(2592000)
  @minValue(3600)
  seconds: integer;
}

model DeleteFileResponse {
  id: string;

  @extension("x-stainless-const", true)
  object: "file";

  deleted: boolean;
}

model ListFilesResponse {
  object: string;
  data: OpenAIFile[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

/** The `File` object represents a document that has been uploaded to OpenAI. */
@summary("OpenAIFile")
@extension(
  "x-oaiMeta",
  #{
    name: "The file object",
    example: "{\n  \"id\": \"file-abc123\",\n  \"object\": \"file\",\n  \"bytes\": 120000,\n  \"created_at\": 1677610602,\n  \"expires_at\": 1680202602,\n  \"filename\": \"salesOverview.pdf\",\n  \"purpose\": \"assistants\",\n}\n",
  }
)
model OpenAIFile {
  /** The file identifier, which can be referenced in the API endpoints. */
  id: string;

  /** The size of the file, in bytes. */
  bytes: integer;

  /** The Unix timestamp (in seconds) for when the file was created. */
  created_at: integer;

  /** The Unix timestamp (in seconds) for when the file will expire. */
  expires_at?: integer;

  /** The name of the file. */
  filename: string;

  /** The object type, which is always `file`. */
  @extension("x-stainless-const", true)
  object: "file";

  /** The intended purpose of the file. Supported values are `assistants`, `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`, `vision`, and `user_data`. */
  purpose:
    | "assistants"
    | "assistants_output"
    | "batch"
    | "batch_output"
    | "fine-tune"
    | "fine-tune-results"
    | "vision"
    | "user_data";

  /** Deprecated. The current status of the file, which can be either `uploaded`, `processed`, or `error`. */
  status: "uploaded" | "processed" | "error";

  /** Deprecated. For details on why a fine-tuning training file failed validation, see the `error` field on `fine_tuning.job`. */
  status_details?: string;
}

/** The intended purpose of the uploaded file. One of: - `assistants`: Used in the Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`: Flexible file type for any purpose - `evals`: Used for eval data sets */
enum FilePurpose {
  assistants,
  batch,
  `fine-tune`,
  vision,
  user_data,
  evals,
}
