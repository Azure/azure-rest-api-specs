import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;


// todo do we still need to nest under workspaces? If so just route that here? 
@doc("IndexVersion Definition")
@parentResource(IndexContainer)
@resource("versions")
model IndexVersion {
  @key("indexVersion")
  @doc("Version of the index.")
  indexVersion: string;

  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  storageUri: string;

  @doc("Placeholder for extras.")
  indexConfigurations: Record<string>
}

@doc("Index properties")
@resource("indexes")
model IndexContainer {
  @key("indexName")
  @doc("Name of the index.")
  indexName: string;

  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  indexVersion: string;

  @doc("Placeholder for extras.")
  indexVersionDefinition: IndexVersion
}
