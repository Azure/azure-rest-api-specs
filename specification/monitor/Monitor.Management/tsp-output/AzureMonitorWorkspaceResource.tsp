import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
@doc("An Azure Monitor Workspace definition")
model AzureMonitorWorkspaceResource
  is TrackedResource<AzureMonitorWorkspaceResourceProperties> {
  @doc("The name of the Azure Monitor workspace.  The name is case insensitive")
  @pattern("^(?!-)[a-zA-Z0-9-]+[^-]$")
  @path
  @key("azureMonitorWorkspaceName")
  @segment("accounts")
  name: string;

  @doc("Resource entity tag (ETag)")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface AzureMonitorWorkspaces {
  @doc("Returns the specific Azure Monitor workspace")
  get is ArmResourceRead<AzureMonitorWorkspaceResource>;
  @doc("Create or update a workspace")
  create is ArmResourceCreateOrReplaceSync<AzureMonitorWorkspaceResource>;
  @doc("Updates part of a workspace")
  update is ArmTagsPatchSync<AzureMonitorWorkspaceResource>;
  @doc("Delete a workspace")
  delete is ArmResourceDeleteWithoutOkAsync<AzureMonitorWorkspaceResource>;
  @doc("Lists all workspaces in the specified resource group")
  listByResourceGroup is ArmResourceListByParent<AzureMonitorWorkspaceResource>;
  @doc("Lists all workspaces in the specified subscription")
  listBySubscription is ArmListBySubscription<AzureMonitorWorkspaceResource>;
}
