import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ContainerService;

/** The networking implementation managed by a cluster mesh profile. */
@added(Versions.v2026_12_02_preview)
union ClusterMeshKind {
  string,

  /** Fleet-managed Cilium cross-cluster networking. */
  Cilium: "cilium",

  /**
   * Fleet-managed ambient application networking, backed by Azure Kubernetes Application Network (AppNet).
   * The profile status describes the last Fleet membership apply operation, not continuous connectivity or health.
   * Applying means membership operations are in progress. Connected means all required joins and removals
   * completed successfully with members remaining. NotConnected means membership has not been applied
   * or a successful apply left no members. Failed means a required membership operation failed;
   * it does not imply that backing resources were removed. Parent provisioning success alone does not
   * imply Connected. No Degraded state is derived without a health signal.
   */
  Ambient: "ambient",
}

/** Service-owned information about the backing AppNet resource. */
@added(Versions.v2026_12_02_preview)
model AmbientClusterMeshProfileProperties {
  /** The backing AppNet resource ID. Its presence does not imply successful provisioning. */
  @visibility(Lifecycle.Read)
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AppLink/appLinks";
    }
  ]>;
}
