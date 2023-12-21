import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Configures where to store the OMS agent data for workspaces under a scope")
@subscriptionResource
model WorkspaceSetting is ProxyResource<WorkspaceSettingProperties> {
  @doc("Name of the security setting")
  @path
  @key("workspaceSettingName")
  @segment("workspaceSettings")
  name: string;
}

@armResourceOperations
interface WorkspaceSettings {
  @doc("Settings about where we should store your security data and logs. If the result is empty, it means that no custom-workspace configuration was set")
  get is ArmResourceRead<WorkspaceSetting>;
  @doc("creating settings about where we should store your security data and logs")
  create is ArmResourceCreateOrReplaceSync<WorkspaceSetting>;
  @doc("Settings about where we should store your security data and logs")
  update is ArmResourcePatchSync<WorkspaceSetting, WorkspaceSettingProperties>;
  @doc("Deletes the custom workspace settings for this subscription. new VMs will report to the default workspace")
  delete is ArmResourceDeleteSync<WorkspaceSetting>;
  @doc("Settings about where we should store your security data and logs. If the result is empty, it means that no custom-workspace configuration was set")
  list is ArmResourceListByParent<WorkspaceSetting>;
}
