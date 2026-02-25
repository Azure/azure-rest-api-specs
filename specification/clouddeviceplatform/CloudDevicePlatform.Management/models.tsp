import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.CloudDevicePlatform;

@added(Versions.v2024_06_01_preview)
@doc("Represents a CloudDevicePlatform delegated identity resource.")
model DelegatedIdentity is TrackedResource<DelegatedIdentityProperties> {
  ...ResourceNameParameter<
    Resource = DelegatedIdentity,
    NamePattern = "^[a-zA-Z0-9-]{3,128}$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "common type"
  @doc("The identity of the resource.")
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentityWithDelegation;
}

@added(Versions.v2024_06_01_preview)
@doc("Represents the properties of a CloudDevicePlatform delegated identity resource.")
model DelegatedIdentityProperties {
  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2024_06_01_preview)
@doc("Represents the properties of a DelegatedIdentity resource that can be updated.")
model DelegatedIdentityUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("Updatable managed service identity")
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentityWithDelegation;
}
