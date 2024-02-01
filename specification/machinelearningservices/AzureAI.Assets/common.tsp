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

@doc("The identity information associated with creation of the resource.")
model CreatedBy {
  @visibility("read")
  @doc("The user identity object Id that created the resource.")
  userObjectId: string;

  @visibility("read")
  @doc("The tenantId that created the resource.")
  userTenantId: string;

  @visibility("read")
  @doc("The user name that created the resource.")
  userName: string;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @visibility("read")
  @doc("The identity that created the resource.")
  createdBy: CreatedBy;

  @visibility("read")
  @doc("The type of identity that created the resource.")
  createTime?: utcDateTime;

  @visibility("read")
  @doc("The timestamp of resource last modification (UTC)")
  modifiedTime?: utcDateTime;
}

