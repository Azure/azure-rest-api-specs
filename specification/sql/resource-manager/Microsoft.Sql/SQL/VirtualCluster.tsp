import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL virtual cluster.
 */
model VirtualCluster
  is Azure.ResourceManager.TrackedResource<VirtualClusterProperties> {
  ...ResourceNameParameter<
    Resource = VirtualCluster,
    KeyName = "virtualClusterName",
    SegmentName = "virtualClusters",
    NamePattern = ""
  >;
}

@armResourceOperations
interface VirtualClusters {
  /**
   * Gets a virtual cluster.
   */
  get is ArmResourceRead<VirtualCluster>;

  /**
   * Creates virtual cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualCluster,
    Response = ArmResourceUpdatedResponse<VirtualCluster> | ArmResourceCreatedResponse<
      VirtualCluster,
      ArmLroLocationHeader<FinalResult = VirtualCluster> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates an existing virtual cluster.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    VirtualCluster,
    PatchModel = VirtualClusterUpdate
  >;

  /**
   * Deletes a virtual cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualCluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of virtual clusters in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<VirtualCluster>;

  /**
   * Gets a list of all virtualClusters in the subscription.
   */
  list is ArmListBySubscription<VirtualCluster>;

  /**
   * Synchronizes the DNS server settings used by the managed instances inside the given virtual cluster.
   */
  @action("updateManagedInstanceDnsServers")
  updateDnsServers is ArmResourceActionAsync<
    VirtualCluster,
    void,
    Response = UpdateVirtualClusterDnsServersOperation
  >;
}

@@doc(VirtualCluster.name, "The name of the virtual cluster.");
@@doc(VirtualCluster.properties, "Resource properties.");
@@doc(VirtualClusters.createOrUpdate::parameters.resource,
  "The requested virtual cluster resource state."
);
@@doc(VirtualClusters.update::parameters.properties,
  "The requested virtual cluster resource state."
);
