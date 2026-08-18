import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.RedHatOpenShift;

// JavaScript SDK visibility workaround:
// For write operations whose body models contain server-side read-only properties
// that are also required, provide write-specific models that omit those fields so
// JS SDK users are not forced to supply server-computed values.
// Pattern: https://github.com/Azure/azure-rest-api-specs/pull/42784
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Write-only helper models for JS SDK alternate types; operations are defined on the original resources in hcpCluster.tsp"
namespace Microsoft.RedHatOpenShift {
  @doc("API profile for create/update operations, omitting server-side read-only field url.")
  model ApiProfileCreate {
    /** The internet visibility of the OpenShift API server. */
    visibility?: Visibility = Visibility.Public;

    /** The list of authorized IPv4 CIDR blocks allowed to access the API server. Maximum 500 entries. */
    @clientName("authorizedCIDRs")
    @maxItems(500)
    authorizedCidrs?: string[];
  }

  @doc("Azure platform configuration for create/update operations, omitting server-side read-only field issuerUrl.")
  model PlatformProfileCreate {
    /** Resource group name to put cluster resources. */
    managedResourceGroup?: string;

    /** The Azure resource ID of the worker subnet. */
    subnetId: SubnetResourceId;

    /** The Azure resource ID of the VNet integration subnet. */
    @added(Versions.v2025_12_23_preview)
    vnetIntegrationSubnetId: SubnetResourceId;

    /** The core outgoing configuration. */
    outboundType?: OutboundType = OutboundType.LoadBalancer;

    /** Resource ID for the NSG attached to the cluster subnet. */
    networkSecurityGroupId: NetworkSecurityGroupResourceId;

    /** The configuration for operator authentication to Azure. */
    operatorsAuthentication: OperatorsAuthenticationProfile;
  }

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Omitting provisioningState in this create/update model because it is a server-side read-only field"
  @doc("HCP cluster properties for create/update operations, omitting server-side read-only fields (console and status on the root model; api.url and platform.issuerUrl in nested models).")
  model HcpOpenShiftClusterPropertiesCreate {
    /** Version of the control plane components. */
    @madeRequired(Versions.v2025_12_23_preview)
    version: VersionProfile;

    /** Cluster DNS configuration. */
    dns?: DnsProfile;

    /** Cluster network configuration. */
    network?: NetworkProfile;

    /** Shows the cluster API server profile. */
    api?: ApiProfileCreate;

    /** The cluster ingress configuration. */
    @added(Versions.v2026_06_30_preview)
    ingress?: IngressProfile;

    /** Azure platform configuration. */
    platform: PlatformProfileCreate;

    /** Configure ClusterAutoscaling. */
    autoscaling?: ClusterAutoscalingProfile;

    /** Configure ETCD. */
    @removed(Versions.v2026_06_30_preview)
    @renamedFrom(Versions.v2026_06_30_preview, "etcd")
    etcdNoUpdate?: EtcdProfile;

    /** Configure ETCD. */
    @added(Versions.v2026_06_30_preview)
    etcd?: EtcdProfile;

    /** Rules to allow pulling images from mirrored registries by digest. */
    @added(Versions.v2025_12_23_preview)
    @identifiers(#["source"])
    @maxItems(240)
    imageDigestMirrors?: ImageDigestMirror[];

    /** Grace period in minutes for node draining during upgrades and scale operations. */
    @maxValue(10080)
    @minValue(0)
    nodeDrainTimeoutMinutes?: int32;

    /** OpenShift internal image registry. */
    clusterImageRegistry?: ClusterImageRegistryProfile;

    /** Cryptographic restrictions for kernel and userspace libraries. */
    @added(Versions.v2026_06_30_preview)
    cryptoRestrictions?: CryptoRestrictions = CryptoRestrictions.None;
  }

  @doc("HCP cluster resource for create/update operations.")
  model HcpOpenShiftClusterResourceCreate
    is TrackedResource<HcpOpenShiftClusterPropertiesCreate> {
    ...ResourceNameParameter<
      HcpOpenShiftClusterResourceCreate,
      KeyName = "hcpOpenShiftClusterName",
      SegmentName = "hcpOpenShiftClusters",
      NamePattern = "^[a-zA-Z]([-a-zA-Z0-9]{0,52}[a-zA-Z0-9])?$"
    >;
    ...ManagedServiceIdentityProperty;
  }

  /** Represents the node pool properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
  model NodePoolPropertiesUpdate {
    /** Provisioning state */
    @visibility(Lifecycle.Read)
    provisioningState?: ProvisioningState;

    /** OpenShift version for the nodepool */
    @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
    version?: NodePoolVersionProfile;

    /** Azure node pool platform configuration */
    @visibility(Lifecycle.Read, Lifecycle.Create)
    platform?: NodePoolPlatformProfile;

    /**
     * The number of worker nodes, it cannot be used together with autoscaling.
     * Validation:
     * - Minimum: 0
     * - Maximum: 200 (only when availabilityZone is not specified)
     * - No maximum when availabilityZone is specified
     */
    @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
    @minValue(0)
    replicas?: int32;

    /** Auto-repair */
    @visibility(Lifecycle.Read, Lifecycle.Create)
    autoRepair?: boolean = true;

    /** Representation of a autoscaling in a node pool. */
    @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
    autoScaling?: NodePoolAutoScaling;

    /** Kubernetes labels to propagate to the NodePool Nodes
     * Note that when the labels are updated this is only applied to newly
     * create nodes in the Nodepool, existing node labels remain unchanged.
     */
    @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
    @identifiers(#["key", "value"])
    labels?: Label[];

    /** Taints for the nodes */
    @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
    @identifiers(#["key", "value", "effect"])
    taints?: Taint[];

    /** nodeDrainTimeoutMinutes is the grace period for how long Pod Disruption Budget-protected workloads will be
     * respected during any node draining operation. After this grace period, any workloads protected by Pod Disruption
     * Budgets that have not been successfully drained from a node will be forcibly evicted. This is
     * especially relevant to cluster upgrades.
     *
     * Valid values are from 0 to 10080 minutes (1 week) .
     * 0 means that the NodePool can be drained without any time limitation.
     *
     * If unset the cluster nodeDrainTimeoutMinutes value is used as a default.
     */
    @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
    nodeDrainTimeoutMinutes?: int32;
  }
}

@@alternateType(
  HcpOpenShiftClusters.createOrUpdate::parameters.resource,
  HcpOpenShiftClusterResourceCreate,
  "javascript"
);

// The JavaScript SDK thinks properties required for resource creation
// are also required in PATCH request bodies. This is a bug in the SDK
// generation but we have to make validation pass regardless.

@Azure.Core.Foundations.omitKeyProperties
model HcpOpenShiftClusterUpdate is UpdateableProperties<HcpOpenShiftCluster>;

@@alternateType(
  HcpOpenShiftClusters.update::parameters.properties,
  HcpOpenShiftClusterUpdate,
  "javascript"
);

@@alternateType(
  NodePools.update::parameters.properties,
  UpdateableProperties<NodePoolProperties>,
  "javascript"
);
