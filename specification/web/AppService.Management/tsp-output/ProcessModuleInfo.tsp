import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProcessInfo.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Process Module Information.")
@parentResource(ProcessInfo)
model ProcessModuleInfo is ProxyResource<ProcessModuleInfoProperties> {
  @doc("Module base address.")
  @key("baseAddress")
  @segment("modules")
  name: string;
}

@armResourceOperations
@projectedName("client", "WebApps")
interface ProcessModuleInfos_WebApps {
  @doc("Description for Get process information by its ID for a specific scaled-out instance in a web site.")
  getInstanceProcessModule is ArmResourceRead<ProcessModuleInfo>;

  @doc("Description for List module information for a process by its ID for a specific scaled-out instance in a web site.")
  listInstanceProcessModules is ArmResourceListByParent<ProcessModuleInfo>;
}
