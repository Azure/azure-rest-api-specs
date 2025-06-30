import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./applink.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.AppLink;

@doc("AppLink Member resource")
@parentResource(AppLink)
model AppLinkMember is TrackedResource<AppLinkMemberProperties> {
  ...ResourceNameParameter<AppLinkMember>;
}

@doc("AppLink Member properties")
model AppLinkMemberProperties {
  @doc("The cluster type of member cluster")
  clusterType: string;

  @doc("The metadata for the member cluster")
  metadata: Metadata;

  @doc("Upgrade profile for AppLink Member")
  upgradeProfile: UpgradeProfile;

  @doc("Provisioning state of the AppLink Member resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Metadata for AppLink Member")
model Metadata {
  @doc("The resource id of the member cluster")
  resourceId: string;
}

@doc("AppLink Member release channel profile for upgrade")
union UpgradeReleaseChannel {
  string,

  @doc("Rapid release channel")
  Rapid: "Rapid",

  @doc("Stable release channel")
  Stable: "Stable",

  @doc("Legacy release channel")
  legacy: "Legacy",
}

@doc("Upgrade mode for AppLink Member")
union UpgradeMode {
  string,

  @doc("Auto upgrade mode")
  AutoUpgrade: "AutoUpgrade",

  @doc("Disabled upgrade mode")
  Disabled: "Disabled",
}

@doc("Upgrade profile for AppLink Member")
model UpgradeProfile {
  @doc("The release channel for the upgrade")
  releaseChannel: UpgradeReleaseChannel;

  @doc("The upgrade mode for the member")
  mode: UpgradeMode;
}

@armResourceOperations
interface AppLinkMembers {
  get is ArmResourceRead<AppLinkMember>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<AppLinkMember>;
  update is ArmResourcePatchAsync<AppLinkMember, AppLinkMemberProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AppLinkMember>;
  listByAppLink is ArmResourceListByParent<AppLinkMember>;
}
