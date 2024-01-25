import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Configuration of App Service site logs.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("logs")
@parentResource(Site)
@includeInapplicableMetadataInPayload(false)
model SiteLogsConfig extends ProxyOnlyResource {
  @key("config")
  @segment("config")
  @visibility("read")
  name: string;

  /**
   * SiteLogsConfig resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: SiteLogsConfigProperties;
}

@armResourceOperations
interface SiteLogsConfigs {
  /**
   * Description for Gets the logging configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetDiagnosticLogsConfiguration")
  getDiagnosticLogsConfiguration is ArmResourceRead<SiteLogsConfig>;

  /**
   * Description for Updates the logging configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_UpdateDiagnosticLogsConfig")
  updateDiagnosticLogsConfig is ArmResourceCreateOrReplaceSync<SiteLogsConfig>;

  /**
   * Description for List the configurations of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListConfigurations")
  listConfigurations is ArmResourceListByParent<SiteLogsConfig>;
}

@@projectedName(SiteLogsConfigs.updateDiagnosticLogsConfig::parameters.resource,
  "json",
  "siteLogsConfig"
);
@@extension(SiteLogsConfigs.updateDiagnosticLogsConfig::parameters.resource,
  "x-ms-client-name",
  "siteLogsConfig"
);
@@doc(SiteLogsConfigs.updateDiagnosticLogsConfig::parameters.resource,
  "A SiteLogsConfig JSON object that contains the logging configuration to change in the ",
  properties,
  " property."
);
