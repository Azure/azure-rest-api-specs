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
model Index is ProxyResource<IndexVersionProperties> {
  @doc("Name of the index")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("indexName")
  @path
  @segment("indexes")
  name: string;
}

@doc("Index Version resource")
@parentResource(Index)
model IndexVersion is ProxyResource<IndexVersionProperties> {
  @doc("version of the index")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("versionName")
  @path
  @segment("versions")
  name: string;
}

// todo move to common
@doc("Resource Base class.")
model ResourceBase {
  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags: Record<string>;

  @doc("The asset property dictionary.")
  properties: Record<string>;
}

// todo move to common
@doc("Asset based class.")
model AssetBased extends ResourceBase {
  @doc("Is the asset archived? For types where Stage is defined, when Stage is provided it will be used to populate IsArchived.")
  isArchived: boolean;

  @doc("If the name version are system generated (anonymous registration). For types where Stage is defined, when Stage is provided it will be used to populate IsAnonymous.")
  isAnonymous: boolean;
}

@doc("Index properties")
model IndexVersionProperties extends AssetBased {
  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  storageUri: string;

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

interface ProxyResourceOperationsIndexesVersions<
  TResource extends ArmResource,
  TListParameters extends {} = {}
>
  extends ResourceListByParent<
      TResource,
      TListParameters & BaseParameters<TResource>
    > {
  @doc("Get a Index.")
  get is ArmResourceRead<TResource>;
  @doc("Create a Index.")
  createOrUpdate is ArmResourceCreateOrUpdateSync<TResource>;
  @doc("List by parent.")
  listByParent is ArmResourceListByParent<TResource>
}

@armResourceOperations
interface IndexesVersions extends ProxyResourceOperationsIndexesVersions<IndexVersion, ListQueryParameters>{}

@armResourceOperations(Index)
interface Indexes {
  @doc("List the latest indexes per name.")
  listByParent is ArmResourceListByParent<Index>
}
