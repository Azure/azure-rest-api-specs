import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;


namespace Microsoft.MachineLearningServices;

@doc("Index resource")
@parentResource(Workspace)
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

@doc("Resource Base class.")
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "property bag is a required attribute for all our resources"
model ResourceBase {
  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags: Record<string>;

  @doc("The asset property dictionary.")
  properties: Record<string>;
}

@doc("Asset based class.")
model AssetBased extends ResourceBase {
  @doc("Is the asset archived? For types where Stage is defined, when Stage is provided it will be used to populate IsArchived.")
  isArchived: boolean;

  @doc("If the name version are system generated (anonymous registration). For types where Stage is defined, when Stage is provided it will be used to populate IsAnonymous.")
  isAnonymous: boolean;
}

@doc("Index properties")
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "not a long running resource"
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

alias ListQueryParameters = {
  ...CustomLatestQueryParameter;
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
}

@armResourceOperations
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Proxy resource, not required, we use archive instead."
interface IndexesVersions extends ProxyResourceOperationsIndexesVersions<IndexVersion, ListQueryParameters>{}

@armResourceOperations(Index)
interface Indexes {
  @doc("List the latest indexes per name.")
  listByParent is ArmResourceListByParent<Index>
}
