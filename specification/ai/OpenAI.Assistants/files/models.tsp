import "@typespec/versioning";

namespace Azure.AI.OpenAI.Assistants;

using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@doc("Represents an assistant that can call the model and use tools.")
@added(ServiceApiVersions.v2024_02_15_preview)
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
}

@doc("The possible values denoting the intended usage of a file.")
@added(ServiceApiVersions.v2024_02_15_preview)
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
}

@doc("The response data from a file list operation.")
@added(ServiceApiVersions.v2024_02_15_preview)
model FileListResponse {
  @doc("The object type, which is always 'list'.")
  object: "list";

  @doc("The files returned for the request.")
  data: OpenAIFile[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "https://github.com/Azure/autorest.csharp/issues/4041"
@doc("A status response from a file deletion operation.")
@added(ServiceApiVersions.v2024_02_15_preview)
model FileDeletionStatus {
  ...DeletionStatus;

  @doc("The object type, which is always 'file'.")
  object: "file";
}
