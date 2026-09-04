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
    NamePattern = "^default$"
  >;
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
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Lists service entitlement settings in a resource group. */
  listByResourceGroup is ArmResourceListByParent<ServiceEntitlementSetting>;

  /** Lists service entitlement settings in a subscription. */
  listBySubscription is ArmListBySubscription<ServiceEntitlementSetting>;

  /** Gets the result of a long-running operation performed on a service entitlement setting. */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/serviceEntitlementSettings/{serviceEntitlementSettingName}/operationResults/{operationId}")
  getOperationResult(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** The name of the service entitlement setting. */
    @path
    @pattern("^default$")
    serviceEntitlementSettingName: string,

    ...Azure.ResourceManager.CommonTypes.OperationIdParameter,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;
}
