import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.MachineLearningServices;


@doc("Index asset definition.")
// todo modeling for container...
@resource("indexes")
model Index {
  @key("name")
  @doc("Name of the index.")
  @visibility("external")
  name: string;

  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  indexVersion: string;

  @doc("Index version definition.")
  indexVersionDefinition: IndexVersion
}


@doc("IndexSpec Definition")
model IndexSpec {

  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  storageUri: string;

  @doc("Placeholder for extras.")
  indexConfigurations?: Record<string>
}

@doc("Asset type definition.")
enum AssetType {
  @doc("AssetVersion Definition")
  Index: "Index"
}

// finish definition
@doc("AssetVersion Definition")
@parentResource(Index)
@resource("versions")
model AssetVersionDto<T> {
  @key("version")
  @doc("Version of the index.")
  @visibility("external")
  version: string;

  @doc("Display name.")
  displayName?: string;

  @doc("Lifecycle stage of the asset. Stage populates IsArchived.")
  stage?: string;

  @doc("Description information of the asset.")
  description?: string;

  @doc("Capability type of the asset.")
  @visibility("read")
  capabilities?: Record<AssetCapabilityType>;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Asset's tags.")
  tags?: Record<string>;

  @doc("Asset's properties.")
  properties?: Record<string>;

  @doc("Asset's relationship.")
  relationships?: Record<Relationship>;

  @doc("AssetSpec definition.")
  assetSpec: T;
}

@doc("Index resource Definition")
model IndexVersion is AssetVersionDto<IndexSpec> {

  @doc("Index asset type.")
  type: AssetType = AssetType.Index;
}

@doc("Paged collection of IndexVersion items.")
model IndexVersionList is Azure.Core.Page<IndexVersion>;

@doc("Paged collection of Index items.")
model IndexList is Azure.Core.Page<Index>;
