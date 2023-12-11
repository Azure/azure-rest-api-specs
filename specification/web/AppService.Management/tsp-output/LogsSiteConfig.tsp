import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Configuration of App Service site logs.")
@parentResource(WebSite)
@singleton("logs")
model LogsSiteConfig is ProxyResource<SiteLogsConfigProperties> {
  @key("logs")
  @segment("config")
  name: string;
}

@armResourceOperations
interface LogsSiteConfigs {
  @doc("Description for Gets the logging configuration of an app.")
  getDiagnosticLogsConfiguration is ArmResourceRead<LogsSiteConfig>;
  @doc("Description for Updates the logging configuration of an app.")
  updateDiagnosticLogsConfig is ArmResourceCreateOrReplaceSync<LogsSiteConfig>;
  @doc("Description for List the configurations of an app")
  listByWebSite is ArmResourceListByParent<LogsSiteConfig>;
}
