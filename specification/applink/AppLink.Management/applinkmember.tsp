import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./applink.tsp";

using TypeSpec.Rest;
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

@armResourceOperations
interface AppLinkMembers {
  @doc("Get an AppLinkMember.")
  get is ArmResourceRead<AppLinkMember>;
  @doc("Create an AppLinkMember.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AppLinkMember>;
  @doc("Update an AppLinkMember.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmResourcePatchAsync<
    AppLinkMember,
    AppLinkMemberProperties,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AppLinkMember> &
      ArmLroLocationHeader<FinalResult = AppLinkMember> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  @doc("Delete an AppLinkMember.")
  delete is ArmResourceDeleteWithoutOkAsync<AppLinkMember>;
  @doc("List AppLinkMember resources by AppLink.")
  listByAppLink is ArmResourceListByParent<AppLinkMember>;
}
