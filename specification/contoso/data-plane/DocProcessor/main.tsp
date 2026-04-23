import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(AadOauth2Auth<["https://contoso.azure.com/.default"]>)
@service(#{ title: "ContosoDocProcessor" })
@versioned(Contoso.DocProcessor.Versions)
namespace Contoso.DocProcessor;

@doc("API versions.")
enum Versions {
  @doc("Preview version.")
  v2024_01_01_Preview: "2024-01-01-preview",
}

// ============================================================================
// INTENTIONAL ISSUES FOR DEMO - These will trigger APIView feedback
// ============================================================================

// ISSUE 1: Model missing documentation on properties
@doc("A document to be processed.")
@resource("documents")
model Document {
  @key("documentId")
  @visibility(Lifecycle.Read)
  id: string;

  // Missing @doc - will trigger feedback
  name: string;

  // Missing @doc - will trigger feedback
  content: string;

  // ISSUE 2: Using string instead of url type
  sourceUrl: string;

  // Missing @doc
  status: DocumentStatus;

  // ISSUE 3: Property naming - should use camelCase consistently
  created_at?: utcDateTime;

  // Missing @doc
  processedResult?: ProcessingResult;
}

// ISSUE 4: Enum without documentation on members
enum DocumentStatus {
  pending,
  processing,
  completed,
  failed,
}

// ISSUE 5: Model with poor naming and missing docs
model ProcessingResult {
  // Bad naming: should be more descriptive
  data: string;
  
  // Missing @doc
  confidence: float32;
  
  // ISSUE 6: Using string for what should be typed
  metadata: string;
}

// ISSUE 7: Request model with missing documentation
model ProcessDocRequest {
  // Missing @doc
  documentId: string;
  
  // Missing @doc - and bad naming
  opts?: ProcessingOptions;
}

// ISSUE 8: Options model - unclear purpose
model ProcessingOptions {
  // Missing @doc
  quality: string;
  
  // Missing @doc
  timeout?: int32;
}

// ISSUE 9: Response without proper documentation
model ProcessDocResponse {
  jobId: string;
  status: string;
}

interface Documents {
  // ISSUE 10: Operation missing proper documentation
  @doc("Get document.")
  getDocument is ResourceRead<Document>;

  // ISSUE 11: Should be LongRunning but isn't marked
  @doc("Process a document.")
  @post
  @route("documents/{documentId}/process")
  processDoc(
    @path documentId: string,
    @body request: ProcessDocRequest,
  ): ProcessDocResponse;

  // ISSUE 12: List operation missing pagination
  @doc("List documents.")
  @get
  @route("documents")
  listDocs(): Document[];

  // ISSUE 13: Delete without proper async handling
  @doc("Delete document.")
  @delete
  @route("documents/{documentId}")
  deleteDoc(@path documentId: string): void;

  // ISSUE 14: Create operation - should use standard patterns
  @doc("Create document.")
  @post
  @route("documents")
  createDoc(@body document: Document): Document;
}
