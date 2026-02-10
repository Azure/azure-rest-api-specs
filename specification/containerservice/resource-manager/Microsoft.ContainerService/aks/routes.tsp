import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Versioning;

namespace Microsoft.ContainerService;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@added(Versions.v2025_10_02_preview)
interface ContainerServiceOperationGroup {
  /**
   * Only returns the latest version of each node image. For example there may be an AKSUbuntu-1804gen2containerd-2024.01.26, but only AKSUbuntu-1804gen2containerd-2024.02.02 is visible in this list.
   */
  @summary("Gets a list of supported NodeImage versions in the specified subscription.")
  @autoRoute
  @get
  @list
  @action("nodeImageVersions")
  listNodeImageVersions is ArmProviderActionSync<
    Response = NodeImageVersionsListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationResourceParameter
  >;
}

interface Operations {
  /**
   * Gets a list of operations.
   */
  @tag("ManagedClusters")
  @autoRoute
  @segment("operations")
  @list
  list(
    ...CommonTypes.ApiVersionParameter,

    @doc("Microsoft.ContainerService provider")
    @path
    @segment("providers")
    provider: "Microsoft.ContainerService",
  ): ArmResponse<OperationListResult> | ErrorResponse;
}
