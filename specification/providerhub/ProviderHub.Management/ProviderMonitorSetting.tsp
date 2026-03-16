import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

model ProviderMonitorSetting
  is Azure.ResourceManager.TrackedResource<ProviderMonitorSettingProperties> {
  ...ResourceNameParameter<
    Resource = ProviderMonitorSetting,
    KeyName = "providerMonitorSettingName",
    SegmentName = "providerMonitorSettings",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
}

@armResourceOperations
interface ProviderMonitorSettings {
  /**
   * Gets the provider monitor setting details.
   */
  get is ArmResourceRead<ProviderMonitorSetting>;

  /**
   * Creates the provider monitor setting.
   */
  create is ArmResourceCreateOrReplaceAsync<ProviderMonitorSetting>;

  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  /**
   * Updates the provider monitor setting properties as specified in the request body. Update fails if the specified provider monitor setting does not already exist.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    ProviderMonitorSetting,
    PatchModel = void
  >;

  /**
   * Deletes a provider monitor setting.
   */
  delete is ArmResourceDeleteSync<ProviderMonitorSetting>;

  /**
   * Gets the list of the provider monitor settings in the resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ProviderMonitorSetting,
    Response = ArmResponse<ProviderMonitorSettingArrayResponseWithContinuation>
  >;

  /**
   * Gets the list of the provider monitor settings in the subscription.
   */
  listBySubscription is ArmListBySubscription<
    ProviderMonitorSetting,
    Response = ArmResponse<ProviderMonitorSettingArrayResponseWithContinuation>
  >;
}

@@doc(ProviderMonitorSetting.name, "The name of the provider monitor setting.");
@@doc(ProviderMonitorSetting.properties, "");
@@doc(ProviderMonitorSettings.create::parameters.resource,
  "The provider monitor setting properties supplied to the create operation."
);
