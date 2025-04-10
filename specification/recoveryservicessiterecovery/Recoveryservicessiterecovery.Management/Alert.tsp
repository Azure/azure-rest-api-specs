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
model Alert is Azure.ResourceManager.ProxyResource<AlertProperties> {
  ...ResourceNameParameter<
    Resource = Alert,
    KeyName = "alertSettingName",
    SegmentName = "replicationAlertSettings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Alerts {
  /**
   * Gets the details of the specified email notification(alert) configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationAlertSettings_Get")
  get is ArmResourceRead<Alert>;

  /**
   * Create or update an email notification(alert) configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationAlertSettings_Create")
  create is ArmResourceCreateOrReplaceSync<
    Alert,
    Response = ArmResourceUpdatedResponse<Alert>
  >;

  /**
   * Gets the list of email notification(alert) configurations for the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationAlertSettings_List")
  list is ArmResourceListByParent<
    Alert,
    Response = ArmResponse<AlertCollection>
  >;
}

@@doc(Alert.name, "The name of the email notification configuration.");
@@doc(Alert.properties, "Alert related data.");
@@doc(Alerts.create::parameters.resource,
  "The input to configure the email notification(alert)."
);
