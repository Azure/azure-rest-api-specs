import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.MachineLearningServices;

// These definitions are to correctly nest resources under workspaces (not to redefine the definitions in swagger)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a model definition, useRef for the definition."
@doc("The properties of a machine learning workspace.")
@Autorest.useRef("workspaceRP.json#/definitions/WorkspaceProperties")
model WorkspaceProperties {}

@resource("workspaces")
@Autorest.useRef("workspaceRP.json#/definitions/Workspaces")
model Workspace  is TrackedResource <WorkspaceProperties>{
  @doc("Name of the workspace")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
  @key("workspaceName")
  @path
  @segment("workspaces")
  name: string;
}