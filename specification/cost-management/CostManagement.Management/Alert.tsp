import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CostManagement;
/**
 * An individual alert.
 */
@extensionResource
model Alert is Azure.ResourceManager.ExtensionResource<AlertProperties> {
  ...ResourceNameParameter<
    Resource = Alert,
    KeyName = "alertId",
    SegmentName = "alerts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Alerts {
  /**
   * Gets the alert for the scope by alert ID.
   */
  get is Extension.Read<Extension.ScopeParameter, Alert>;

  /**
   * Dismisses the specified alert
   */
  @patch(#{ implicitOptionality: false })
  dismiss is Extension.CustomPatchSync<
    Extension.ScopeParameter,
    Alert,
    PatchModel = DismissAlertPayload
  >;

  /**
   * Lists the alerts for scope defined.
   */
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    Alert,
    Response = ArmResponse<AlertsResult>
  >;
}

@@doc(Alert.name, "Alert ID");
@@doc(Alert.properties, "Alert properties.");
@@doc(Alerts.dismiss::parameters.properties,
  "Parameters supplied to the Dismiss Alert operation."
);
