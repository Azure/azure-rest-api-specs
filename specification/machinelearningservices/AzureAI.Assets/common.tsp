import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.MachineLearningServices;

// Workspace definitions are to correctly nest resources under workspaces (not to redefine the definitions in swagger)
@doc("Machine learning workspace.")
@Autorest.useRef("workspaceRP.json#/definitions/Workspaces")
@resource("workspaces")
model Workspace {
  @doc("Name of the workspace")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
  @key("workspaceName")
  @segment("workspaces")
  @visibility("external")
  @Autorest.useRef("machineLearningServices.json#/parameters/WorkspaceNameParameter")
  name: string;
}

// Registry definitions are to correctly nest resources under workspaces (not to redefine the definitions in swagger)
@doc("Machine learning registry.")
@Autorest.useRef("registies.json#/definitions/Registry")
@resource("registries")
model Registry {
  @doc("Name of the registry")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
  @key("registryName")
  @visibility("external")
  @Autorest.useRef("registries.json#/parameters/RegistryNameParameter")
  name: string;
}

@doc("Asset based class.")
model AssetBase is ResourceBase {
  @doc("Is the asset archived? For types where Stage is defined, when Stage is provided it will be used to populate IsArchived.")
  isArchived: boolean;

  @doc("If the name version are system generated (anonymous registration). For types where Stage is defined, when Stage is provided it will be used to populate IsAnonymous.")
  isAnonymous: boolean;
}

@doc("Resource Base class.")
model ResourceBase {
  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags: Record<string>;

  @doc("The asset property dictionary.")
  properties: Record<string>;
}