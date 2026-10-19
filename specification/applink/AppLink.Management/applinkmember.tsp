import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./applink.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.AppLink;

@doc("A member of an Azure Kubernetes Application Network resource.")
@parentResource(AppLink)
model AppLinkMember is TrackedResource<AppLinkMemberProperties> {
  ...ResourceNameParameter<AppLinkMember>;
}

@doc("AppLink Member properties")
model AppLinkMemberProperties {
  @doc("Cluster type")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  clusterType?: ClusterType;

  @doc("AppLink Member Metadata")
  metadata: Metadata;

  @doc("Upgrade profile.")
  upgradeProfile?: UpgradeProfile;

  @doc("Observability profile")
  observabilityProfile?: ObservabilityProfile;

  @doc("Connectivity profile.")
  connectivityProfile?: ConnectivityProfile;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("AppLinkMember cluster type")
union ClusterType {
  string,

  @doc("Azure Kubernetes Service")
  AKS: "AKS",
}

@doc("AppLinkMember metadata")
model Metadata {
  @doc("Resource ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  resourceId: Azure.Core.armResourceIdentifier;
}

@doc("AppLinkMember upgrade profile.")
model UpgradeProfile {
  @doc("Upgrade mode.")
  mode: UpgradeMode;

  @doc("Fully managed upgrade profile.")
  fullyManagedUpgradeProfile?: FullyManagedUpgradeProfile;

  @doc("Self managed upgrade profile.")
  selfManagedUpgradeProfile?: SelfManagedUpgradeProfile;
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

@doc("AppLinkMember observability profile")
model ObservabilityProfile {
  @doc("Metrics configuration")
  metrics?: MetricsProfile;
}

@doc("AppLinkMember connectivity profile.")
model ConnectivityProfile {
  @doc("East-West gateway profile.")
  eastWestGateway?: EastWestGatewayProfile;

  @doc("Private connect profile.")
  privateConnect?: PrivateConnectProfile;

  @doc("The network name for an Azure Kubernetes Application Network member.")
  @added(Microsoft.AppLink.Versions.v2026_08_01_preview)
  network?: string;
}

@doc("AppLinkMember private connect profile.")
model PrivateConnectProfile {
  @doc("Delegated Subnet to AppLink.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetResourceId: armResourceIdentifier;
}

@doc("AppLinkMember metrics profile")
model MetricsProfile {
  @doc("Metrics endpoint URL")
  @visibility(Lifecycle.Read)
  metricsEndpoint?: string;
}

@doc("AppLinkMember east-west gateway profile.")
model EastWestGatewayProfile {
  @doc("East-West gateway visibility.")
  visibility: EastWestGatewayVisibility;
}

@doc("East-West gateway visibility.")
union EastWestGatewayVisibility {
  string,

  @doc("Use an internal load balancer for the east-west gateway.")
  Internal: "Internal",

  @doc("Use an external load balancer for the east-west gateway.")
  External: "External",
}

@doc("The updatable properties of the AppLinkMember.")
@added(Microsoft.AppLink.Versions.v2026_08_01_preview)
model AppLinkMemberUpdateProperties {
  @doc("Upgrade profile.")
  upgradeProfile?: UpgradeProfileUpdate;

  @doc("Connectivity profile.")
  connectivityProfile?: ConnectivityProfileUpdate;
}

@doc("The updatable AppLinkMember upgrade profile.")
@added(Microsoft.AppLink.Versions.v2026_08_01_preview)
model UpgradeProfileUpdate {
  @doc("Upgrade mode.")
  mode?: UpgradeMode;

  @doc("Fully managed upgrade profile.")
  fullyManagedUpgradeProfile?: FullyManagedUpgradeProfileUpdate;

  @doc("Self managed upgrade profile.")
  selfManagedUpgradeProfile?: SelfManagedUpgradeProfileUpdate;
}

@doc("The updatable AppLinkMember fully managed upgrade profile.")
@added(Microsoft.AppLink.Versions.v2026_08_01_preview)
model FullyManagedUpgradeProfileUpdate {
  @doc("Release channel")
  releaseChannel?: UpgradeReleaseChannel;
}

@doc("The updatable AppLinkMember self managed upgrade profile.")
@added(Microsoft.AppLink.Versions.v2026_08_01_preview)
model SelfManagedUpgradeProfileUpdate {
  @doc("Istio version")
  version?: string;
}

@doc("The updatable AppLinkMember connectivity profile.")
@added(Microsoft.AppLink.Versions.v2026_08_01_preview)
model ConnectivityProfileUpdate {
  @doc("East-West gateway profile.")
  eastWestGateway?: EastWestGatewayProfileUpdate;

  @doc("The network name for an Azure Kubernetes Application Network member.")
  network?: string;
}

@doc("The updatable AppLinkMember east-west gateway profile.")
@added(Microsoft.AppLink.Versions.v2026_08_01_preview)
model EastWestGatewayProfileUpdate {
  @doc("East-West gateway visibility.")
  visibility?: EastWestGatewayVisibility;
}

@doc("The type used for update operations of the AppLinkMember.")
@added(Microsoft.AppLink.Versions.v2026_08_01_preview)
model AppLinkMemberUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Updating dictionary of tags"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?: AppLinkMemberUpdateProperties;
}

@armResourceOperations
interface AppLinkMembers {
  @doc("Get a member of an Azure Kubernetes Application Network resource.")
  get is ArmResourceRead<AppLinkMember>;
  @doc("Create a member of an Azure Kubernetes Application Network resource.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AppLinkMember>;
  @doc("Update a member of an Azure Kubernetes Application Network resource.")
  @removed(Versions.v2026_08_01_preview)
  @renamedFrom(Versions.v2026_08_01_preview, "update")
  @sharedRoute
  @Azure.Core.useFinalStateVia("azure-async-operation")
  updateLegacy is ArmResourcePatchAsync<
    AppLinkMember,
    AppLinkMemberProperties,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AppLinkMember> &
      ArmLroLocationHeader<FinalResult = AppLinkMember> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  @doc("Update a member of an Azure Kubernetes Application Network resource.")
  @added(Versions.v2026_08_01_preview)
  @sharedRoute
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    AppLinkMember,
    AppLinkMemberUpdate,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AppLinkMember> &
      ArmLroLocationHeader<FinalResult = AppLinkMember> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  @doc("Remove a member from an Azure Kubernetes Application Network resource.")
  delete is ArmResourceDeleteWithoutOkAsync<AppLinkMember>;
  @doc("List the members of an Azure Kubernetes Application Network resource.")
  listByAppLink is ArmResourceListByParent<AppLinkMember>;
}
