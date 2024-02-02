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
@resource("indexes")
model Index {
  @key("indexName")
  @doc("Name of the index.")
  @visibility("external")
  indexName: string;
}

@doc("AssetVersion Definition")
@parentResource(Index)
@resource("versions")
model AssetVersion {
  
  @key("indexVersion")
  @doc("Version of the index.")
  @visibility("external")
  indexVersionNum: string;

  @doc("Name of the index.")
  @visibility("read")
  name: string;

  @doc("Version of the index.")
  @visibility("read")
  version: string;

  @doc("Update stage to 'Archived' for soft delete.")
  isArchived: boolean = false;

  @doc("Description information of the asset.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Asset's tags.")
  tags?: Record<string>;

  @doc("Asset's properties.")
  properties?: Record<string>;
}

@doc("Index resource Definition")
model IndexVersion is AssetVersion {

  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  storageUri: string;
}

@doc("Paged collection of IndexVersion items.")
model IndexVersionList is Azure.Core.Page<IndexVersion>;

