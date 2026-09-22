import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace ServiceEntitlementSettingsApi;

/** A Microsoft Defender for Cloud service entitlement setting. */
model ServiceEntitlementSetting
  is TrackedResource<ServiceEntitlementSettingProperties> {
  ...ResourceNameParameter<
    Resource = ServiceEntitlementSetting,
    KeyName = "serviceEntitlementSettingName",
    SegmentName = "serviceEntitlementSettings",
    NamePattern = "^default$",
    Type = ServiceEntitlementSettingName
  >;
}

/** Parameters identifying a long-running operation on a service entitlement setting. */
model ServiceEntitlementSettingOperationParameters {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /** The singleton service entitlement setting name. */
  @path
  @pattern("^default$")
  serviceEntitlementSettingName: ServiceEntitlementSettingName;

  ...Azure.ResourceManager.CommonTypes.OperationIdParameter;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface ServiceEntitlementSettings {
  /** Gets a service entitlement setting. */
  get is ArmResourceRead<ServiceEntitlementSetting>;

  /** Creates or replaces a service entitlement setting. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceEntitlementSetting>;

  /** Updates a service entitlement setting. */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ServiceEntitlementSetting,
    ServiceEntitlementSettingUpdate,
    LroHeaders = ArmCombinedLroHeaders<
      ArmOperationStatus,
      ServiceEntitlementSetting
    > &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Deletes a service entitlement setting. */
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceEntitlementSetting,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Lists service entitlement settings in a resource group. */
  listByResourceGroup is ArmResourceListByParent<ServiceEntitlementSetting>;

  /** Lists service entitlement settings in a subscription. */
  listBySubscription is ArmListBySubscription<ServiceEntitlementSetting>;

  /** Gets the status of a long-running operation, including after the service entitlement setting has been deleted. */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/serviceEntitlementSettings/{serviceEntitlementSettingName}/operationStatuses/{operationId}")
  getOperationStatus(...ServiceEntitlementSettingOperationParameters):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;

  /** Gets the status of a long-running operation through the operation-results endpoint. Returns HTTP 200 with a status monitor while the operation is in progress and after completion, including after DELETE. */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/serviceEntitlementSettings/{serviceEntitlementSettingName}/operationResults/{operationId}")
  getOperationResult(...ServiceEntitlementSettingOperationParameters):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;
}
