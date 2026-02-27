import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "@typespec/rest";
import "./versions.tsp";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.StorageDiscovery;

/**
 * Request to get StorageDiscoveryWorkspace data from ADX
 */
@added(ApiVersion.v2025_04_01_preview)
@renamedFrom(ApiVersion.v2025_06_01_preview, "GetReportRequest")
model GetReportContent {
  @doc("""
    The queries to execute against Storage Discovery data.
    Format: Base64-encoded JSON object with structure:
    {"queries":[{"name":"queryName","query":"KQL query"}]}
    For query syntax and available tables, see: https://aka.ms/storageDiscoveryQuery
    """)
  queries: string[];
}

/**
 * The response of the report operation
 */
@added(ApiVersion.v2025_04_01_preview)
model GetReportResult {
  @doc("One or more result sets, in the same order as the queries in the request body")
  @identifiers(#[])
  results: ReportResultSet[];
}

/**
 * The result set of the report operation
 */
@added(ApiVersion.v2025_04_01_preview)
model ReportResultSet {
  @doc("Array of columns object, present only if the query succeeded")
  @identifiers(#[])
  columns?: ReportResultColumn[];

  @doc("Array of all rows from ADX, present only if the query succeeded")
  @identifiers(#[])
  rows?: string[][];

  @doc("Provides an error about the query, present only if the query fails")
  errorCode?: string;
}

/**
 * The column of the response result set
 */
@added(ApiVersion.v2025_04_01_preview)
model ReportResultColumn {
  @doc("Name of the column")
  name: string;

  @doc("ADX type of the column")
  type: string;
}
/**
 * A Storage Discovery Workspace resource. This resource configures the collection of storage account metrics.
 */
@doc("A Storage Discovery Workspace resource. This resource configures the collection of storage account metrics.")
model StorageDiscoveryWorkspace
  is Azure.ResourceManager.TrackedResource<StorageDiscoveryWorkspaceProperties> {
  @doc("The name of the StorageDiscoveryWorkspace")
  @key("storageDiscoveryWorkspaceName")
  @segment("storageDiscoveryWorkspaces")
  @path
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z][a-zA-Z0-9]*(-[a-zA-Z0-9]+)*$")
  @minLength(4)
  @maxLength(64)
  name: string;

  /**
   * The managed service identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("The identity of the Storage Discovery Workspace.")
  @added(ApiVersion.v2026_07_01_preview)
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}
