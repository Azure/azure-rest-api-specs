import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Compute.WorkloadManager;

/** The provisioning state of a Workload Manager resource. */
union ProvisioningState {
  Azure.ResourceManager.ResourceProvisioningState,

  /** The request has been accepted for processing. */
  Accepted: "Accepted",

  /** The resource is being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",
}

/** The runtime technology represented by a binding. */
union RuntimeBindingKind {
  string,

  /** A Kubernetes orchestration runtime. */
  Kubernetes: "Kubernetes",

  /** A serverless container execution runtime. */
  ServerlessContainers: "ServerlessContainers",
}

/** The ownership mode for a runtime binding. */
union RuntimeBindingProvisioningMode {
  string,

  /** Workload Manager creates and owns the provider resource. */
  Managed: "Managed",

  /** Workload Manager attaches an existing customer-owned resource. */
  Referenced: "Referenced",
}

/** The version selection policy for a capability. */
union VersionPolicy {
  string,

  /** Workload Manager selects and upgrades the capability version. */
  ServiceManaged: "ServiceManaged",
}

/** The capability enabled for a workload space. */
union CapabilityKind {
  string,

  /** Enables isolated agent sandbox execution. */
  AgentSandbox: "AgentSandbox",
}

/** The provisioning mode for an execution identity. */
union ExecutionIdentityProvisioningMode {
  string,

  /** Uses a customer-provided identity. */
  Referenced: "Referenced",

  /** Workload Manager creates and owns the identity. */
  ServiceManaged: "ServiceManaged",
}

/** The scope at which an execution identity is shared. */
union ExecutionIdentityScope {
  string,

  /** The identity is shared by sandboxes in the execution group. */
  SandboxGroup: "SandboxGroup",
}

/** The egress ownership mode for a managed runtime. */
union EgressMode {
  string,

