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
  @Autorest.useRef("../../../../resource-manager/Microsoft.MachineLearningServices/stable/2023-10-01/machineLearningServices.json#/parameters/WorkspaceNameParameter")
  name: string;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {

  @visibility("read")
  @doc("The timestamp the resource was created at.")
  createdAt?: utcDateTime;

  @visibility("read")
  @doc("The identity that created the resource.")
  createdBy?: string;

  @visibility("read")
  @doc("The identity type that created the resource.")
  createdByType?: string;

  @visibility("read")
  @doc("The timestamp of resource last modification (UTC)")
  lastModifiedAt?: utcDateTime;
}

