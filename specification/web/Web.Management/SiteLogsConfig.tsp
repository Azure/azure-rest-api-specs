import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Configuration of App Service site logs.
 */
@singleton("logs")
@parentResource(Site)
model SiteLogsConfig
  is Azure.ResourceManager.ProxyResource<SiteLogsConfigProperties> {
  ...ResourceNameParameter<
    Resource = SiteLogsConfig,
    KeyName = "config",
    SegmentName = "config",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SiteLogsConfigOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** undefined */
        @path
        @segment("config")
        @key
        logs: "logs",
      }
    > {}

@armResourceOperations
interface SiteLogsConfigs {
  /**
   * Description for Gets the logging configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetDiagnosticLogsConfiguration")
  getDiagnosticLogsConfiguration is SiteLogsConfigOps.Read<SiteLogsConfig>;

  /**
   * Description for Updates the logging configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_UpdateDiagnosticLogsConfig")
  updateDiagnosticLogsConfig is SiteLogsConfigOps.CreateOrUpdateSync<
    SiteLogsConfig,
    Response = ArmResourceUpdatedResponse<SiteLogsConfig>
  >;
}
@armResourceOperations
interface SiteLogsConfigOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API will get the logging configuration for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** undefined */
        @path
        @segment("config")
        @key
        logs: "logs",
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SiteLogsConfigOperationGroup {
  /**
   * Description for Gets the logging configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetDiagnosticLogsConfigurationSlot")
  getDiagnosticLogsConfigurationSlot is SiteLogsConfigOperationGroupOps.Read<
    SiteLogsConfig,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates the logging configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_UpdateDiagnosticLogsConfigSlot")
  updateDiagnosticLogsConfigSlot is SiteLogsConfigOperationGroupOps.CreateOrUpdateSync<
    SiteLogsConfig,
    Response = ArmResourceUpdatedResponse<SiteLogsConfig>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(SiteLogsConfig.name, "");
@@doc(SiteLogsConfig.properties, "SiteLogsConfig resource specific properties");
// @@doc(SiteLogsConfigs.updateDiagnosticLogsConfig::parameters.resource,
//   "A SiteLogsConfig JSON object that contains the logging configuration to change in the ",
//   properties,
//   " property."
// );
// @@doc(SiteLogsConfigOperationGroup.updateDiagnosticLogsConfigSlot::parameters.resource,
//   "A SiteLogsConfig JSON object that contains the logging configuration to change in the ",
//   properties,
//   " property."
// );
