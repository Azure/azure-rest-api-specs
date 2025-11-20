import "@typespec/versioning";

import "../main.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

/** The request body of an upload creation operation. */
@added(ServiceApiVersions.v2024_08_01_Preview)
model CreateUploadRequest {
  /** The name of the file to upload. */
  filename: string;

  // Reference: https://platform.openai.com/docs/api-reference/files/create#files-create-purpose
  /**
   * The intended purpose of the uploaded file.
   *
   * Use 'assistants' for Assistants and Message files, 'vision' for Assistants image file inputs, 'batch' for Batch API, and 'fine-tune' for Fine-tuning.
   */
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  purpose: string | "assistants" | "batch" | "fine-tune" | "vision";

  /** The number of bytes in the file you are uploading. */
  bytes: int32;

  /**
   * The MIME type of the file.
   *
   * This must fall within the supported MIME types for your file purpose. See the supported MIME types for assistants and vision.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  mime_type: string;
}

/** The multipart/form-data request body of a data part addition request for an upload. */
@added(ServiceApiVersions.v2024_08_01_Preview)
model AddUploadPartRequest {
  /** The chunk of bytes for this Part. */
  data: Http.HttpPart<bytes>;
}

/** The request body of an upload completion request. */
@added(ServiceApiVersions.v2024_08_01_Preview)
model CompleteUploadRequest {
  /** The ordered list of Part IDs. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  part_ids: string[];

  /** The optional md5 checksum for the file contents to verify if the bytes uploaded matches what you expect. */
  md5?: string;
}

/** The Upload object can accept byte chunks in the form of Parts. */
@added(ServiceApiVersions.v2024_08_01_Preview)
model Upload {
  /** The Upload unique identifier, which can be referenced in API endpoints. */
  id: string;

  // Tool customization: 'created' and fields ending in '_at' are Unix encoded utcDateTime
  /** The Unix timestamp (in seconds) for when the Upload was created. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @encode("unixTimestamp", int32)
  created_at: utcDateTime;

  /** The name of the file to be uploaded. */
  filename: string;

  /** The intended number of bytes to be uploaded. */
  bytes: int64;

  // Reference: https://platform.openai.com/docs/api-reference/files/object#files/object-purpose
  /** The intended purpose of the file. */
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  purpose:
    | string
    | "batch"
    | "batch_output"
    | "fine-tune"
    | "fine-tune-results"
    | "assistants"
    | "assistants_output"
    | "vision";

  /** The status of the Upload. */
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  status: string | "pending" | "completed" | "cancelled" | "expired";

  // Tool customization: 'created' and fields ending in '_at' are Unix encoded utcDateTime
  /** The Unix timestamp (in seconds) for when the Upload was created. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @encode("unixTimestamp", int32)
  expires_at: utcDateTime;

  /** The object type, which is always "upload". */
  object?: "upload";

  /** The ready File object after the Upload is completed. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicitly nullable types"
  file?: OpenAIFile | null;
}

/** The upload Part represents a chunk of bytes we can add to an Upload object. */
@added(ServiceApiVersions.v2024_08_01_Preview)
model UploadPart {
  /** The upload Part unique identifier, which can be referenced in API endpoints. */
  id: string;

  // Tool customization: 'created' and fields ending in '_at' are Unix encoded utcDateTime
  /** The Unix timestamp (in seconds) for when the Part was created. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @encode("unixTimestamp", int32)
  created_at: utcDateTime;

  /** The ID of the Upload object that this Part was added to. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  upload_id: string;

  @doc("""
    The object type, which is always `upload.part`.
    """)
  object: "upload.part";

  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("""
    Azure only field.
    """)
  azure_block_id?: string;
}
