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

@armProviderNamespace
@service({
  title: "Azure AI Project Services"
})
@doc("Azure AI Project Services: includes connections, AI Resource, etc.")
namespace Microsoft.MachineLearningServices;

//todo rest of workspaceRP.json

@doc("An object that represents a machine learning workspace.")
model Workspace is TrackedResource<WorkspaceProperties> {
  @doc("Name of the workspace")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
  @key("workspaceName")
  @path
  @segment("workspaces")
  name: string;

  ...ManagedServiceIdentity;
  ...ResourceSku;
  ...ResourceKind;
}

@doc("The properties of a machine learning workspace.")
model WorkspaceProperties {
  @doc("The flag to indicate whether to allow public access when behind VNet.")
  allowPublicAccessWhenBehindVnet: boolean;

 // todo stamping out the rest of this class
}

@armResourceOperations
interface Workspaces extends TrackedResourceOperations<Workspace, WorkspaceProperties> {}
