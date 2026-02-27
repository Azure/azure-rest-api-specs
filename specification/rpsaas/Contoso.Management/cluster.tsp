import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";
import "./provisioningState.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Contoso;

/** Cluster resource */
model Cluster is TrackedResource<ClusterProperties> {
  ...ResourceNameParameter<Cluster>;
  ...ExtendedLocationProperty;
}

/** Cluster properties */
model ClusterProperties {
  /** The Cluster */
  cluster?: string;

  /** Data center of Cluster */
  dataCenter?: string;

  /** The dummy volume. */
  dummyVolume?: DummyVolumeProperties;

  /** The number of nodes. */
  nodes?: int32;

  /** The service account name. */
  serviceAccountName?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** DummyVolume properties */
model DummyVolumeProperties {
  /** The medium. */
  medium?: string;

  /** The size limit. */
  sizeLimit?: string;
}

@armResourceOperations
interface Clusters {
  get is ArmResourceRead<Cluster>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Cluster>;
  update is ArmResourcePatchSync<Cluster, ClusterProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Cluster>;
  listByResourceGroup is ArmResourceListByParent<Cluster>;
  listBySubscription is ArmListBySubscription<Cluster>;
}
