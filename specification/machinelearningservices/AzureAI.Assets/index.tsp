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
model Index is ProxyResource<IndexContainerProperties> {
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

@doc("Index properties")
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "not a long running resource"
model IndexVersionProperties extends AssetBased {
  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  storageUri: string;

  @doc("Placeholder for extras.")
  indexConfigurations: Record<string>
}

@doc("Index properties")
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "not a long running resource"
model IndexContainerProperties extends AssetBased {
  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  indexVersion: string;

  @doc("Placeholder for extras.")
  indexVersionDefinition: IndexVersionProperties
}

// note this is a common ref (todo)
@doc("[ListViewType.ActiveOnly, ListViewType.ArchivedOnly, ListViewType.All]View type for including/excluding (for example) archived entities.")
model CustomListViewQueryParameter {
  @query("listViewType")
  @doc("Defines what set of entities to return in list, default active only.")
  listViewType?: string = "ActiveOnly";
}

@doc("Filter for items with a given label.")
model CustomLabelQueryParameter {
  @query("label")
  @doc("If set to true, $latest provides the latest of each index.")
  label?: string;
}

alias ListQueryParameters = {
  ...CustomLabelQueryParameter;
  ...CustomListViewQueryParameter;
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
  createOrUpdate is ArmResourceCreateOrReplaceSync<TResource>;
}

@armResourceOperations
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Proxy resource, not required, we use archive instead."
interface IndexesVersions extends ProxyResourceOperationsIndexesVersions<IndexVersion, ListQueryParameters>{}

@armResourceOperations(Index)
interface Indexes {
  @doc("List the latest indexes per name.")
  listByParent is ArmResourceListByParent<Index>
}
