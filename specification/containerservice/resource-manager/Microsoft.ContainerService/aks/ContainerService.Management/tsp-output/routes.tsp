import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

interface ManagedClustersOperations {
  /**
   * Contains extra metadata on the version, including supported patch versions, capabilities, available upgrades, and details on preview status of the version
   */
  @summary("Gets a list of supported Kubernetes versions in the specified subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerService/locations/{location}/kubernetesVersions")
  @get
  listKubernetesVersions is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the Azure region.
       */
      @minLength(1)
      @path
      location: string;
    },
    KubernetesVersionListResult
  >;
}

interface TrustedAccessRolesOperations {
  /**
   * List supported trusted access roles.
   */
  @summary("List supported trusted access roles.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerService/locations/{location}/trustedAccessRoles")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the Azure region.
       */
      @minLength(1)
      @path
      location: string;
    },
    TrustedAccessRoleListResult
  >;
}
