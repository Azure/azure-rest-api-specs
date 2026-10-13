import "@typespec/versioning";

using TypeSpec.Versioning;

@versioned(Microsoft.Discovery.Bookshelf.Versions)
namespace Microsoft.Discovery.Bookshelf;

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Parameters for indexing operation")
model IndexingRequest {
  @doc("Node pool ID")
  @madeOptional(Versions.`2026-06-01`)
  nodePoolId?: string;

  @doc("Project ID")
  projectId?: string;

  @removed(Versions.`2026-02-01-preview`)
  @doc("Storage ID")
  storageId?: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Supercomputer run ID")
model IndexingResponse {
  @doc("Run ID")
  runId: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("The search action request body.")
@added(Versions.`2026-06-01`)
model SearchRequest {
  @doc("The query text to search against the knowledge base.")
  query: string;
}
