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
 * The alert.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model Alert is Azure.ResourceManager.ExtensionResource<AlertProperties> {
  ...ResourceNameParameter<
    Resource = Alert,
    KeyName = "alertId",
    SegmentName = "roleManagementAlerts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Alerts {
  /**
   * Get the specified alert.
   */
  get is Extension.Read<Extension.ScopeParameter, Alert, Error = CloudError>;

  /**
   * Update an alert.
   */
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.ScopeParameter,
    Alert,
    PatchModel = Alert,
    Response = ArmNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets alerts for a resource scope.
   */
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    Alert,
    Error = CloudError
  >;

  /**
   * Refresh an alert.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  refresh is Extension.ActionAsyncBase<
    Extension.ScopeParameter,
    Alert,
    void,
    ArmAcceptedLroResponse & {
      @bodyRoot
      _: AlertOperationResult;
    },
    Error = CloudError
  >;
}

@@doc(Alert.name, "The name of the alert to get.");
@@doc(Alert.properties, "Alert properties.");
@@doc(Alerts.update::parameters.properties, "Parameters for the alert.");
