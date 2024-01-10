import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Configuration of App Service site logs.")
@singleton("logs")
@parentResource(Site)
model SiteLogsConfig is ProxyResource<SiteLogsConfigProperties> {
  @key("config")
  @segment("config")
  name: string;
}

@armResourceOperations
@projectedName("client", "WebApps")
interface SiteLogsConfigs_WebApps {
  @doc("Description for Gets the logging configuration of an app.")
  getDiagnosticLogsConfiguration is ArmResourceRead<SiteLogsConfig>;

  @doc("Description for Updates the logging configuration of an app.")
  updateDiagnosticLogsConfig is ArmResourceCreateOrReplaceSync<SiteLogsConfig>;

  @doc("Description for List the configurations of an app")
  listConfigurations is ArmResourceListByParent<SiteLogsConfig>;
}