  /** The customer supplies and manages the egress configuration. */
  CustomerManaged: "CustomerManaged",
}

/** Properties of a workload space. */
model WorkloadSpaceProperties {
  /** The provisioning state of the workload space. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** A regional governance and lifecycle boundary for composed runtimes. */
model WorkloadSpace is TrackedResource<WorkloadSpaceProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadSpace,
    KeyName = "spaceName",
    SegmentName = "workloadSpaces",
    NamePattern = "^(?![.-])[A-Za-z0-9_.-]{1,64}$"
  >;
}

/** Service-selected configuration for a managed runtime. */
model ManagedRuntimeProfile {
  /** The product offering selected for a managed Kubernetes runtime. */
  offering?: string;

  /** The provider selected for a managed serverless container runtime. */
  provider?: string;
}

/** Configuration for an identity used by an execution runtime. */
model ExecutionIdentity {
  /** Indicates whether the identity is managed by the service or supplied by the customer. */
  provisioningMode: ExecutionIdentityProvisioningMode;

  /** The customer-provided user-assigned identity, when provisioningMode is Referenced. */
  userAssignedIdentityResourceId?: armResourceIdentifier<[{ type: "Microsoft.ManagedIdentity/userAssignedIdentities" }]>;

  /** The execution boundary across which the identity is shared. */
  scope: ExecutionIdentityScope;
}

/** Identity configuration for a managed runtime. */
model RuntimeIdentityProfile {
  /** The identity made available to the execution runtime. */
  executionIdentity?: ExecutionIdentity;
}

/** Network configuration for a managed runtime. */
model RuntimeNetworkProfile {
  /** The customer-provided subnet used by the runtime. */
  subnetResourceId?: armResourceIdentifier<[{ type: "Microsoft.Network/virtualNetworks/subnets" }]>;

  /** Indicates who manages runtime egress. */
  egressMode?: EgressMode;
}

/** Read-only status shared by runtime binding variants. */
model RuntimeBindingReadOnlyProperties {
  /** The provisioning state of the runtime binding. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The provider resource created or referenced by the binding. */
  @visibility(Lifecycle.Read)
  providerResourceId?: armResourceIdentifier;
}

/** Common properties of managed and referenced runtime bindings. */
@discriminator("provisioningMode")
model RuntimeBindingProperties {
  ...RuntimeBindingReadOnlyProperties;

  /** The runtime technology represented by the binding. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  kind: RuntimeBindingKind;

  /** Indicates whether Workload Manager owns or references the runtime. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  provisioningMode: RuntimeBindingProvisioningMode;
}

/** Properties of a runtime provisioned and owned by Workload Manager. */
model ManagedRuntimeBindingProperties extends RuntimeBindingProperties {
  /** The runtime technology represented by the binding. */
  kind: RuntimeBindingKind;

  /** Indicates that Workload Manager owns the runtime. */
  provisioningMode: "Managed";

  /** The limited service-managed runtime configuration. */
  managedProfile: ManagedRuntimeProfile;

  /** The runtime identity configuration. */
  identityProfile?: RuntimeIdentityProfile;

  /** The runtime network configuration. */
  networkProfile?: RuntimeNetworkProfile;
}

/** Properties of a customer-owned runtime attached to a workload space. */
model ReferencedRuntimeBindingProperties extends RuntimeBindingProperties {
  /** The runtime technology represented by the binding. */
  kind: RuntimeBindingKind;

  /** Indicates that the runtime is customer-owned. */
  provisioningMode: "Referenced";

  /** The existing customer-owned runtime resource. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  resourceId: armResourceIdentifier;
}

/** A runtime participant in a workload space. */
@parentResource(WorkloadSpace)
model RuntimeBinding is TrackedResource<RuntimeBindingProperties> {
  ...ResourceNameParameter<
    Resource = RuntimeBinding,
    KeyName = "bindingName",
    SegmentName = "runtimeBindings",
    NamePattern = "^(?![.-])[A-Za-z0-9_.-]{1,64}$"
  >;
}

/** Identity configuration used to integrate runtime bindings. */
model RuntimeLinkIntegrationProfile {
  /** The user-assigned identity used by the provider integration. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  managedIdentityResourceId?: armResourceIdentifier<[{ type: "Microsoft.ManagedIdentity/userAssignedIdentities" }]>;
}

/** Capacity policy for the runtime composition. */
model CapacityProfile {
  /** The minimum number of execution nodes. */
  @minValue(0)
  minimumNodes: int32;

  /** The maximum number of execution nodes. */
  @minValue(0)
  maximumNodes: int32;
}

/** Properties of a relationship between runtime bindings. */
model RuntimeLinkProperties {
  /** The sibling runtime binding that provides orchestration. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  orchestratorBindingResourceId: armResourceIdentifier<[{ type: "Microsoft.Compute/workloadSpaces/runtimeBindings" }]>;

  /** The optional sibling runtime binding that provides execution. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  executionBindingResourceId?: armResourceIdentifier<[{ type: "Microsoft.Compute/workloadSpaces/runtimeBindings" }]>;

  /** The provider integration identity configuration. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  integrationProfile?: RuntimeLinkIntegrationProfile;

  /** The mutable capacity policy for the runtime composition. */
  capacityProfile?: CapacityProfile;

  /** The provisioning state of the runtime link. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The provider resource that realizes the runtime composition. */
  @visibility(Lifecycle.Read)
  providerResourceId?: armResourceIdentifier;
}

/** A relationship between an orchestrator runtime and an optional execution runtime. */
@parentResource(WorkloadSpace)
model RuntimeLink is TrackedResource<RuntimeLinkProperties> {
  ...ResourceNameParameter<
    Resource = RuntimeLink,
    KeyName = "linkName",
    SegmentName = "runtimeLinks",
    NamePattern = "^(?![.-])[A-Za-z0-9_.-]{1,64}$"
  >;
}

/** Properties of a capability enabled for a workload space. */
model CapabilityProperties {
  /** The capability to enable. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  kind: CapabilityKind;

  /** The version selection policy for the capability. */
  versionPolicy: VersionPolicy;

  /** The effective capability version selected by the service. */
  @visibility(Lifecycle.Read)
  effectiveVersion?: string;

  /** The provisioning state of the capability. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** A capability enabled for a workload space. */
@parentResource(WorkloadSpace)
model Capability is TrackedResource<CapabilityProperties> {
  ...ResourceNameParameter<
    Resource = Capability,
    KeyName = "capabilityName",
    SegmentName = "capabilities",
    NamePattern = "^(?![.-])[A-Za-z0-9_.-]{1,64}$"
  >;
}

/** Mutable properties of a workload space. */
model WorkloadSpaceUpdate
  is Azure.ResourceManager.Foundations.ResourceUpdateModel<WorkloadSpace, WorkloadSpaceProperties>;

/** Mutable properties of a runtime binding. */
model RuntimeBindingUpdate
  is Azure.ResourceManager.Foundations.ResourceUpdateModel<RuntimeBinding, RuntimeBindingMutableProperties>;

/** Binding-level configuration that may be updated without changing ownership. */
model RuntimeBindingMutableProperties {
  /** The runtime identity configuration. */
  identityProfile?: RuntimeIdentityProfile;

  /** The runtime network configuration. */
  networkProfile?: RuntimeNetworkProfile;
}

/** Mutable properties of a runtime link. */
model RuntimeLinkUpdate
  is Azure.ResourceManager.Foundations.ResourceUpdateModel<RuntimeLink, RuntimeLinkMutableProperties>;

/** Runtime link configuration that may be updated in place. */
model RuntimeLinkMutableProperties {
  /** The mutable capacity policy for the runtime composition. */
  capacityProfile?: CapacityProfile;
}

/** Mutable properties of a capability. */
model CapabilityUpdate
  is Azure.ResourceManager.Foundations.ResourceUpdateModel<Capability, CapabilityMutableProperties>;

/** Capability configuration that may be updated in place. */
model CapabilityMutableProperties {
  /** The version selection policy for the capability. */
  versionPolicy?: VersionPolicy;
}
