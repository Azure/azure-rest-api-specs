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

// Workspace definitions are to correctly nest resources under workspaces (not to redefine the definitions in swagger)
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

@doc("Asset based class.")
model AssetBased extends ResourceBase {
  @doc("Is the asset archived? For types where Stage is defined, when Stage is provided it will be used to populate IsArchived.")
  isArchived: boolean;

  @doc("If the name version are system generated (anonymous registration). For types where Stage is defined, when Stage is provided it will be used to populate IsAnonymous.")
  isAnonymous: boolean;
}

@doc("Resource Base class.")
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "property bag is a required attribute for all our resources"
model ResourceBase {
  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags: Record<string>;

  @doc("The asset property dictionary.")
  properties: Record<string>;
}