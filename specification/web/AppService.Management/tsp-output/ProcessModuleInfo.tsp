import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProcessInfo.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Process Module Information.
 */
@parentResource(ProcessInfo)
model ProcessModuleInfo is ProxyResource<ProcessModuleInfoProperties> {
  /**
   * Module base address.
   */
  @path
  @key("baseAddress")
  @segment("modules")
  name: string;
}

@armResourceOperations
interface ProcessModuleInfos {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetInstanceProcessModule")
  getInstanceProcessModule is ArmResourceRead<ProcessModuleInfo>;

  /**
   * Description for List module information for a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListInstanceProcessModules")
  listInstanceProcessModules is ArmResourceListByParent<ProcessModuleInfo>;
}
