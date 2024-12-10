import "@typespec/versioning";

import "../main.tsp";

namespace Microsoft.MachineLearningServices;

using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@doc("Represents an assistant that can call the model and use tools.")
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

  @doc("The state of the file. This field is available in Azure OpenAI only.")
  status?: FileState;

  @encodedName("application/json", "status_details")
  @doc("The error message with details in case processing of this file failed. This field is available in Azure OpenAI only.")
  statusDetails?: string;
}

@doc("The state of the file.")
union FileState {
  string,

  @doc("The file has been uploaded but it's not yet processed. This state is not returned by Azure OpenAI and exposed only for compatibility. It can be categorized as an inactive state.")
  uploaded: "uploaded",

  @doc("The operation was created and is not queued to be processed in the future. It can be categorized as an inactive state.")
  pending: "pending",

  @doc("The operation has started to be processed. It can be categorized as an active state.")
  running: "running",

  @doc("The operation has successfully processed and is ready for consumption. It can be categorized as a terminal state.")
  processed: "processed",

  @doc("The operation has completed processing with a failure and cannot be further consumed. It can be categorized as a terminal state.")
  error: "error",

  @doc("The entity is in the process to be deleted. This state is not returned by Azure OpenAI and exposed only for compatibility. It can be categorized as an active state.")
  deleting: "deleting",

  @doc("The entity has been deleted but may still be referenced by other entities predating the deletion. It can be categorized as a terminal state.")
  deleted: "deleted",
}

@doc("The possible values denoting the intended usage of a file.")
union FilePurpose {
  string,

  @doc("Indicates a file is used for fine tuning input.")
  fineTune: "fine-tune",

  @doc("Indicates a file is used for fine tuning results.")
  fineTuneResults: "fine-tune-results",

  @doc("Indicates a file is used as input to assistants.")
  assistants: "assistants",

  @doc("Indicates a file is used as output by assistants.")
  assistantsOutput: "assistants_output",

  @doc("Indicates a file is used as input to batch operations.")
  batch: "batch",

  @doc("Indicates a file is used as output by a vector store batch operation.")
  batchOutput: "batch_output",

  @doc("Indicates a file is used as input to a vision operation.")
  vision: "vision",
}

@doc("The response data from a file list operation.")
model FileListResponse {
  @doc("The object type, which is always 'list'.")
  object: "list";

  @doc("The files returned for the request.")
  data: OpenAIFile[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "https://github.com/Azure/autorest.csharp/issues/4041"
@doc("A status response from a file deletion operation.")
model FileDeletionStatus {
  ...DeletionStatus;

  @doc("The object type, which is always 'file'.")
  object: "file";
}
