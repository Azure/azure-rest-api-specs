import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
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
  update is ArmCustomPatchSync<WorkspaceSetting, WorkspaceSetting>;

  @doc("Deletes the custom workspace settings for this subscription. new VMs will report to the default workspace")
  delete is ArmResourceDeleteSync<WorkspaceSetting>;

  @doc("Settings about where we should store your security data and logs. If the result is empty, it means that no custom-workspace configuration was set")
  list is ArmResourceListByParent<WorkspaceSetting>;
}

@@projectedName(WorkspaceSettings.create::parameters.resource,
  "json",
  "workspaceSetting"
);
@@extension(WorkspaceSettings.create::parameters.resource,
  "x-ms-client-name",
  "workspaceSetting"
);
@@doc(WorkspaceSettings.create::parameters.resource,
  "Security data setting object"
);
@@projectedName(WorkspaceSettings.update::parameters.properties,
  "json",
  "workspaceSetting"
);
@@extension(WorkspaceSettings.update::parameters.properties,
  "x-ms-client-name",
  "workspaceSetting"
);
@@doc(WorkspaceSettings.update::parameters.properties,
  "Security data setting object"
);
