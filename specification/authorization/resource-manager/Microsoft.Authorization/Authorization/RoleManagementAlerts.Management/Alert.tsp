import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * The alert.
 */
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
  get is Extension.Read<Extension.ScopeParameter, Alert>;

  /**
   * Update an alert.
   */
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.ScopeParameter,
    Alert,
    PatchModel = Alert,
    Response = ArmNoContentResponse
  >;

  /**
   * Gets alerts for a resource scope.
   */
  listForScope is Extension.ListByTarget<Extension.ScopeParameter, Alert>;

  /**
   * Refresh an alert.
   */
  refresh is Extension.ActionAsyncBase<
    Extension.ScopeParameter,
    Alert,
    void,
    ArmAcceptedLroResponse & {
      @bodyRoot
      _: AlertOperationResult;
    },
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Alert>
  >;
}

@@doc(Alert.name, "The name of the alert to get.");
@@doc(Alert.properties, "Alert properties.");
@@doc(Alerts.update::parameters.properties, "Parameters for the alert.");
