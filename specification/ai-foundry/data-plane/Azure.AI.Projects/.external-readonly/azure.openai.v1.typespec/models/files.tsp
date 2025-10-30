import "../../typespec/files/models.tsp";

namespace AzureOpenAI;

@@withoutOmittedProperties(OpenAI.OpenAIFile, "status" | "purpose");

model AzureOpenAIFile {
  ...OpenAI.OpenAIFile;

  @doc("""
    The intended purpose of the file. Supported values are `assistants`, `assistants_output`, `batch`, `batch_output`, `fine-tune` and `fine-tune-results`.
    """)
  purpose:
    | "assistants"
    | "assistants_output"
    | "batch"
    | "batch_output"
    | "fine-tune"
    | "fine-tune-results"
    | "evals";

  status:
    | "uploaded"
    | "pending"
    | "running"
    | "processed"
    | "error"
    | "deleting"
    | "deleted";
}

union AzureFileExpiryAnchor {
  /** Defines the anchor relative to the `created_at` time. */
  created_at: "created_at",
}

@@withoutOmittedProperties(OpenAI.CreateFileRequest, "purpose");

model AzureCreateFileRequest {
  ...OpenAI.CreateFileRequest;
  expires_after: {
    seconds: int32;
    anchor: AzureFileExpiryAnchor;
  };

  @doc("""
    The intended purpose of the uploaded file. One of: - `assistants`: Used in the Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for fine-tuning - `evals`: Used for eval data sets
    """)
  purpose: "assistants" | "batch" | "fine-tune" | "evals";
}

model AzureListFilesResponse {
  object: "list";
  data: AzureOpenAIFile[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}
