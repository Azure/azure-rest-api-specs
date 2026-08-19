import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./hcpCluster-models.tsp";

using Azure.ResourceManager;

namespace Microsoft.RedHatOpenShift;

/** HCP cluster operations */
@armResourceOperations(HcpOpenShiftCluster)
interface HcpOpenShiftClusters {
  get is ArmResourceRead<HcpOpenShiftCluster>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<HcpOpenShiftCluster>;
  update is ArmResourcePatchAsync<
    HcpOpenShiftCluster,
    HcpOpenShiftClusterProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<HcpOpenShiftCluster>;
  listByResourceGroup is ArmResourceListByParent<HcpOpenShiftCluster>;
  listBySubscription is ArmListBySubscription<HcpOpenShiftCluster>;

  /** Request a temporary admin kubeconfig for the cluster */
  requestAdminCredential is ArmResourceActionAsync<
    HcpOpenShiftCluster,
    void,
    HcpOpenShiftClusterAdminCredential
  >;
  /** Revoke all credentials issued by requestAdminCredential */
  revokeCredentials is ArmResourceActionNoResponseContentAsync<
    HcpOpenShiftCluster,
    void
  >;
}

/** HCP cluster node pools */
@armResourceOperations(NodePool)
interface NodePools {
  get is ArmResourceRead<NodePool>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NodePool>;
  update is ArmResourcePatchAsync<NodePool, NodePoolProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<NodePool>;
  listByParent is ArmResourceListByParent<NodePool>;
}

/** HCP cluster external auth config */
@armResourceOperations(ExternalAuth)
interface ExternalAuths {
  get is ArmResourceRead<ExternalAuth>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExternalAuth>;
  update is ArmResourcePatchAsync<ExternalAuth, ExternalAuthProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<ExternalAuth>;
  listByParent is ArmResourceListByParent<ExternalAuth>;
}
