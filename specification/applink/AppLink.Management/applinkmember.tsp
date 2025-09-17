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

@doc("AppLinkMember properties")
model AppLinkMemberProperties {
  @doc("Cluster type")
  clusterType?: ClusterType;

  @doc("Metadata")
  metadata: Metadata;

  @doc("Upgrade mode")
  mode?: UpgradeMode;

  @doc("Fully managed upgrade profile")
  fullyManagedUpgradeProfile?: FullyManagedUpgradeProfile;

  @doc("Self managed upgrade profile")
  selfManagedUpgradeProfile?: SelfManagedUpgradeProfile;

  @doc("Observability settings")
  observabilitySettings?: ObservabilitySettings;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("AppLinkMember cluster type")
union ClusterType {
  string,

  @doc("Azure Kubernetes Service")
  AKS: "AKS"
}

@doc("AppLinkMember metadata")
model Metadata {
  @doc("Resource ID")
  resourceId: string;
}

@doc("AppLinkMember upgrade release channel")
union UpgradeReleaseChannel {
  string,

  @doc("Rapid release channel")
  Rapid: "Rapid",

  @doc("Stable release channel")
  Stable: "Stable",
}

@doc("AppLinkMember upgrade mode")
union UpgradeMode {
  string,

  @doc("Fully managed upgrade mode")
  FullyManaged: "FullyManaged",

  @doc("Self managed upgrade mode")
  SelfManaged: "SelfManaged",
}

@doc("AppLinkMember fully managed upgrade profile")
model FullyManagedUpgradeProfile {
  @doc("Release channel")
  releaseChannel: UpgradeReleaseChannel;
}

@doc("AppLinkMember self managed upgrade profile")
model SelfManagedUpgradeProfile {
  @doc("Istio version")
  version: string;
}

@doc("AppLinkMember observability state")
union ObservabilityState {
  string,

  @doc("Observability state disabled")
  Disabled: "Disabled",

  @doc("Observability state enabled")
  Enabled: "Enabled"
}

@doc("AppLinkMember metrics settings")
model MetricsSettings {
  @doc("Metrics state")
  state: ObservabilityState;
}

@doc("AppLinkMember logs settings")
model LogsSettings {
  @doc("Logs state")
  state: ObservabilityState;
}

@doc("AppLinkMember traces settings")
model TracesSettings {
  @doc("Traces state")
  state: ObservabilityState;
}

@doc("AppLinkMember observability settings")
model ObservabilitySettings {
  @doc("Metrics settings")
  metrics?: MetricsSettings;

  @doc("Logs settings")
  logs?: LogsSettings;

  @doc("Traces settings")
  traces?: TracesSettings;

  @doc("Managed identity")
  managedIdentity?: string;
}

@doc("AppLinkMember internal metadata")
model AppLinkMemberInternalMetadata {
  @doc("UMI resource")
  umiResource: UMIResource;

  @doc("DNS record set provision resource")
  dnsRecordSet: ProvisionResource;

  @doc("Extension provision resource")
  extension: ProvisionResource;

  @doc("Underlay metadata")
  underlay: UnderlayMetadata;

  @doc("MCP namespace")
  mcpNameSpace: string;

  @doc("DCE provision resource")
  dceResource?: ProvisionResource;

  @doc("DCR provision resource")
  dcrResource?: ProvisionResource;
}

@doc("User Managed Identity resource")
model UMIResource {
  @doc("UMI provision resource")
  umi: ProvisionResource;

  @doc("UMI role assignments")
  roleAssignments: ProvisionResource[];
}

@armResourceOperations
interface AppLinkMembers {
  get is ArmResourceRead<AppLinkMember>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<AppLinkMember>;
  update is ArmResourcePatchAsync<AppLinkMember, AppLinkMemberProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AppLinkMember>;
  listByAppLink is ArmResourceListByParent<AppLinkMember>;
}
