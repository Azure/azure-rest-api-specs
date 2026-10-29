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

@armResourceOperations
interface ServiceEntitlementSettings {
  /** Gets a service entitlement setting. Returns HTTP 404 with the standard ARM error response if the setting does not exist. */
  get is ArmResourceRead<ServiceEntitlementSetting>;

  /** Creates or replaces a service entitlement setting. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceEntitlementSetting>;

  /** Updates an existing service entitlement setting. Returns HTTP 404 with the standard ARM error response if the setting does not exist. This operation does not create a missing setting. */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ServiceEntitlementSetting,
    ServiceEntitlementSettingUpdate
  >;

  /** Deletes a service entitlement setting. */
  delete is ArmResourceDeleteSync<ServiceEntitlementSetting>;

  /** Lists service entitlement settings in a resource group. */
  listByResourceGroup is ArmResourceListByParent<ServiceEntitlementSetting>;

  /** Lists service entitlement settings in a subscription. */
  listBySubscription is ArmListBySubscription<ServiceEntitlementSetting>;
}
