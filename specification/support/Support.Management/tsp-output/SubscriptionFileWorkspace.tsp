import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Support;
@doc("Object that represents FileWorkspaceDetails resource")
@subscriptionResource
model SubscriptionFileWorkspace
  is ProxyResource<FileWorkspaceDetailsProperties> {
  @doc("File Workspace Name")
  @path
  @key("fileWorkspaceName")
  @segment("fileWorkspaces")
  name: string;
}

@armResourceOperations
interface SubscriptionFileWorkspaces {
  @doc("Gets details for a specific file workspace in an Azure subscription.")
  get is ArmResourceRead<SubscriptionFileWorkspace>;
  @doc("Creates a new file workspace for the specified subscription.")
  create is ArmResourceCreateOrReplaceSync<SubscriptionFileWorkspace>;
}
