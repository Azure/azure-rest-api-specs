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
  getOperationStatus is Azure.ResourceManager.GetResourceOperationStatus<
    ArmOperationStatus,
    SubscriptionLocationActionScope
  >;

  /** Gets the result of a long-running operation. Returns no content while pending, the updated resource after PATCH completes, or no content after DELETE completes. */
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{location}/operationResults/{operationId}")
  getOperationResult(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,
    ...Azure.ResourceManager.CommonTypes.OperationIdParameter,
  ):
    | ArmResponse<ServiceEntitlementSetting>
    | ArmAcceptedResponse<
        "The operation is in progress.",
        ExtraHeaders = Azure.Core.Foundations.RetryAfterHeader & {
          /** The URL to poll for the operation result. */
          @header("Location")
          location: string;
        }
      >
    | ArmNoContentResponse<"The delete operation completed successfully.">
    | ErrorResponse;
}
