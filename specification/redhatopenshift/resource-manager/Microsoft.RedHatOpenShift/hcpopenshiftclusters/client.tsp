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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
  @doc("API profile for create/update operations, omitting server-side read-only field url.")
  model ApiProfileCreate {
    /** The internet visibility of the OpenShift API server. */
    visibility?: Visibility = Visibility.Public;

    /** The list of authorized IPv4 CIDR blocks allowed to access the API server. Maximum 500 entries. */
    @clientName("authorizedCIDRs")
    @maxItems(500)
    authorizedCidrs?: string[];
  }

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
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
}

@@alternateType(
  HcpOpenShiftClusters.createOrUpdate::parameters.resource,
  HcpOpenShiftClusterResourceCreate,
  "javascript"
);
