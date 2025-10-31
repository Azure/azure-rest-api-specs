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
model Alert is Azure.ResourceManager.ExtensionResource<AlertProperties> {
  ...ResourceNameParameter<
    Resource = Alert,
    KeyName = "alertId",
    SegmentName = "alerts",
    NamePattern = ""
  >;

  /**
   * eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: Azure.Core.eTag;
}

@armResourceOperations
interface Alerts {
  /**
   * Gets the alert for the scope by alert ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  get is Extension.Read<Extension.ScopeParameter, Alert, Error = ErrorResponse>;

  /**
   * Dismisses the specified alert
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  dismiss is Extension.CustomPatchSync<
    Extension.ScopeParameter,
    Alert,
    PatchModel = DismissAlertPayload,
    Error = ErrorResponse
  >;

  /**
   * Lists the alerts for scope defined.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/costmanagement/")
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    Alert,
    Response = ArmResponse<AlertsResult>,
    Error = ErrorResponse
  >;
}

@@doc(Alert.name, "Alert ID");
@@doc(Alert.properties, "Alert properties.");
@@doc(Alerts.dismiss::parameters.properties,
  "Parameters supplied to the Dismiss Alert operation."
);
@@path(Alert.name, #{ allowReserved: true });
