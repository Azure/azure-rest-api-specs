import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SiteInstanceProcess.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Process Module Information.")
@parentResource(SiteInstanceProcess)
model SiteInstanceProcessModule is ProxyResource<ProcessModuleInfoProperties> {
  @doc("Module base address.")
  @path
  @key("baseAddress")
  @segment("modules")
  name: string;
}

@armResourceOperations
interface SiteInstanceProcessModules {
  @doc("Description for Get process information by its ID for a specific scaled-out instance in a web site.")
  getInstanceProcessModule is ArmResourceRead<SiteInstanceProcessModule>;
  @doc("Description for List module information for a process by its ID for a specific scaled-out instance in a web site.")
  listInstanceProcessModules is ArmResourceListByParent<SiteInstanceProcessModule>;
}
