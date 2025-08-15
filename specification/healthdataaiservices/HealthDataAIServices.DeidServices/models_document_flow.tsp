import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using Azure.Core;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AI Casing style to match OpenAI"
namespace HealthDataAIServices.DeidServices;

@doc("A job containing a batch of documents to de-identify.")
@resource("jobs")
model DeidentificationJob {
  @key
  @doc("The name of a job.")
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(3) // Must be 3 to match regex
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]+[a-zA-Z0-9]$")
  @clientName("jobName", "csharp,java,python")
  name: string;

  @doc("Operation to perform on the input documents.")
  @clientName("operationType", "csharp,java,python")
  operation?: DeidentificationOperationType = DeidentificationOperationType.Surrogate;

  @doc("Storage location to perform the operation on.")
  sourceLocation: SourceStorageLocation;

  @doc("Target location to store output of operation.")
  targetLocation: TargetStorageLocation;

  @doc("Customization parameters to override default service behaviors.")
  customizations?: DeidentificationJobCustomizationOptions;

  // Readonly Properties

  @doc("Current status of a job.")
  @visibility(Lifecycle.Read)
  status: Azure.Core.Foundations.OperationState;

  @doc("Error when job fails in it's entirety.")
  @visibility(Lifecycle.Read)
  error?: Azure.Core.Foundations.Error;

  @doc("""
    Date and time when the job was completed.
    
    If the job is canceled, this is the time when the job was canceled.
    
    If the job failed, this is the time when the job failed.
    """)
  @visibility(Lifecycle.Read)
  lastUpdatedAt: utcDateTime;

  @doc("Date and time when the job was created.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("Date and time when the job was started.")
  @visibility(Lifecycle.Read)
  startedAt?: utcDateTime;

  @doc("Summary of a job. Exists only when the job is completed.")
  @visibility(Lifecycle.Read)
  summary?: DeidentificationJobSummary;
}

@doc("Summary metrics of a job.")
model DeidentificationJobSummary {
  @doc("Number of documents that have completed.")
  @clientName("successfulCount", "csharp,java,python")
  successful: int32;

  @doc("Number of documents that have failed.")
  @clientName("failedCount", "csharp,java,python")
  failed: int32;

  @doc("Number of documents that have been canceled.")
  @clientName("canceledCount", "csharp,java,python")
  canceled: int32;

  @doc("Number of documents total.")
  @clientName("totalCount", "csharp,java,python")
  total: int32;

  @doc("Number of bytes processed.")
  bytesProcessed: int64;
}

@doc("Details of a single document in a job.")
@parentResource(DeidentificationJob)
@resource("documents")
@access(Access.public, "csharp,python")
model DeidentificationDocumentDetails {
  @key
  @doc("Id of the document details.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Location for the input.")
  @clientName("inputLocation", "csharp,java,python")
  input: DeidentificationDocumentLocation;

  @doc("Location for the output.")
  @clientName("outputLocation", "csharp,java,python")
  output?: DeidentificationDocumentLocation;

  @doc("Status of the document.")
  status: Azure.Core.Foundations.OperationState;

  @doc("Error when document fails.")
  error?: Azure.Core.Foundations.Error;
}

@doc("Location of a document.")
model DeidentificationDocumentLocation {
  @doc("Location of document in storage.")
  @maxLength(1024)
  location: url;

  ...EtagProperty;
}

// TODO: Add documentation link for customization options.
@doc("Customizations options to override default service behaviors for job usage.")
model DeidentificationJobCustomizationOptions {
  ...SharedCustomizationOptions;
}

@doc("Storage location.")
model SourceStorageLocation {
  @doc("URL to storage location.")
  location: url;

  @doc("Prefix to filter path by.")
  @maxLength(1024)
  prefix: string;

  @doc("List of extensions to filter path by.")
  @minItems(1)
  extensions?: Array<string> = #["*"];
}

@doc("Storage location.")
model TargetStorageLocation {
  @doc("URL to storage location.")
  location: url;

  @doc("""
    Replaces the input prefix of a file path with the output prefix, preserving the rest of the path structure.
    
    Example:
    File full path: documents/user/note.txt
    Input Prefix: "documents/user/"
    Output Prefix: "output_docs/"
    
    Output file: "output_docs/note.txt"
    """)
  @maxLength(1024)
  prefix: string;

  @doc("When set to true during a job, the service will overwrite the output location if it already exists.")
  overwrite?: boolean = false;
}
