import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./VmSkus.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Versioning;

namespace Microsoft.ContainerService;

// =============================================================================
// Location-scoped operation groups
// =============================================================================

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Adding @armResourceOperations would inject an undesired resource-derived tag on these location-scoped operations."
interface ManagedClustersOperationGroup {
  /**
   * Contains extra metadata on the version, including supported patch versions, capabilities, available upgrades, and details on preview status of the version
   */
  @summary("Gets a list of supported Kubernetes versions in the specified subscription.")
  @tag("ManagedClusters")
  @autoRoute
  @get
  @action("kubernetesVersions")
  listKubernetesVersions is ArmProviderActionSync<
    Response = KubernetesVersionListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationResourceParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Adding @armResourceOperations would inject an undesired resource-derived tag on these location-scoped operations."
interface TrustedAccessRolesOperationGroup {
  /**
   * List supported trusted access roles.
   */
  @tag("TrustedAccess")
  @autoRoute
  @get
  @action("trustedAccessRoles")
  @list
  list is ArmProviderActionSync<
    Response = TrustedAccessRoleListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationResourceParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Adding @armResourceOperations would inject an undesired resource-derived tag on these location-scoped operations."
@added(Versions.v2026_09_02_preview)
interface ContainerServiceOperationGroup {
  /**
   * Lists available node images matching optional filters, in latest-only or bounded history mode.
   */
  @summary("Lists eligible node image versions for the specified configuration.")
  @autoRoute
  @get
  @list
  @action("nodeImageVersions")
  listNodeImageVersions is ArmProviderActionSync<
    Response = NodeImageVersionsListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationResourceParameter;
      ...NodeImageVersionListConfig;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Adding @armResourceOperations would inject an undesired resource-derived tag on these location-scoped operations."
@added(Versions.v2026_09_02_preview)
interface VmSkusOperationGroup {
  /**
   * Gets the list of VM SKUs accepted by AKS when creating node pools in a specified location. AKS will perform a best effort approach to provision the requested VM SKUs, but availability is not guaranteed.
   */
  @summary("Gets the list of VM SKUs accepted by AKS.")
  @tag("Skus")
  @autoRoute
  @get
  @list
  @action("vmSkus")
  list is ArmProviderActionSync<
    Response = VmSkusListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationResourceParameter;

      /**
       * To Include Extended Locations information or not in the response.
       */
      @query
      includeExtendedLocations?: boolean;
    }
  >;
}
