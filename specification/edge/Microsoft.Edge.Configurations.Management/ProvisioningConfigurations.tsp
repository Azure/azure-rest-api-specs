import "./Configuration.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@armResourceOperations
interface ProvisioningConfigurations {
  get is ArmResourceRead<ProvisioningConfiguration>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ProvisioningConfiguration>;
  update is ArmResourcePatchSync<
    ProvisioningConfiguration,
    ProvisioningConfigurationProperties
  >;
  delete is ArmResourceDeleteSync<ProvisioningConfiguration>;
  listByConfiguration is ArmResourceListByParent<ProvisioningConfiguration>;
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("ProvisioningConfiguration Resource")
@parentResource(Configuration)
model ProvisioningConfiguration
  is ProxyResource<ProvisioningConfigurationProperties> {
  ...ResourceNameParameter<
    ProvisioningConfiguration,
    NamePattern = "^default$"
  >;
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("ProvisioningConfigurationProperties Properties")
model ProvisioningConfigurationProperties {
  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Policy resource Id of onboarding service")
  onboardingServicePolicyResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DeviceOnboarding/onboardingServices/policies";
    }
  ]>;

  @doc("Type of OwnerKey. Currently supported types are MicrosoftManaged and CustomerManaged.")
  ownerKeyType: OwnerKeyType;
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("OwnerKey Types")
union OwnerKeyType {
  @doc("Microsoft Managed Key") MicrosoftManaged: "MicrosoftManaged",
  string,
}
