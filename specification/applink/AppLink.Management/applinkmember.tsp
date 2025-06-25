import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./applink.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AppLink;

@doc("AppLink Member resource")
@parentResource(AppLink)
model AppLinkMember is TrackedResource<AppLinkMemberProperties> {
  ...ResourceNameParameter<AppLinkMember>;
}

@doc("AppLink Member properties")
model AppLinkMemberProperties {
  @doc("The type of member cluster")
  type: string;

  @doc("The metadata for the member cluster")
  metadata: Metadata;

  @doc("Internal metadata for AppLink Member")
  internalMetadata: AppLinkMemberInternalMetadata;

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

@doc("Internal metadata for AppLink Member")
model AppLinkMemberInternalMetadata {
  @doc("UMI Resource for AppLink Member Internal Metadata")
  umiResource: UmiResource;

  @doc("DNS resource details for AppLink Member Internal Metadata")
  dnsRecordSet: ProvisionResource;

  @doc("Extension resource details for AppLink Member Internal Metadata")
  extension: ProvisionResource;

  @doc("Underlay metadata for AppLink Member Provisioning")
  underlay: UnderlayMetadata;

  @doc("MCP name space for AppLink Member Internal Metadata")
  mcpNameSpace: string;
}

@doc("UMI Resource for AppLink Member Internal Metadata")
model UmiResource {
  @doc("UMI resource")
  umi: ProvisionResource;

  @doc("Role assignments for UMI resource")
  roleAssignments: ProvisionResource[];
}

@armResourceOperations
interface AppLinkMembers {
  get is ArmResourceRead<AppLinkMember>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AppLinkMember>;
  update is ArmResourcePatchAsync<AppLinkMember, AppLinkMemberProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AppLinkMember>;
  listByAppLink is ArmResourceListByParent<AppLinkMember>;
}
