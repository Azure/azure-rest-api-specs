import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.RoleManagementAlerts;
/**
 * Alert configuration.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model AlertConfiguration
  is Azure.ResourceManager.ExtensionResource<AlertConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = AlertConfiguration,
    KeyName = "alertId",
    SegmentName = "roleManagementAlertConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AlertConfigurations {
  /**
   * Get the specified alert configuration.
   */
  get is Extension.Read<
    Extension.ScopeParameter,
    AlertConfiguration,
    Error = CloudError
  >;

  /**
   * Update an alert configuration.
   */
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.ScopeParameter,
    AlertConfiguration,
    PatchModel = AlertConfiguration,
    Response = ArmNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets alert configurations for a resource scope.
   */
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    AlertConfiguration,
    Error = CloudError
  >;
}

@@doc(AlertConfiguration.name, "The name of the alert configuration to get.");
@@doc(AlertConfiguration.properties, "Alert configuration properties.");
@@doc(AlertConfigurations.update::parameters.properties,
  "Parameters for the alert configuration."
);
