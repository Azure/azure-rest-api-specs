import "@azure-tools/typespec-azure-resource-manager";
using Azure.ResourceManager;

namespace Microsoft.Compute.WorkloadManager;

union ProvisioningState {
  string,
  "Accepted",
  "Provisioning",
  "Updating",
  "Deleting",
  "Succeeded",
  "Failed",
  "Canceled",
}

enum RuntimeBindingKind { Kubernetes, ServerlessContainers }
enum VersionPolicy { ServiceManaged }
enum CapabilityKind { AgentSandbox, PodSnapshotRestore, AgentSubstrate, AgentFabric }
enum ExecutionIdentityScope { SandboxGroup }
enum EgressMode { CustomerManaged }

model WorkloadSpaceProperties {
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@trackedResource("workloadSpaces")
model WorkloadSpace is TrackedResource<WorkloadSpaceProperties> {
  ...ResourceNameParameter<WorkloadSpace>;
}

model ManagedRuntimeProfile {
  offering?: string;
  provider?: string;
}

model ExecutionIdentity {
  provisioningMode: "Referenced" | "ServiceManaged";
  @format("arm-id")
  userAssignedIdentityResourceId?: string;
  scope: ExecutionIdentityScope;
}
model RuntimeIdentityProfile { executionIdentity?: ExecutionIdentity; }
model RuntimeNetworkProfile {
  @format("arm-id") subnetResourceId?: string;
  egressMode?: EgressMode;
}

model RuntimeBindingReadOnlyProperties {
  @visibility(Lifecycle.Read) provisioningState?: ProvisioningState;
  @visibility(Lifecycle.Read) @format("arm-id") providerResourceId?: string;
}

model ManagedRuntimeBindingProperties extends RuntimeBindingReadOnlyProperties {
  kind: RuntimeBindingKind;
  provisioningMode: "Managed";
  managedProfile: ManagedRuntimeProfile;
  identityProfile?: RuntimeIdentityProfile;
  networkProfile?: RuntimeNetworkProfile;
}

model ReferencedRuntimeBindingProperties extends RuntimeBindingReadOnlyProperties {
  kind: RuntimeBindingKind;
  provisioningMode: "Referenced";
  @format("arm-id") resourceId: string;
}

union RuntimeBindingProperties {
  ManagedRuntimeBindingProperties,
  ReferencedRuntimeBindingProperties,
}

@parentResource(WorkloadSpace)
@trackedResource("runtimeBindings")
model RuntimeBinding is TrackedResource<RuntimeBindingProperties> {
  ...ResourceNameParameter<RuntimeBinding>;
}

model RuntimeLinkIntegrationProfile {
  @format("arm-id") managedIdentityResourceId?: string;
}
model CapacityProfile { minimumNodes: int32; maximumNodes: int32; }
model RuntimeLinkProperties {
  @format("arm-id") orchestratorBindingResourceId: string;
  @format("arm-id") executionBindingResourceId?: string;
  integrationProfile?: RuntimeLinkIntegrationProfile;
  capacityProfile?: CapacityProfile;
  @visibility(Lifecycle.Read) provisioningState?: ProvisioningState;
  @visibility(Lifecycle.Read) @format("arm-id") providerResourceId?: string;
}

@parentResource(WorkloadSpace)
@trackedResource("runtimeLinks")
model RuntimeLink is TrackedResource<RuntimeLinkProperties> {
  ...ResourceNameParameter<RuntimeLink>;
}

model CapabilityProperties {
  kind: CapabilityKind;
  versionPolicy: VersionPolicy;
  settings?: Record<unknown>;
  @visibility(Lifecycle.Read) effectiveVersion?: string;
  @visibility(Lifecycle.Read) provisioningState?: ProvisioningState;
}

@parentResource(WorkloadSpace)
@trackedResource("capabilities")
model Capability is TrackedResource<CapabilityProperties> {
  ...ResourceNameParameter<Capability>;
}
