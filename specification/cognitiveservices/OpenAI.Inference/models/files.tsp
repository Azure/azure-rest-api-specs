import "@typespec/versioning";

import "../main.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@doc("Represents an assistant that can call the model and use tools.")
@added(ServiceApiVersions.v2024_07_01_Preview)
model OpenAIFile {
  @doc("The object type, which is always 'file'.")
  object: "file";

  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The size of the file, in bytes.")
  bytes: int32;

  @doc("The name of the file.")
  filename: string;

  @encodedName("application/json", "created_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this object was created.")
  createdAt: utcDateTime;

  @doc("The intended purpose of a file.")
  purpose: FilePurpose;

  /** The state of the file. This field is available in Azure OpenAI only. */
  status?: FileState;

  /** The error message with details in case processing of this file failed. This field is available in Azure OpenAI only. */
  @encodedName("application/json", "status_details")
  statusDetails?: string;
}

/** The state of the file. */
@added(ServiceApiVersions.v2024_07_01_Preview)
union FileState {
  string,

  /**
   * The file has been uploaded but it's not yet processed. This state is not returned by Azure OpenAI and exposed only for
   * compatibility. It can be categorized as an inactive state.
   */
  uploaded: "uploaded",

  /**
   * The operation was created and is not queued to be processed in the future. It can be categorized as an inactive state.
   */
  pending: "pending",

  /** The operation has started to be processed. It can be categorized as an active state. */
  running: "running",

  /**
   * The operation has successfully processed and is ready for consumption. It can be categorized as a terminal state.
   */
  processed: "processed",

  /**
   * The operation has completed processing with a failure and cannot be further consumed. It can be categorized as a terminal state.
   */
  error: "error",

  /**
   * The entity is in the process to be deleted. This state is not returned by Azure OpenAI and exposed only for compatibility.
   * It can be categorized as an active state.
   */
  deleting: "deleting",

  /**
   * The entity has been deleted but may still be referenced by other entities predating the deletion. It can be categorized as a
   * terminal state.
   */
  deleted: "deleted",
}

/** The possible values denoting the intended usage of a file. */
@added(ServiceApiVersions.v2024_07_01_Preview)
union FilePurpose {
  string,

  /** Indicates a file is used for fine tuning input. */
  fineTune: "fine-tune",

  /** Indicates a file is used for fine tuning results. */
  fineTuneResults: "fine-tune-results",

  /** Indicates a file is used as input to assistants. */
  assistants: "assistants",

  /** Indicates a file is used as output by assistants. */
  assistantsOutput: "assistants_output",

  /** Indicates a file is used as input to . */
  batch: "batch",

  /** Indicates a file is used as output by a vector store batch operation. */
  batchOutput: "batch_output",

  /** Indicates a file is used as input to a vision operation. */
  vision: "vision",
}

@doc("The response data from a file list operation.")
@added(ServiceApiVersions.v2024_07_01_Preview)
model FileListResponse {
  @doc("The object type, which is always 'list'.")
  object: "list";

  @doc("The files returned for the request.")
  data: OpenAIFile[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "https://github.com/Azure/autorest.csharp/issues/4041"
@doc("A status response from a file deletion operation.")
@added(ServiceApiVersions.v2024_07_01_Preview)
model FileDeletionStatus {
  @doc("The ID of the resource specified for deletion.")
  id: string;

  @doc("A value indicating whether deletion was successful.")
  deleted: boolean;

  @doc("The object type, which is always 'file'.")
  object: "file";
}
