import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "../models.tsp";
import "./ExternalResourceEnums.tsp";

using Azure.ResourceManager;
using Versioning;
using Rest;
using Http;

namespace Microsoft.NetApp;

/**
 * External SVM (Storage Virtual Machine, Vserver) resource, representing an SVM on an external NetApp ONTAP system
 */
@added(Versions.v2026_08_15_preview)
@parentResource(ExternalCluster)
model ExternalSvm
  is Azure.ResourceManager.TrackedResource<ExternalSvmProperties> {
  ...ResourceNameParameter<
    Resource = ExternalSvm,
    KeyName = "externalSvmName",
    SegmentName = "externalSvms",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;
}

/**
 * External SVM properties
 */
@added(Versions.v2026_08_15_preview)
model ExternalSvmProperties {
  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /**
   * Name of the external ONTAP SVM (different from Azure resource name). Must be unique across the cluster and cannot be changed once peering is established.
   */
  ontapSvmName: string;

  /**
   * Resource IDs of associated SVM Peer relationships
   */
  @visibility(Lifecycle.Read)
  svmPeerResourceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/externalClusters/clusterPeers/svmPeers";
    }
  ]>[];
}

/**
 * External SVM properties for PATCH operations
 */
@added(Versions.v2026_08_15_preview)
model ExternalSvmPatchProperties {
  /**
   * Name of the external ONTAP SVM (different from Azure resource name). Must be unique across the cluster and cannot be changed once peering is established.
   */
  ontapSvmName?: string;
}

/**
 * List of External SVM resources
 */
@added(Versions.v2026_08_15_preview)
model ExternalSvmList is Azure.Core.Page<ExternalSvm>;

@added(Versions.v2026_08_15_preview)
@armResourceOperations
interface ExternalSvms {
  /**
   * Get the External SVM resource
   */
  get is ArmResourceRead<ExternalSvm>;

  /**
   * Create or update the specified External SVM
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExternalSvm>;

  /**
   * Patch the specified External SVM
   */
  @patch
  update is ArmCustomPatchAsync<
    ExternalSvm,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ExternalSvm,
      ExternalSvmPatchProperties
    >,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ExternalSvm> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the specified External SVM
   */
  delete is ArmResourceDeleteWithoutOkAsync<ExternalSvm>;

  /**
   * List all External SVMs under an External Cluster
   */
  listByParent is ArmResourceListByParent<ExternalSvm>;
}
