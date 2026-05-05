import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./AgentPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;

// =============================================================================
// AgentPoolUpgradeProfile resource and operations
// =============================================================================

/**
 * The list of available upgrades for an agent pool.
 */
@singleton("default")
@parentResource(AgentPool)
model AgentPoolUpgradeProfile
  is Azure.ResourceManager.ProxyResource<
    AgentPoolUpgradeProfileProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = AgentPoolUpgradeProfile,
    KeyName = "upgradeProfile",
    SegmentName = "upgradeProfiles",
    NamePattern = ""
  >;
}

@@doc(AgentPoolUpgradeProfile.name, "");
@@doc(AgentPoolUpgradeProfile.properties,
  "The properties of the agent pool upgrade profile."
);

@armResourceOperations(#{ omitTags: true })
interface AgentPoolUpgradeProfiles {
  /**
   * Gets the upgrade profile for an agent pool.
   */
  @tag("AgentPools")
  getUpgradeProfile is ArmResourceRead<AgentPoolUpgradeProfile>;
}

// =============================================================================
// AgentPoolUpgradeProfile models
// =============================================================================

/**
 * The list of available upgrade versions.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AKS uses custom provisioning states beyond standard ARM states. Using string type for forward compatibility."
model AgentPoolUpgradeProfileProperties {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  kubernetesVersion: string;

  /**
   * The operating system type. The default is Linux.
   */
  osType: OSType = OSType.Linux;

  /**
   * List of orchestrator types and versions available for upgrade.
   */
  @identifiers(#[])
  upgrades?: AgentPoolUpgradeProfilePropertiesUpgradesItem[];

  /**
   * List of components grouped by kubernetes major.minor version.
   */
  @added(Versions.v2025_10_02_preview)
  @identifiers(#[])
  componentsByReleases?: ComponentsByRelease[];

  /**
   * List of historical good versions for rollback operations.
   */
  @added(Versions.v2025_10_02_preview)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  recentlyUsedVersions?: AgentPoolRecentlyUsedVersion[];

  /**
   * The latest AKS supported node image version.
   */
  latestNodeImageVersion?: string;
}

/** Available upgrades for an AgentPool. */
model AgentPoolUpgradeProfilePropertiesUpgradesItem {
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

/**
 * A historical version that can be used for rollback operations.
 */
@added(Versions.v2025_10_02_preview)
model AgentPoolRecentlyUsedVersion {
  /**
   * The Kubernetes version (major.minor.patch) available for rollback.
   */
  orchestratorVersion?: string;

  /**
   * The node image version available for rollback.
   */
  nodeImageVersion?: string;

  /**
   * The timestamp when this version was last used.
   */
  timestamp?: utcDateTime;
}
