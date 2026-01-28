import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Implements the Alert class.
 */
@parentResource(Vault)
model Alert is Azure.ResourceManager.ProxyResource<AlertProperties> {
  ...ResourceNameParameter<
    Resource = Alert,
    KeyName = "alertSettingName",
    SegmentName = "replicationAlertSettings",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface Alerts {
  /**
   * Gets the details of the specified email notification(alert) configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets an email notification(alert) configuration.")
  get is ArmResourceRead<Alert, Error = never>;

  /**
   * Create or update an email notification(alert) configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Configures email notifications for this vault.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    Alert,
    Request = ConfigureAlertRequest,
    Response = ArmResourceUpdatedResponse<Alert>,
    Error = never
  >;

  /**
   * Gets the list of email notification(alert) configurations for the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of configured email notification(alert) configurations.")
  list is ArmResourceListByParent<
    Alert,
    Response = ArmResponse<AlertCollection>,
    Error = never
  >;
}

@@doc(Alert.name, "The name of the email notification configuration.");
@@doc(Alert.properties, "Alert related data.");
@@doc(Alerts.create::parameters.resource,
  "The input to configure the email notification(alert)."
);
