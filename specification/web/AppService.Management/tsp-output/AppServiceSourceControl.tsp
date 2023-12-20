import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("The source control OAuth token.")
@tenantResource
model AppServiceSourceControl is ProxyResource<SourceControlProperties> {
  @doc("Type of source control")
  @path
  @key("sourceControlType")
  @segment("sourcecontrols")
  name: string;
}

@armResourceOperations
interface AppServiceSourceControls {
  @doc("Description for Gets source control token")
  getSourceControl is ArmResourceRead<AppServiceSourceControl>;
  @doc("Description for Updates source control token")
  updateSourceControl is ArmResourceCreateOrReplaceSync<AppServiceSourceControl>;
  @doc("Description for Gets the source controls available for Azure websites.")
  listSourceControls is ArmResourceListByParent<AppServiceSourceControl>;
}
