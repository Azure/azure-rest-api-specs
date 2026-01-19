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
model GetReportResult {
  @doc("One or more result sets, in the same order as the queries in the request body")
  @identifiers(#[])
  results: ReportResultSet[];
}

/**
 * The result set of the report operation
 */
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
}
