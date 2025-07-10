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
