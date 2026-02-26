import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
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
  @doc("Cluster type")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  clusterType?: ClusterType;

  @doc("AppLink Member Metadata")
  metadata: Metadata;

  @doc("Upgrade mode")
  mode?: UpgradeMode;

  @doc("Fully managed upgrade profile")
  fullyManagedUpgradeProfile?: FullyManagedUpgradeProfile;

  @doc("Self managed upgrade profile")
  selfManagedUpgradeProfile?: SelfManagedUpgradeProfile;

  @doc("Observability profile")
  observabilityProfile?: ObservabilityProfile;

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

@doc("AppLinkMember observability profile")
model ObservabilityProfile {
  @doc("Metrics configuration")
  metrics?: MetricsProfile;
}

@doc("AppLinkMember metrics profile")
model MetricsProfile {
  @doc("Metrics endpoint URL")
  @visibility(Lifecycle.Read)
  metricsEndpoint?: string;
}

@armResourceOperations
interface AppLinkMembers {
  @doc("Get an AppLinkMember")
  get is ArmResourceRead<AppLinkMember>;
  @doc("Create an AppLinkMember")
  createOrReplace is ArmResourceCreateOrReplaceAsync<AppLinkMember>;
  @doc("Update an AppLinkMember")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmResourcePatchAsync<
    AppLinkMember,
    AppLinkMemberProperties,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AppLinkMember> &
      ArmLroLocationHeader<FinalResult = AppLinkMember> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  @doc("Delete an AppLinkMember")
  delete is ArmResourceDeleteWithoutOkAsync<AppLinkMember>;
  listByAppLink is ArmResourceListByParent<AppLinkMember>;
}
