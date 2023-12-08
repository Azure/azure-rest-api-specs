import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
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

@doc("Provides the '$latest' query parameter for list operations.")
model CustomLatestQueryParameter {
  @query("$latest")
  @doc("If set to true, $latest provides the latest of each index.")
  latest?: boolean;
}

@doc("Provides the '$includeAllVersions' query parameter for list operations.")
model CustomIncludeAllVersionsQueryParameter {
  @query("$includeAllVersions")
  @doc("Return all the versions.")
  includeAllVersions?: boolean;
}

alias ListQueryParameters = {
  ...CustomLatestQueryParameter;
  ...CustomIncludeAllVersionsQueryParameter;
  ...StandardListQueryParameters;
};


interface ProxyResourceOperationsIndexes<
  TResource extends ArmResource,
  TListParameters extends {} = {}
>
  extends ResourceListByParent<
      TResource,
      TListParameters & BaseParameters<TResource>
    > {
  @doc("Get a Index.")
  get is ArmResourceRead<Index>;
  @doc("Create a Index.")
  createOrUpdate is ArmResourceCreateOrUpdateSync<Index>;
  @doc("Delete a Index.")
  delete is ArmResourceDeleteSync<Index>;
}

@armResourceOperations
interface Indexes extends ProxyResourceOperationsIndexes<Index, ListQueryParameters>{}
