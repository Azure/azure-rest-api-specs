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
@parentResource(Workspace)
// TODO Registries isn't working...
@parentResource(Registry)
@resource("indexes")
model Index {
  @key("name")
  @doc("Name of the index.")
  @visibility("external")
  name: string;

  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  indexVersion: string;

  @doc("Placeholder for extras.")
  indexVersionDefinition: IndexVersion
}


// todo do we still need to nest under workspaces? If so just route that here? 
@doc("IndexVersion Definition")
@parentResource(Index)
@resource("versions")
model IndexVersion {
  @key("version")
  @doc("Version of the index.")
  @visibility("external")
  version: string;

  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  storageUri: string;

  @doc("Placeholder for extras.")
  indexConfigurations: Record<string>
}
