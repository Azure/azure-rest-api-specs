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
  title: "Azure Machine Learning Services",
  version: "2024-01-01-preview",
})
@doc("Microsoft.MachineLearningServices Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.MachineLearningServices;

//todo rest of workspaceRP.json

@doc("An object that represents a machine learning workspace.")
model Workspace is TrackedResource<WorkspaceProperties> {
  @doc("Name of the workspace")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
  @key("WorkspaceName")
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
interface workspaces extends TrackedResourceOperations<Workspace, WorkspaceProperties> {}
