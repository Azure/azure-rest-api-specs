import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft.MachineLearningServices management service",
  version: "2024-01-01-preview",
})
@doc("Microsoft.MachineLearningServices Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.MachineLearningServices;

@doc("Index resource")
model Index is ProxyResource<IndexProperties> {
  @doc("Name of the index")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("indexName")
  @path
  @segment("indexes")
  name: string;
}

@doc("Index properties")
model IndexProperties {
  @doc("Reference to the Index this index was versioned off of. Null implies creation of a new versioned set.")
  previousVersionIndexId: string;

  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  storageUri: string;

  @doc("Set by system: format {Major-Version}.{Minor-Version}. Example 3.5, major version 3 minor version 5.")
  @visibility("read")
  version: string;

  @doc("Placeholder for extras.")
  indexConfigurations: Record<string>
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Indexes {
  get is ArmResourceRead<Index>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Index>;
  update is ArmResourcePatchSync<Index, IndexProperties>;
  delete is ArmResourceDeleteSync<Index>;
  listByResourceGroup is ArmResourceListByParent<Index>;
  listBySubscription is ArmListBySubscription<Index>;
}
