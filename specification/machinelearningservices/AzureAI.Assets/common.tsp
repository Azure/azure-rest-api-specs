import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.MachineLearningServices;

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @visibility("read")
  @doc("The identity that created the resource.")
  createdBy: string;

  @visibility("read")
  @doc("The type of identity that created the resource.")
  createTime?: plainDate;

  @visibility("read")
  @doc("The timestamp of resource last modification (UTC)")
  modifiedTime?: plainDate;
}

@doc("Lineage with other assets.")
model Relationship {

  @doc("AssetId of the other asset.")
  assetId: string;

  @doc("AssetType of the other asset.")
  assetType: string;

  @doc("State of relationship.")
  state: string;

  @doc("Type of relationship.")
  type: string;
}

// Todo get review from Micky
@doc("Asset capability type definition.")
enum AssetCapabilityType {
  @doc("Uri denotes a folder.")
  UriFolder,
  @doc("Uri denotes a file.")
  UriFile
}