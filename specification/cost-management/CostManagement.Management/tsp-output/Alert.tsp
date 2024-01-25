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

namespace Microsoft.CostManagement;
/**
 * An individual alert.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AlertProperties)
model Alert extends ExtensionResourceBase {
  /**
   * Alert ID
   */
  @path
  @key("alertId")
  @segment("alerts")
  @visibility("read")
  name: string;

  /**
   * Alert properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AlertProperties;
}

@armResourceOperations
interface Alerts {
  /**
   * Gets the alert for the scope by alert ID.
   */
  get is ArmResourceRead<Alert>;

  /**
   * Dismisses the specified alert
   */
  @parameterVisibility("read")
  dismiss is ArmCustomPatchSync<Alert, DismissAlertPayload>;

  /**
   * Lists the alerts for scope defined.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Alerts_List")
  list is ArmResourceListByParent<Alert>;

  /**
   * Lists the Alerts for external cloud provider type defined.
   */
  listExternal is ArmListBySubscription<Alert>;
}

@@projectedName(Alerts.dismiss::parameters.properties, "json", "parameters");
@@extension(Alerts.dismiss::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Alerts.dismiss::parameters.properties,
  "Parameters supplied to the Dismiss Alert operation."
);
