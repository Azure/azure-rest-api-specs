import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;

// =============================================================================
// ManagedClusterUpgradeProfile resource and operations
// =============================================================================

/**
 * The list of available upgrades for compute pools.
 */
@singleton("default")
@parentResource(ManagedCluster)
model ManagedClusterUpgradeProfile
  is Azure.ResourceManager.ProxyResource<
    ManagedClusterUpgradeProfileProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ManagedClusterUpgradeProfile,
    KeyName = "upgradeProfile",
    SegmentName = "upgradeProfiles",
    NamePattern = ""
  >;
}

@@doc(ManagedClusterUpgradeProfile.name, "");
@@doc(ManagedClusterUpgradeProfile.properties,
  "The properties of the upgrade profile."
);

@armResourceOperations(#{ omitTags: true })
interface ManagedClusterUpgradeProfiles {
  /**
   * Gets the upgrade profile of a managed cluster.
   */
  @tag("ManagedClusters")
  getUpgradeProfile is ArmResourceRead<ManagedClusterUpgradeProfile>;
}

// =============================================================================
// ManagedClusterUpgradeProfile models
// =============================================================================

/**
 * Control plane and agent pool upgrade profiles.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterUpgradeProfileProperties {
  /**
   * The list of available upgrade versions for the control plane.
   */
  controlPlaneProfile: ManagedClusterPoolUpgradeProfile;

  /**
   * The list of available upgrade versions for agent pools.
   */
  @identifiers(#[])
  agentPoolProfiles: ManagedClusterPoolUpgradeProfile[];
}

/**
 * The list of available upgrade versions.
 */
model ManagedClusterPoolUpgradeProfile {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  kubernetesVersion: string;

  /**
   * The Agent Pool name.
   */
  name?: string;

  /**
   * The operating system type. The default is Linux.
   */
  osType: OSType = OSType.Linux;

  /**
   * List of orchestrator types and versions available for upgrade.
   */
  @identifiers(#[])
  upgrades?: ManagedClusterPoolUpgradeProfileUpgradesItem[];

  /**
   * List of components grouped by kubernetes major.minor version.
   */
  @added(Versions.v2025_10_02_preview)
  @identifiers(#[])
  componentsByReleases?: ComponentsByRelease[];
}

/** Available upgrades for an AgentPool. */
model ManagedClusterPoolUpgradeProfileUpgradesItem {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  kubernetesVersion?: string;

  /**
   * Whether the Kubernetes version is currently in preview.
   */
  isPreview?: boolean;

  /**
   * Whether the Kubernetes version is out of support.
   */
  @added(Versions.v2025_10_02_preview)
  isOutOfSupport?: boolean;
}
